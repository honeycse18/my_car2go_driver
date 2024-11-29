import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:car2godriver/models/api_responses/common/location_position.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/api_response.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/dashboard_api_response.dart';
import 'package:car2godriver/models/api_responses/dashboard_police_response.dart';
import 'package:car2godriver/models/api_responses/get_wallet_details_response.dart';
import 'package:car2godriver/models/api_responses/profile_details.dart';
import 'package:car2godriver/models/api_responses/user_details_response.dart';
import 'package:car2godriver/models/api_responses/vehicle_online_offline_response.dart';
import 'package:car2godriver/models/location_model.dart';
import 'package:car2godriver/services/profile_service.dart';
import 'package:car2godriver/utils/app_singleton.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class HomeScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  final profileService = Get.find<ProfileService>();
  StreamSubscription<ProfileDetails>? profileUpdateSubscriber;
  ProfileDetails get userDetailsData => profileService.profileDetails;
  set userDetailsData(ProfileDetails value) {
    profileService.profileDetails = value;
  }

  WalletDetailsItem walletDetails = WalletDetailsItem.empty();
  PoliceData policeData = PoliceData.empty();
  RxBool isTapped = false.obs;
  bool status = true;

  String rideId = '';
  GoogleMapController? myMapController;
  final String userMarkerID = 'userID';
  final String markerID = 'markerID';
  Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  GoogleMapController? googleMapController;
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolylines = {};
  GoogleMapController? mapController;
  LocationModel? currentDriverLocation;
  Position? _currentPosition;

  bool _isOnlineOffline = false;
  bool get isOnlineOffline => _isOnlineOffline;
  set isOnlineOffline(bool value) {
    _isOnlineOffline = value;
    update();
  }

  LatLng myLatLng = const LatLng(0, 0);
  DashBoardData dashBoardData = DashBoardData();

  BitmapDescriptor? myCarIcon;

  /* <---- Get dash board data details from API ----> */
  Future<void> getDashBoardDataDetails() async {
    DashboardApiResponse? response = await APIRepo.getDashBoardDetails('ride');
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
    _onSuccessGetDashBoard(response);
  }

  void _onSuccessGetDashBoard(DashboardApiResponse response) async {
    dashBoardData = response.data;
    update();
  }

  /*<----------- Google map button tap ----------->*/
  void onGoogleMapTap(LatLng latLng) async {
    _focusLocation(latitude: latLng.latitude, longitude: latLng.longitude);
    // panelController.open();
  }

  late loc.Location location;
  Rx<LatLng> userLocation = Rx<LatLng>(const LatLng(0.0, 0.0));
  Future<LocationModel?> getCurrentPosition() async {
    final BuildContext? context = Get.context;
    if (context == null) {
      return null;
    }
    return await _getCurrentPosition(context);
  }

  /* <---- Get wallet details from API ----> */
  Future<void> getWalletDetails() async {
    GetWalletDetailsResponse? response = await APIRepo.getWalletDetails();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetWalletDetails(response);
  }

  void onSuccessGetWalletDetails(GetWalletDetailsResponse response) {
    walletDetails = response.data;
    update();
  }

  /*<----------- Get Location from google API----------->*/
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

  /*<----------- Get Location permission from google API----------->*/
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
        Helper.showSnackBar(AppLanguageTranslation
            .locationPermissionDeniedTranskey.toCurrentLanguage);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Helper.showSnackBar(AppLanguageTranslation
          .permissionsPermanentlyDeniedCannotrequestTranskey.toCurrentLanguage);
      return false;
    }
    return true;
  }

  /*<----------- request location permission from API----------->*/
  Future<void> _requestPermission() async {
    final hasPermission = await location.hasPermission();
    if (hasPermission == loc.PermissionStatus.denied) {
      await location.requestPermission();
    }
  }

  bool validateOnOnlineOfflineUpdate() {
    if (userDetailsData.vehicle.isNoVehicleRegistered) {
      AppDialogs.showErrorDialog(
          titleText: 'No vehicle added',
          messageText: 'Please add a vehicle first');
      return false;
    }
    if (userDetailsData.vehicle.active.isActive == false) {
      AppDialogs.showErrorDialog(
          titleText: 'No vehicle is active',
          messageText: 'Please active a vehicle first');
      return false;
    }
    return true;
  }

  /*<----------- Status update button tap ----------->*/
  void onStatusUpdateToggle(bool value) async {
    if (validateOnOnlineOfflineUpdate() == false) {
      return;
    }
    // isOnlineOffline = !isOnlineOffline;
    // update();
    final currentLocation = await getCurrentLocation();
    if (currentLocation == null) {
      AppDialogs.showErrorDialog(
          messageText:
              'Failed to get location. Please turn on you GPS then try again');
      return;
    }
    vehicleStatusOnline(
        isOnline: value,
        currentLocation: LocationPosition(
            lat: currentLocation.latitude!, lng: currentLocation.longitude!));
    // checkRideStatus();
  }

  /*<----------- Vahicle status from API----------->*/
  Future<void> vehicleStatusOnline(
      {required bool isOnline,
      required LocationPosition currentLocation}) async {
    Map<String, dynamic> requestBody = {
      'isOnline': isOnline,
      'location': currentLocation.toJson(),
    };
    final response = await APIRepo.updateVehicleStatusOnlineOffline(
        requestBody: requestBody);
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);
      return;
    }
    _onSuccessOnlineVehicle(response);
  }

  void _onSuccessOnlineVehicle(
      APIResponse<VehicleOnlineOfflineResponse> response) {
    isOnlineOffline = response.data.isOnline;
    Helper.showSnackBar(response.message);
    update();
  }

  /*<----------- Check ride status from API----------->*/
  Future<void> checkRideStatus() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseFoundForThisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      Helper.logout();
      Get.snackbar(
          AppLanguageTranslation.sessionExpiredTranskey.toCurrentLanguage,
          AppLanguageTranslation
              .sessionExpiredLoginAgainTranskey.toCurrentLanguage);
      // AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    _onSuccessGetLoggedInUserDetails(response);
  }

  void _onSuccessGetLoggedInUserDetails(UserDetailsResponse response) async {
    // TODO: Save current driver details into local storage
    // await Helper.setLoggedInUserToLocalStorage(response.data as ProfileDetails);

    UserDetailsRide? userDetailsRide = response.data.ride;
    if (userDetailsRide.id.isNotEmpty) {
      rideId = userDetailsRide.id;
      update();
      final LocationModel? locationModel = await getCurrentPosition();
      if (locationModel == null) {
        isOnlineOffline = false;
      } else {
        isOnlineOffline = !isOnlineOffline;
      }
      Map<String, dynamic> requestBody = {
        'ride': rideId,
        'online': isOnlineOffline
      };
      if (locationModel != null) {
        Map<String, dynamic> location = {
          'lat': currentDriverLocation?.latitude,
          'lng': currentDriverLocation?.longitude
        };
        requestBody['location'] = location;
      }
      updateDriverzStatus(requestBody);
      update();
    } /* else {
      if (response.data.driver.status == AppConstants.ownerStatusPending) {
        AppDialogs.receiveOwnerRequestDialog(
            image: response.data.driver.owner.image,
            messageText:
                '${response.data.driver.owner.name} ${AppLanguageTranslation.wantsToAddYouAsDriverTransKey.toCurrentLanguage}',
            onYesTap: () async {
              acceptOwnerRequest(response.data.driver.id);
            },
            onNoTap: () async {
              cancelOwnerRequest(response.data.driver.id);
            });
      }
    } */
  }

  /*<----------- Get logged diver details from API----------->*/
  Future<void> getLoggedDriverDetails() async {
    final APIResponse<ProfileDetails>? response =
        await APIRepo.getProfileUpdated();
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      Helper.logout();
      APIHelper.onFailure(
        AppLanguageTranslation.sessionExpiredTranskey.toCurrentLanguage,
      );
      return;
    }
    log((response
            .toJson(
              (data) => data.toJson(),
            )
            .toString())
        .toString());
    _onSuccessGetUserDetails(response);
  }

  void _onSuccessGetUserDetails(APIResponse<ProfileDetails> response) async {
    // Apply Asking for Documents Like License Number, NID card front + back images here...

    userDetailsData = response.data;
    isOnlineOffline = userDetailsData.vehicle.active.isOnline;
    update();
    /* await Helper.setLoggedInUserToLocalStorage(response.data);
    BuildContext? context = Get.context;
    if (context != null) {
      // Get.toNamed(AppPageNames.zoomDrawerScreen);
      AppDialogs.showSuccessDialog(messageText: 'Login Success');
    } */
  }

  Future<void> updateSavedDriverDetails() async {
    final APIResponse<ProfileDetails>? response =
        await APIRepo.getProfileUpdated();
    if (response == null) {
      APIHelper.onFailure(
        AppLanguageTranslation.sessionExpiredTranskey.toCurrentLanguage,
      );
      return;
    } else if (response.error) {
      Helper.logout();
      APIHelper.onFailure(response.message);
      return;
    }
    final profileDetails = response.data;
    await Helper.setLoggedInUserToLocalStorage(profileDetails);
    try {
      final profileService = Get.find<ProfileService>();
      profileService.profileDetails = profileDetails;
    } catch (_) {}
    _onSuccessGetUserDetails(response);
  }

  /*<----------- Get dashboard emergency data details ----------->*/
  Future<void> getDashBoardEmergencyDetails() async {
    DashboardPoliceResponse? response =
        await APIRepo.getDashBoardEmergencyDataDetails();
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
    _onSuccessGetDashBoarDataEmergency(response);
  }

  void _onSuccessGetDashBoarDataEmergency(
      DashboardPoliceResponse response) async {
    policeData = response.data;
    update();
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
  Future<loc.LocationData?> getCurrentLocation() async {
    try {
      final loc.LocationData myCurrentLocation = await location.getLocation();
      myLatLng = LatLng(
        myCurrentLocation.latitude!,
        myCurrentLocation.longitude!,
      );
      userLocation.value = myLatLng;
      _focusLocation(
          latitude: myLatLng.latitude,
          longitude: myLatLng.longitude,
          showRiderLocation: true);

      // log('${userLocation.value}');
      log('${myLatLng.latitude}');
      return myCurrentLocation;
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  /*<----------- Focus location on Map----------->*/
  Future<void> _focusLocation(
      {required double latitude,
      required double longitude,
      bool showRiderLocation = false}) async {
    final latLng = LatLng(latitude, longitude);
    if (googleMapController == null) {
      return;
    }
    if (showRiderLocation) {
      _addTapMarker(latLng);
    } else {
      _addMarker(latLng);
    }
    final double zoomLevel = await googleMapController!.getZoomLevel();
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: zoomLevel)));
    AppSingleton.instance.defaultCameraPosition =
        CameraPosition(target: latLng, zoom: zoomLevel);
    update();
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  Future<void> _addMarker(LatLng latLng) async {
/*     googleMapMarkers.removeWhere((element) {
      return element.markerId.value != riderMarkerID;
    }); */
    final context = Get.context;
    if (context != null) {
      // final ImageConfiguration config = createLocalImageConfiguration(context);
      /* gpsIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)),
        AppAssetImages.carGPSImage,
      ); */
    }

    googleMapMarkers.add(Marker(
        markerId: MarkerId(markerID), position: latLng, icon: myCarIcon!));
  }

  void createCarsLocationIcon() async {
    int aspectSize = (Get.context!.devicePixelRatio * 30).toInt();
    final Uint8List? markerIcon = await getBytesFromAsset(
        AppAssetImages.selectedLocationPNGImage, aspectSize);
    // final Marker marker = Marker(icon: BitmapDescriptor.fromBytes(markerIcon!), markerId: MarkerId(markerID),);
    if (markerIcon != null) {
      myCarIcon = BitmapDescriptor.fromBytes(markerIcon);
    }

    /*  myCarIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
            size: Size(context.devicePixelRatio * 1200,
                context.devicePixelRatio * 1250)),
        AppAssetImages.selectedLocationPNGImage); */

    update();
  }

  /// onTap take location event on map
  Future<void> _addTapMarker(LatLng latLng) async {
    // BitmapDescriptor? gpsIcon;
    final context = Get.context;
    if (context != null) {
      /* final ImageConfiguration config = createLocalImageConfiguration(context);
      gpsIcon = await BitmapDescriptor.fromAssetImage(
        config,
        AppAssetImages.carGPSImage,
      ); */
    }
    googleMapMarkers.add(Marker(
        markerId: MarkerId(userMarkerID),
        anchor: const Offset(0.5, 0.5),
        position: latLng,
        icon: myCarIcon!));
  }

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    // googleMapControllerCompleter.complete(controller);
  }

  /* <---- Initial state ----> */
  @override
  void onInit() async {
    // userDetailsData = profileService.profileDetails;
    isOnlineOffline = userDetailsData.vehicle.active.isOnline;
    profileUpdateSubscriber ??= profileService.profileDetailsRX.listen((data) {
      isOnlineOffline = userDetailsData.vehicle.active.isOnline;
      update();
    });
    getWalletDetails();
    getDashBoardDataDetails();
    // getLoggedDriverDetails();
    getLoggedDriverDetails();
    getDashBoardEmergencyDetails();
    location = loc.Location();

    super.onInit();
    // userDetailsData = Helper.getUser();

    createCarsLocationIcon();

    // Request permission if not granted
    await _requestPermission();
    getCurrentLocation();
  }

  @override
  void onClose() {
    profileUpdateSubscriber?.cancel();
    profileUpdateSubscriber = null;
    super.onClose();
  }
}
