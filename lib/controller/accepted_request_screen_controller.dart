import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:car2godriver/controller/socket_controller.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/google_map_poly_lines_response.dart';
import 'package:car2godriver/models/api_responses/nearest_cars_list_response.dart';
import 'package:car2godriver/models/api_responses/ride_details_response.dart';
import 'package:car2godriver/models/api_responses/ride_request_socket_update_status.dart';
import 'package:car2godriver/models/enums.dart';
import 'package:car2godriver/models/location_model.dart';

import 'package:car2godriver/models/payment_option_model.dart';
import 'package:car2godriver/models/screenParameters/accepted_request_screen_parameter.dart';
import 'package:car2godriver/models/screenParameters/submit_review_screen_parameter.dart';
import 'package:car2godriver/ui/screens/bottomsheet/choose_reason_ride_cancel_bottomsheet.dart';
import 'package:car2godriver/ui/screens/bottomsheet/select_payment_method_bottomSheet.dart';
import 'package:car2godriver/ui/screens/bottomsheet/submit_review_bottomSheet.dart';

import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:url_launcher/url_launcher.dart';

class AcceptedRequestScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  SelectPaymentOptionModel getValues = SelectPaymentOptionModel();
  String otp = '';
  String value = '';
  AcceptedRequestScreenParameter? screenParameter;
  // late SocketController homeSocketScreenController;
  LocationModel? pickupLocation;
  LocationModel? dropLocation;
  // List<LatLng> nearestCars = [];
  List<NearestCarsListRide> rides = [];
  // bool chainRequest = false;
  List<NearestCarsListCategory> categories = [];
  NearestCarsListRide? selectedRide;
