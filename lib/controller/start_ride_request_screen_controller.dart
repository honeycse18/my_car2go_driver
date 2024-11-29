import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/google_map_poly_lines_response.dart';
import 'package:car2godriver/models/api_responses/ride_details_response.dart';
import 'package:car2godriver/models/api_responses/ride_history_response.dart';
import 'package:car2godriver/models/api_responses/ride_history_screen_list_response.dart';
import 'package:car2godriver/models/api_responses/user_details_response.dart';
import 'package:car2godriver/models/location_model.dart';
import 'package:car2godriver/models/screenParameters/accepted_request_screen_parameter.dart';
import 'package:car2godriver/ui/screens/bottomsheet/choose_reason_ride_cancel_bottomsheet.dart';
import 'package:car2godriver/ui/screens/bottomsheet/submit_otp_screen_bottomsheet.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StartRequestScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  UserDetailsData userDetailsData = UserDetailsData.empty();
  final GlobalKey<ScaffoldState> bottomSheetFormKey =
      GlobalKey<ScaffoldState>();
  RideDetailsData ridePrimaryDetails = RideDetailsData.empty();
  RideHistoryListItem rideHistoryData = RideHistoryListItem.empty();
  RideHistoryDoc rideData = RideHistoryDoc.empty();
  AcceptedRequestScreenParameter? screenParameter;

  String rideId = '';
  String paymentId = '';
  RxString status = 'unknown'.obs;
  String cancelReason = '';

  LatLng cameraPosition = const LatLng(0, 0);
  double zoomLevel = 12;
  double maxDistance = 0;
  late GoogleMapController googleMapController;
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolyLines = {};

  final pickupMarkerId = 'pickUpMarkerId';
  final dropMarkerId = 'dropMarkerId';
  final List<LocationModel> polyLinePoints = [];
  LocationModel? pickupLocation;
  LocationModel? dropLocation;
  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  _addPickUpAndDropMarkers() async {
    var pickupIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)),
        AppAssetImages.pickupMarkerPngIcon);
    var dropIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)),
        AppAssetImages.dropMarkerPngIcon);
    googleMapMarkers.add(Marker(
        markerId: MarkerId(pickupMarkerId),
        position: LatLng(pickupLocation!.latitude, pickupLocation!.longitude),
        icon: pickupIcon));
    googleMapMarkers.add(Marker(
        markerId: MarkerId(dropMarkerId),
        position: LatLng(dropLocation!.latitude, dropLocation!.longitude),
        icon: dropIcon));
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

  /*<----------- Google map poly line  ----------->*/
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
    /*
    pickupLocation!.latitude,
        pickupLocation!.longitude,
        dropLocation!.latitude,
        dropLocation!.longitude
    */
    if (bound != null) {
      googleMapController
          .animateCamera(CameraUpdate.newLatLngBounds(bound, 60));
      update();
    }

    // return LatLng(latitude, longitude);
  }

  /*<----------- Complete trip button tap ----------->*/
  void onCompleteTripButtonTap() {
    completeTrip();
  }

  /*<----------- Cancle trip button tap ----------->*/
  void onCancelTripButtonTap() async {
    dynamic res =
        await Get.bottomSheet(const ChooseReasonCancelRideBottomSheet());
    if (res is String) {
      cancelReason = res;
      completeTrip(cancelReason: cancelReason);
    }
  }

  /*<----------- Start trip button tap ----------->*/
  void onStartTripButtonTap() async {
    dynamic res = Get.bottomSheet(const SubmitOtpStartRideBottomSheet(),
        settings: RouteSettings(arguments: rideId));
    if (res is bool && res) {
      update();
    }
  }

  /*<----------- Complete trip  ----------->*/
  Future<void> completeTrip({String? cancelReason}) async {
    final Map<String, dynamic> requestBody = {
      '_id': rideId,
      'status': 'completed'
    };
    if (cancelReason != null && cancelReason.isNotEmpty) {
      requestBody['status'] = 'cancelled';
      requestBody['cancel_reason'] = cancelReason;
    }
    RawAPIResponse? response = await APIRepo.updateTripStatus(requestBody);
    if (response == null) {
      Helper.showSnackBar(AppLanguageTranslation
          .noResponseForCompletingTripTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessCompletingTrip(response);
  }

  onSuccessCompletingTrip(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    // Get.offAllNamed(AppPageNames.zoomDrawerScreen);
    Helper.getBackToHomePage();
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

  /*<----------- Fetch screen navigation argument----------->*/
  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is RideDetailsData) {
      ridePrimaryDetails = argument;
      rideId = ridePrimaryDetails.id;
      status.value = ridePrimaryDetails.status;
      cancelReason = ridePrimaryDetails.cancelReason;
      pickupLocation = LocationModel(
          latitude: ridePrimaryDetails.from.location.lat,
          longitude: ridePrimaryDetails.from.location.lng,
          address: ridePrimaryDetails.from.address);
      dropLocation = LocationModel(
          latitude: ridePrimaryDetails.to.location.lat,
          longitude: ridePrimaryDetails.to.location.lng,
          address: ridePrimaryDetails.to.address);

      update();
    } else if (argument is RideHistoryListItem) {
      rideHistoryData = argument;
      rideId = rideHistoryData.id;
      status.value = rideHistoryData.status;
      cancelReason = rideHistoryData.cancelReason;
      pickupLocation = LocationModel(
          latitude: rideHistoryData.from.location.lat,
          longitude: rideHistoryData.from.location.lng,
          address: rideHistoryData.from.address);
      dropLocation = LocationModel(
          latitude: rideHistoryData.to.location.lat,
          longitude: rideHistoryData.to.location.lng,
          address: rideHistoryData.to.address);
      update();
    } else if (argument is AcceptedRequestScreenParameter) {
      screenParameter = argument;
      rideId = screenParameter?.rideId ?? '';
      pickupLocation =
          screenParameter?.selectedCarScreenParameter.pickupLocation;
      dropLocation = screenParameter?.selectedCarScreenParameter.dropLocation;
      update();
    }
  }

  /*<----------- Ride details from API ----------->*/
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
    ridePrimaryDetails = response.data;
    status.value = ridePrimaryDetails.status;
    paymentId = ridePrimaryDetails.payment.transactionId;
    cancelReason = ridePrimaryDetails.cancelReason;
    pickupLocation = LocationModel(
        latitude: ridePrimaryDetails.from.location.lat,
        longitude: ridePrimaryDetails.from.location.lng,
        address: ridePrimaryDetails.from.address);
    dropLocation = LocationModel(
        latitude: ridePrimaryDetails.to.location.lat,
        longitude: ridePrimaryDetails.to.location.lng,
        address: ridePrimaryDetails.to.address);
    update();
  }

/* <---- Initial state ----> */
  @override
  void onInit() {
    userDetailsData = Helper.getUser() as UserDetailsData;
    _getScreenParameter();
    _assignParameters();
    getRideDetails();

    super.onInit();
  }
}
