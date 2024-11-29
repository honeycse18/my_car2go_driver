import 'dart:async';
import 'dart:developer';
import 'package:app_links/app_links.dart';
import 'package:car2godriver/ui/screens/bottomsheet/recieve_ride_bottomsheet.dart';
import 'package:car2godriver/ui/screens/car_pooling/requests_car_pooling.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:car2godriver/controller/socket_controller.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/new_driver_socket_response.dart';
import 'package:car2godriver/models/api_responses/pulling_new_request_socket_response.dart';
import 'package:car2godriver/models/api_responses/pulling_request_status_socket_response.dart';
import 'package:car2godriver/models/api_responses/ride_share_request_socket_response.dart';
import 'package:car2godriver/models/api_responses/user_details_response.dart';
import 'package:car2godriver/models/location_model.dart';
import 'package:car2godriver/ui/screens/auth/login_screen.dart';
import 'package:car2godriver/ui/screens/home_navigator/home_screen.dart';
import 'package:car2godriver/ui/screens/registration/create_new_password_screen.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeNavigatorScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  LatLng myLatLng = const LatLng(0, 0);
  late final AppLinks _appLinks;
  UserDetailsData userDetails = UserDetailsData.empty();
  PullingNewRequestSocketResponse newRequestOfferId =
      PullingNewRequestSocketResponse();
  PullingRequestStatusSocketResponse requestStatusSocketResponse =
      PullingRequestStatusSocketResponse();
  NewDriverSocketResponse newDriverData = NewDriverSocketResponse.empty();
  RideShareRequestSocketResponse rideShareRequest =
      RideShareRequestSocketResponse.empty();
  SocketController? socketController;

  /// Controller to handle PageView and also handles initial page
  int currentIndex = 0;
  final isGpsEnabled = false.obs;
  bool isOnline = false;
  final isLoading = false.obs;
  final isLoading2 = false.obs;
  LocationModel? currentDriverLocation;
  Position? _currentPosition;

  ///
  // final pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final notchBottomBarController = NotchBottomBarController(index: 0);

  int maxCount = 5;
  String get titleText {
    switch (currentIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Request';
      case 2:
        return 'My Trip';
      case 3:
        return 'Wallet';

      default:
        return '';
    }
  }

  @override
  void dispose() {
    // pageController.dispose();
    super.dispose();
  }

  /* <----  widget list ----> */
  final List<Widget> bottomBarPages = [
    const HomeScreen(),
    const RequestCarPullingScreen(),
    const LoginScreen(),
    const CreateNewPasswordScreen(),
  ];
  /*<-----------Get socket response for new pooling request ----------->*/
  dynamic onNewPullingRequest(dynamic data) async {
    if (data is PullingNewRequestSocketResponse) {
      newRequestOfferId = data;
      update();
      if (newRequestOfferId.offer.isNotEmpty) {
        AppDialogs.showSuccessDialog(
            messageText: AppLanguageTranslation
                .youHaveNewRequestTranskey.toCurrentLanguage);
      }
    }
  }

  /*<-----------Get socket response for pooling request status update ----------->*/
  dynamic onPullingRequestStatusUpdate(dynamic data) async {
    if (data is PullingRequestStatusSocketResponse) {
      requestStatusSocketResponse = data;
      update();
      if (requestStatusSocketResponse.status.isNotEmpty) {
        AppDialogs.showSuccessDialog(
            messageText: AppLanguageTranslation
                .yourRequestHasUpdateTranskey.toCurrentLanguage);
      }
    }
  }

  /*<-----------Get socket response for new ride request ----------->*/
  dynamic onNewRideRequest(dynamic data) {
    log('data socket');
    RideShareRequestSocketResponse? response =
        RideShareRequestSocketResponse.empty();
    if (data is RideShareRequestSocketResponse) {
      response = data;
      update();
    }
    log(response.toJson().toString());
    if (response.id.isNotEmpty) {
      rideShareRequest = response;
      update();
      Get.bottomSheet(const ReceiveRideBottomSheetScreen(),
          isDismissible: false,
          enableDrag: false,
          isScrollControlled: false,
          settings: RouteSettings(arguments: rideShareRequest));
    }
  }

  /*<-----------Get socket response for new driver request ----------->*/
  dynamic onNewDriverRequest(dynamic data) {
    log('new Driver request socket');
    NewDriverSocketResponse? response = NewDriverSocketResponse.empty();
    if (data is NewDriverSocketResponse) {
      response = data;
      update();
    }
    log(response.toJson().toString());
    if (response.id.isNotEmpty) {
      newDriverData = response;
      update();
      AppDialogs.showSuccessDialog(
          messageText: AppLanguageTranslation
              .youHaveNewDriverRequestTranskey.toCurrentLanguage);
    }
  }

  /*<----------- Fetch screen navigation argument----------->*/
  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument != null) {
      if (argument is int) {
        currentIndex = argument;
      }
    }
  }

  void getMyRideStatus() {
    fetchRideDetails();
  }

  /*<----------- Check ride status from API----------->*/
  Future<void> checkUserDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInUserDetails(response);
  }

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) async {
    // await Helper.setLoggedInUserToLocalStorage(response.data as ProfileDetails); // TODO: uncomment this line with updated get profile detail API response
    userDetails = response.data;
    // if (userDetails.vehicle.id.isEmpty) {
    if (userDetails.isVehicleNotRegistered) {
      Helper.showSnackBar('Please add vehicle first');
      await Get.toNamed(AppPageNames.addVehicleScreen);
      await Helper.refreshLoggedInUserDetails();
    }
    if (userDetails.isSubscriptionNotBought) {
      Helper.showSnackBar('Please buy subscription to start trip');
      await Get.toNamed(AppPageNames.tripPermitScreen);
      await Helper.refreshLoggedInUserDetails();
    }
    String rideId = '';
    UserDetailsRide? userDetailsRide = response.data.ride;
    if (userDetailsRide.isNotEmpty) {
      rideId = userDetailsRide.id;
      update();
      final LocationModel? locationModel = await getCurrentPosition();
      if (locationModel == null) {
        isOnline = false;
      } else {
        isOnline = !isOnline;
      }
      Map<String, dynamic> requestBody = {'ride': rideId, 'online': isOnline};
      if (locationModel != null) {
        Map<String, dynamic> location = {
          'lat': myLatLng.latitude,
          'lng': myLatLng.longitude
        };
        requestBody['location'] = location;
      }
      updateDriverzStatus(requestBody);
      update();
    }
  }

  late loc.Location location;
  Rx<LatLng> userLocation = Rx<LatLng>(const LatLng(0.0, 0.0));
  Future<loc.LocationData?> getCurrentLocation() async {
    try {
      final loc.LocationData myCurrentLocation = await location.getLocation();
      myLatLng = LatLng(
        myCurrentLocation.latitude!,
        myCurrentLocation.longitude!,
      );
      userLocation.value = myLatLng;

      // log('${userLocation.value}');
      log('${myLatLng.latitude}');
      return myCurrentLocation;
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  /*<----------- update driver status from API----------->*/
  Future<void> updateDriverzStatus(Map<String, dynamic> requestBody) async {
    RawAPIResponse? response = await APIRepo.updateDriverStatus(requestBody);
    if (response == null) {
      // AppDialogs.showErrorDialog(messageText: 'No response for status update!');
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      // AppDialogs.showErrorDialog(messageText: response.msg);
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    // isOnline = !isOnline;
    update();
  }

  /*<----------- Get current location from google API----------->*/
  Future<LocationModel?> getCurrentPosition() async {
    final BuildContext? context = Get.context;
    if (context == null) {
      return null;
    }
    return await _getCurrentPosition(context);
  }

  /*<----------- Get current location from google API----------->*/
  Future<LocationModel?> _getCurrentPosition(BuildContext context) async {
    final bool hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) {
      log('No permission acquired!');
      return null;
    }
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // locationTextEditingController.text = await latLngToAddress(
      //     _currentPosition?.latitude ?? 0, _currentPosition?.longitude ?? 0);
      // _focusLocation(
      //     latitude: _currentPosition?.latitude ?? 0,
      //     longitude: _currentPosition?.longitude ?? 0);
      currentDriverLocation = _currentPosition == null
          ? null
          : LocationModel(
              latitude: _currentPosition!.latitude,
              longitude: _currentPosition!.longitude);
      update();
      return currentDriverLocation;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  /*<----------- Handle location permission from API----------->*/
  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      /* Helper.showSnackBar(
          'Location services are disabled. Please enable the services'); */

      AppDialogs.showAcceptLocationDialouge(
          messageText: AppLanguageTranslation
              .chooseYourLocationStartFindRequestAroundYouTranskey
              .toCurrentLanguage,
          onYesTap: () async {
            await Geolocator.openLocationSettings();
          });
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
            AppLanguageTranslation.locationPermissionTranskey.toCurrentLanguage,
            AppLanguageTranslation
                .locationPermissionDeniedTranskey.toCurrentLanguage);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
          AppLanguageTranslation
              .locationPermissionDeniedTranskey.toCurrentLanguage,
          AppLanguageTranslation
              .permissionsPermanentlyDeniedCannotrequestTranskey
              .toCurrentLanguage);
      return false;
    }
    return true;
  }

  /*<----------- Fetch ride details from API----------->*/
  Future<void> fetchRideDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseWhilefetchingRideDetailsTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessGettingUserDetails(response);
  }

  onSuccessGettingUserDetails(UserDetailsResponse response) {
    UserDetailsRide ride = response.data.ride;
    if (ride.online) {
      isOnline = true;
    } else {
      isOnline = false;
    }
    update();
  }

  Future<void> firebaseTokenUpdate() async {
    final Map<String, dynamic> requestBodyJson = {};
    final String? fcmToken = await Helper.getFCMToken;
    if (Helper.isUserLoggedIn()) {
      requestBodyJson['fcm_token'] = fcmToken;
      log(requestBodyJson.toString());
      RawAPIResponse? response = await APIRepo.fcmUpdate(requestBodyJson);
      if (response == null) {
        log('fcm token not updated');
        return;
      } else if (response.error) {
        // AppDialogs.showErrorDialog(messageText: response.msg);
        log('');
        return;
      }
    }
  }

  Future<void> _checkAllStatuses() async {
    getMyRideStatus();
    checkUserDetails();
  }

  void _initDeepLinkListener() async {
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        if (uri.path == '/package_buy') {
          Get.toNamed(
            AppPageNames.tripPermitScreen,
          );
        }
      }
    });
  }

  StreamSubscription<PullingNewRequestSocketResponse>? listen;
  StreamSubscription<PullingRequestStatusSocketResponse>? listen2;
  StreamSubscription<RideShareRequestSocketResponse>? listen6;
  StreamSubscription<NewDriverSocketResponse>? listen7;
  /* <---- Initial state ----> */
  @override
  void onInit() {
    _appLinks = AppLinks();
    firebaseTokenUpdate();
    getCurrentLocation();
    _initDeepLinkListener();
    location = loc.Location();
    try {
      socketController = Get.find<SocketController>();
    } catch (_) {}
    // SocketController socketController = Get.put<SocketController>(SocketController());
    // SocketController socketController = Get.find<SocketController>();

    listen = socketController?.pullingRequestResponseData.listen((p0) {
      onNewPullingRequest(p0);
    });
    listen2 = socketController?.pullingRequestStatusResponseData.listen((p0) {
      onPullingRequestStatusUpdate(p0);
    });

    listen6 = socketController?.rideShareRequest.listen((p0) {
      onNewRideRequest(p0);
    });
    listen7 = socketController?.newDriverSocketData.listen((p0) {
      onNewDriverRequest(p0);
    });
    // userDetails = Helper.getUser() as UserDetailsData;
    _getScreenParameter();
    _checkAllStatuses();

    super.onInit();
  }

  void popScope() {
    listen?.cancel();
    listen2?.cancel();
    listen6?.cancel();
    listen7?.cancel();
  }

  @override
  void onClose() {
    // socket.disconnect();
    // socket.close();
    // socket.dispose();
    listen?.cancel();
    listen2?.cancel();
    listen6?.cancel();
    listen7?.cancel();
    super.onClose();
  }
}