/*   final GlobalKey<ScaffoldState> bottomSheetFormKey =
      GlobalKey<ScaffoldState>(); */
  BitmapDescriptor? nearestCarIcon;
  BitmapDescriptor? nearestMotorCycleIcon;
  BitmapDescriptor pickUpIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropUpIcon = BitmapDescriptor.defaultMarker;
  String rideId = '';
  RideDetailsData rideDetails = RideDetailsData.empty();
  RideHistoryStatus ridePostAcceptanceStatus = RideHistoryStatus.accepted;

  RideRequestStatus? rideRequestStatus;
  RxBool rideAccepted = false.obs;

  final pickupMarkerId = 'pickUpMarkerId';
  final dropMarkerId = 'dropMarkerId';
  // double zoomLevel = 12;
  late GoogleMapController googleMapController;
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolyLines = {};
  LatLng cameraPosition = const LatLng(0, 0);
  final List<LocationModel> polyLinePoints = [];
  double zoomLevel = 12;
  double maxDistance = 0;

  IO.Socket socket = IO.io(
      AppConstants.appBaseURL,
      IO.OptionBuilder()
          // .setAuth(Helper.getAuthHeaderMap())
          .setAuth(<String, String>{
        'token': Helper.getUserToken()
      }).setTransports(['websocket']) // for Flutter or Dart VM
          .build());

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    // googleMapControllerCompleter.complete(controller);
    /* LatLngBounds;
    final bound = boundsFromLatLngList([
      LatLng(pickupLocation!.latitude, pickupLocation!.longitude),
      LatLng(dropLocation!.latitude, dropLocation!.longitude)
    ]);
    /*
    pickupLocation!.latitude,
        pickupLocation!.longitude,
        dropLocation!.latitude,
        dropLocation!.longitude
    */
    if (bound != null) {
      googleMapController
          .animateCamera(CameraUpdate.newLatLngBounds(bound, 15));
    } */
  }

  /*<-----------Get socket response for ride request status ----------->*/
  dynamic onRideRequestStatus(dynamic data) async {
    log('data socket');
    RideRequestUpdateSocketResponse? response =
        RideRequestUpdateSocketResponse.fromJson(data);
    log(response.toJson().toString());
    if (response.status.isNotEmpty) {
      rideRequestStatus = RideRequestStatus.toEnumValue(response.status);
      update();
    }
    if (rideRequestStatus?.stringValue ==
        RideRequestStatus.accepted.stringValue) {
      rideAccepted.value = true;
      Get.back();
      Get.toNamed(AppPageNames.acceptedRequestScreen, arguments: response.ride);
    } else {
      rideAccepted.value = false;
      Get.back();
    }
    log('back getting called');
    update();
    await Future.delayed(const Duration(seconds: 1));
    update();
  }

  void computeCentroid(List<LocationModel> points) {
    double latitude = 0;
    double longitude = 0;
    LocationModel eastMost = LocationModel(latitude: 0, longitude: -180);
    LocationModel westMost = LocationModel(latitude: 0, longitude: 180);
    LocationModel northMost = LocationModel(latitude: -180, longitude: 0);
    LocationModel southMost = LocationModel(latitude: 180, longitude: 0);

    for (LocationModel point in points) {
      if (point.longitude > eastMost.longitude) {
        eastMost = point;
      }
      if (point.longitude < westMost.longitude) {
        westMost = point;
      }
      if (point.latitude > northMost.latitude) {
        northMost = point;
      }
      if (point.latitude < southMost.latitude) {
        southMost = point;
      }
    }
    log('EastMost: ${eastMost.longitude}\nWestMost: ${westMost.longitude}\nNorthMost: ${northMost.latitude}\nSouthMost: ${southMost.latitude}');
    latitude = ((northMost.latitude + southMost.latitude) / 2);
    longitude = ((eastMost.longitude + westMost.longitude) / 2);
    log('Centroid:\nLatitude: $latitude  Longitude: $longitude');

    final bound = boundsFromLatLngList([
      LatLng(eastMost.latitude, eastMost.longitude),
      LatLng(westMost.latitude, westMost.longitude),
      LatLng(southMost.latitude, southMost.longitude),
      LatLng(northMost.latitude, northMost.longitude)
    ]);

    if (bound != null) {
      googleMapController
          .animateCamera(CameraUpdate.newLatLngBounds(bound, 60));
      update();
    }

    // return LatLng(latitude, longitude);
  }

  /* <---- Reset list button tap ----> */
  onResetListButtonTap() {
    selectedRide = null;
    update();
    getList();
  }

  void getNearestCarsList() {
    getList();
  }

  /* <---- Get nearest car list from google API ----> */
  Future<void> getList() async {
    NearestCarsListResponse? response = await APIRepo.getNearestCarsList(
        lat: pickupLocation?.latitude ?? 0,
        lng: pickupLocation?.longitude ?? 0,
        destLat: dropLocation?.latitude ?? 0,
        destLng: dropLocation?.longitude ?? 0);
    if (response == null) {
      APIHelper.onError(response?.msg ??
          AppLanguageTranslation
              .noResponseFoundTryAgainTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingNearestCarsList(response);
  }

  void onSuccessRetrievingNearestCarsList(NearestCarsListResponse response) {
    rides = response.data.rides;
    categories = response.data.categories;
    update();
    updateNearestCarsList();
    log('Nearest cars list fetched successfully!');
    return;
  }

  void onCategoryClick(String categoryId) async {
    dynamic res = await AppDialogs.showConfirmDialog(
        messageText: AppLanguageTranslation
            .areYouSureSendBatchRequestsCarsUnderThisCategoryTransKey
            .toCurrentLanguage,
        onYesTap: () async {
          Get.back(result: true);
        },
        onNoTap: () {
          Get.back(result: false);
        },
        shouldCloseDialogOnceYesTapped: false);
    if (res is bool) {
      doActionForCategoryClick(categoryId, res);
    }
  }
  /* <---- Category wise ride request send function ----> */

  Future<void> doActionForCategoryClick(
      String categoryId, bool runBatchRequests) async {
    NearestCarsListResponse? response = await APIRepo.getNearestCarsList(
        lat: pickupLocation?.latitude ?? 0,
        lng: pickupLocation?.longitude ?? 0,
        destLat: dropLocation?.latitude ?? 0,
        destLng: dropLocation?.longitude ?? 0,
        categoryId: categoryId);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: response?.msg ??
              AppLanguageTranslation
                  .noResponseFoundTryAgainTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessGettingCategoryWiseVehicles(response, runBatchRequests);
  }

  onSuccessGettingCategoryWiseVehicles(
      NearestCarsListResponse response, bool runBatchRequests) {
    rides = response.data.rides;
    selectedRide = null;
    update();
    updateNearestCarsList();
    if (runBatchRequests) {
      sendBatchRideRequests();
    }
  }

  void updateNearestCarsList() {
    googleMapMarkers.clear();
    _addPickUpAndDropMarkers();
    for (final (int, NearestCarsListRide) singleRide in rides.indexed) {
      singleRide.$1;
      BitmapDescriptor icon;
      // if(singleRide.vehicle.category == 'car'){icon = }
      icon = nearestCarIcon!;
      googleMapMarkers.add(Marker(
          markerId: MarkerId('nearestCar-${singleRide.$1}'),
          position:
              LatLng(singleRide.$2.location.lat, singleRide.$2.location.lng),
          icon: icon));
    }
    update();
    // log('Cars Location List: ${nearestCars.toString()}');
    // for (int i = 0; i < nearestCars.length; i++) {
    //   LatLng carLocation = nearestCars[i];
    //   googleMapMarkers.add(Marker(
    //       markerId: MarkerId('nearestCar-$i'),
    //       position: LatLng(carLocation.latitude, carLocation.longitude),
    //       icon: nearestMotorCycleIcon!));
    // }
  }

  Future<void> sendBatchRideRequests() async {
    for (NearestCarsListRide currentRide in rides) {
      selectedRide = currentRide;
      // chainRequest = true;
      update();
      onBottomButtonTap(showDialogue: false);
      /* if (!chainRequest) {
        AppDialogs.showErrorDialog(messageText: 'Chain is broken!');
        selectedRide = null;
        update();
        return;
      } */
    }
    AppDialogs.showSuccessDialog(
        messageText: AppLanguageTranslation
            .requestHaveBeenSentDriversUnderThisCategoryTransKey
            .toCurrentLanguage);
    await Future.delayed(const Duration(seconds: 10));
    AppDialogs.showErrorDialog(
        messageText: AppLanguageTranslation
            .noDriverAcceptedYourRequestUnfortunatelyTransKey
            .toCurrentLanguage);
    selectedRide = null;
    update();
  }

  void onRideTap(NearestCarsListRide theRide) async {
    /* if (chainRequest) {
      dynamic res = await AppDialogs.showConfirmDialog(
          messageText: 'Are you sure to break the chain request?',
          onYesTap: () async {
            Get.back(result: true);
          },
          shouldCloseDialogOnceYesTapped: false,
          onNoTap: () async {
            Get.back(result: false);
          });
      if (res is bool && !res) {
        return;
      }
    }
    chainRequest = false; */
    if (selectedRide == theRide) {
      selectedRide = null;
    } else {
      selectedRide = theRide;
    }
    update();
  }

  void onSelectPaymentmethod({bool showDialogue = true}) async {
    final value = await Get.bottomSheet(const SelectPaymentMethodBottomsheet());
    if (value is SelectPaymentOptionModel) {
      getValues = value;
    }
    update();
  }

  void onBottomButtonTap({bool showDialogue = true}) async {
    String reason = 'No reason found';
    final Map<String, dynamic> requestBody = {
      '_id': rideId,
    };
    if (ridePostAcceptanceStatus.stringValue ==
        RideHistoryStatus.accepted.stringValue) {
      dynamic res =
          await Get.bottomSheet(const ChooseReasonCancelRideBottomSheet());
      if (res is String) {
        reason = res;
        update();

        requestBody['status'] = 'cancelled';
        requestBody['cancel_reason'] = reason;
        cancelRide(requestBody);
      }
    } /*  else if (ridePostAcceptanceStatus.stringValue ==
        RideHistoryStatus.started.stringValue) {
      
      return;
    } */
    log(reason);
    log(ridePostAcceptanceStatus.stringValueForView);
  }
  /* <---- Ride Cancel Function ----> */

  Future<void> cancelRide(Map<String, dynamic> requestBody) async {
    RawAPIResponse? response = await APIRepo.updateRideStatus(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: response?.msg ??
              AppLanguageTranslation
                  .noResponseFoundTryAgainTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessCancellingRide(response);
  }

  onSuccessCancellingRide(RawAPIResponse response) {
    Get.back();
    Get.back();
    AppDialogs.showSuccessDialog(
        messageText: AppLanguageTranslation
            .rideHasBeenCancelledSuccessfullyTranskey.toCurrentLanguage);
  }
/* 
  Future<void> requestRide(
      Map<String, dynamic> requestBody, bool showDialogue) async {
    // String requestBodyJson = jsonEncode(requestBody);
    RawAPIResponse? response = await APIRepo.requestForRide(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: 'No response for Ride Now action!');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRequestingForRide(response, showDialogue);
  }

  onSuccessRequestingForRide(RawAPIResponse response, bool showDialogue) {
    // if (!chainRequest) {
    //   Get.back();
    //   Get.back();
    // }
    if (showDialogue) {
      AppDialogs.showActionableDialog(
        titleText: 'Request Ongoing',
        titleTextColor: AppColors.darkColor,
        messageText: 'Your Ride request is ongoing...',
        buttonText: 'Cancel Request',
        onTap: () {
          // if (!rideAccepted) {
          //   Get.back();
          // }
          // Implement Ride Request cancel API
        },
      );
    }
  } */

  /* double computeMaxDistance(List<LocationModel> points, LatLng centroid) {
    double maximumDistance = 0;
    for (LocationModel point in points) {
      double dx = centroid.latitude - point.latitude;
      double dy = centroid.longitude - point.longitude;
      double distance = math.sqrt(dx * dx + dy * dy);
      if (distance > maxDistance) {
        maximumDistance = distance;
      }
    }
    log('Maximum Distance: $maximumDistance');
    return maximumDistance;
  } */

  /* double logBase(num x, num base) => math.log(x) / math.log(base);

  double getZoomLevel(double maxDistance) {
    double screenWidth = Get.width;
    double distInMeters = maxDistance * 111139;
    zoomLevel = logBase((distInMeters / (distInMeters * 256)), 2) - 1;
    log('ScreenWidth: $screenWidth\nzoomLevel: $zoomLevel');
    zoomLevel = 13;
    return zoomLevel < 0 ? 1 : zoomLevel;
  } */

//Payment function

  Future<void> onPaymentTap() async {
    Map<String, dynamic> requestBody = {
      '_id': rideId,
      'method': getValues.value,
    };
    RawAPIResponse? response = await APIRepo.onPaymentTap(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    getValues.value == 'paypal'
        ? _onSucessPaymentStatus(response)
        : _onSucessWalletPaymentStatus(response);
  }

  _onSucessPaymentStatus(RawAPIResponse response) async {
    await launchUrl(Uri.parse(response.data));
    update();
    // Get.offAllNamed(AppPageNames.zoomDrawerScreen);
    Helper.getBackToHomePage();
    _initializeAfterDelay(response);
  }

  _onSucessWalletPaymentStatus(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
    // Get.offAllNamed(AppPageNames.zoomDrawerScreen);
    Helper.getBackToHomePage();
  }

  _initializeAfterDelay(RawAPIResponse response) async {
    await Future.delayed(const Duration(seconds: 3));
    AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
  }

  /* <---- Get ride details from API ----> */
  Future<void> getRideDetails() async {
    RideDetailsResponse? response = await APIRepo.getRideDetails(rideId);
    if (response == null) {
      APIHelper.onError(response?.msg ??
          AppLanguageTranslation
              .noResponseFoundTryAgainTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingRideDetails(response);
  }

  onSuccessRetrievingRideDetails(RideDetailsResponse response) {
    otp = response.data.otp;
    rideDetails = response.data;
    update();
  }

  /*<----------- Fetch screen navigation argument----------->*/
  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is AcceptedRequestScreenParameter) {
      screenParameter = params;
      rideId = screenParameter?.rideId ?? '';
      pickupLocation =
          screenParameter?.selectedCarScreenParameter.pickupLocation;
      dropLocation = screenParameter?.selectedCarScreenParameter.dropLocation;
      update();
      if (rideId.isNotEmpty) {
        getRideDetails();
      }
    }
  }

  void submitReview() {
    Get.bottomSheet(const SubmitReviewBottomSheetScreen(),
        settings: RouteSettings(
            arguments:
                SubmitReviewScreenParameter(id: rideDetails.id, type: 'ride')));
  }

  /* <---- Get poly lines from google API ----> */
  Future<void> getPolyLines(
      /* Set<Polyline> googleMapPolyLines, */ double orLat,
      double orLong,
      double tarLat,
      double tarLong) async {
    GoogleMapPolyLinesResponse? response =
        await APIRepo.getRoutesPolyLines(orLat, orLong, tarLat, tarLong);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noPolylinesFoundForThisRouteTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(AppLanguageTranslation
          .errorHappendWhileRetrievingPolylinesTransKey.toCurrentLanguage);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingPolyLines(response);
  }

  void onSuccessRetrievingPolyLines(GoogleMapPolyLinesResponse response) {
    List<LatLng> pointLatLngs = [];
    for (var route in response.routes) {
      for (var leg in route.legs) {
        for (var step in leg.steps) {
          pointLatLngs.addAll(decodePolyline(step.polyline.points));
        }
      }
    }

    googleMapPolyLines.add(Polyline(
      polylineId: const PolylineId('thePolyLine'),
      color: Colors.teal,
      width: 3,
      points: pointLatLngs,
    ));

    polyLinePoints.clear();
    for (var point in pointLatLngs) {
      polyLinePoints.add(
          LocationModel(latitude: point.latitude, longitude: point.longitude));
    }

    computeCentroid(polyLinePoints);
    update();
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      poly.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return poly;
  }

  _addPickUpAndDropMarkers() async {
    int aspectSize = (Get.context!.devicePixelRatio * 30).toInt();
    final Uint8List? pickIcon =
        await getBytesFromAsset(AppAssetImages.pickupMarkerPngIcon, aspectSize);

    if (pickIcon != null) {
      pickUpIcon = BitmapDescriptor.fromBytes(pickIcon);
    }
    final Uint8List? dropIcon =
        await getBytesFromAsset(AppAssetImages.dropMarkerPngIcon, aspectSize);

    if (dropIcon != null) {
      dropUpIcon = BitmapDescriptor.fromBytes(dropIcon);
    }

    googleMapMarkers.add(Marker(
        markerId: MarkerId(pickupMarkerId),
        position: LatLng(pickupLocation!.latitude, pickupLocation!.longitude),
        icon: pickUpIcon));
    googleMapMarkers.add(Marker(
        markerId: MarkerId(dropMarkerId),
        position: LatLng(dropLocation!.latitude, dropLocation!.longitude),
        icon: dropUpIcon));
  }

  _assignParameters() async {
    _addPickUpAndDropMarkers();
    /* googleMapPolyLines.add(Polyline(
        polylineId: PolylineId('polyLineId'),
        color: Colors.blue,
        points: [
          LatLng(pickupLocation!.latitude, pickupLocation!.longitude),
          LatLng(dropLocation!.latitude, dropLocation!.longitude),
        ],
        width: 5)); */
    getPolyLines(
        // googleMapPolyLines,
        pickupLocation!.latitude,
        pickupLocation!.longitude,
        dropLocation!.latitude,
        dropLocation!.longitude);
    update();
  }

//===============for icon ============
  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }
  //============icon elements end===========

  void createCarsLocationIcon() async {
    int aspectSize = (Get.context!.devicePixelRatio * 30).toInt();
    /* nearestCarIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Si ze(70, 70)),
        AppAssetImages.nearestCar); */

    final Uint8List? markerIcon =
        await getBytesFromAsset(AppAssetImages.nearestCar, aspectSize);

    if (markerIcon != null) {
      nearestCarIcon = BitmapDescriptor.fromBytes(markerIcon);
    }

    update();
  }

  /* <---- Ride request status update ----> */
  dynamic onRideRequestStatusUpdate(dynamic data) async {
    if (data is RideDetailsData) {
      rideDetails = data;
      update();
      ridePostAcceptanceStatus =
          RideHistoryStatus.toEnumValue(rideDetails.status);
      update();
      AppDialogs.showSuccessDialog(
          messageText:
              '${AppLanguageTranslation.rideHasBeenTransKey.toCurrentLanguage} ${ridePostAcceptanceStatus.stringValueForView}!');
    }
    log('Ride is updated!');
  }

  StreamSubscription<RideDetailsData>? listen;
  /* <---- Initial state ----> */
  @override
  void onInit() {
    _getScreenParameters();
    SocketController socketScreenController =
        Get.put<SocketController>(SocketController());
    // SocketController socketScreenController = Get.find<SocketController>();
    /* ever(selectCarScreenController.rideDetails, (rideDetailsDynamicData) {
      onRideRequestStatusUpdate(rideDetailsDynamicData);
    }); */

    listen = socketScreenController.rideDetails.listen((p0) {
      onRideRequestStatusUpdate(p0);
    });
    createCarsLocationIcon();
    // getNearestCarsList();
    /* if (!socket.connected) {
      _initSocket();
    } */
    _assignParameters();

    super.onInit();
  }

  @override
  void dispose() {
    listen?.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    dispose();
    socket.disconnect();
    socket.close();
    socket.dispose();
    // Get.reset();
    super.onClose();
  }

  LatLngBounds? boundsFromLatLngList(List<LatLng> list) {
    if (list.isEmpty) {
      return null;
    }
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null || x1 == null || y0 == null || y1 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }

    return LatLngBounds(
        northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }
}
