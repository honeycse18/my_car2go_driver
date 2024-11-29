import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:car2godriver/controller/socket_controller.dart';
import 'package:car2godriver/models/api_responses/carpolling/pulling_offer_details_response.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/google_map_poly_lines_response.dart';
import 'package:car2godriver/models/api_responses/pulling_new_request_socket_response.dart';
import 'package:car2godriver/models/api_responses/pulling_request_status_socket_response.dart';

import 'package:car2godriver/models/location_model.dart';
import 'package:car2godriver/models/screenParameters/choose_you_need_screen_parameter.dart';
import 'package:car2godriver/ui/screens/bottomsheet/submit_otp_screen_bottomsheet.dart';

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

class PullingOfferDetailsScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  int totalseat = 0;
  String otp = '';
  RxBool pickUpPassengers = false.obs;
  late SocketController homeSocketScreenController;
  LocationModel pickupLocation = LocationModel.empty();
  LocationModel dropLocation = LocationModel.empty();
  final GlobalKey<ScaffoldState> bottomSheetFormKey =
      GlobalKey<ScaffoldState>();
  BitmapDescriptor? nearestCarIcon;
  BitmapDescriptor? nearestMotorCycleIcon;
  String requestId = '';
  String type = 'passenger';
  PullingOfferDetailsData offerDetails = PullingOfferDetailsData.empty();
  List<PullingOfferDetailsRequest> requests = [];
  PullingNewRequestSocketResponse newRequestOfferId =
      PullingNewRequestSocketResponse();
  PullingRequestStatusSocketResponse requestStatusSocketResponse =
      PullingRequestStatusSocketResponse();

  BitmapDescriptor pickUpIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropUpIcon = BitmapDescriptor.defaultMarker;

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

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
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

  /* <---- Icon for inside map ----> */

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }
  /* <---- Start ride button tap ----> */

  void onStartRideButtonTap() {
    pickUpPassengers.value = true;
    update();
    getRequestDetails();
    log(offerDetails.status);
    // Get.bottomSheet(RequestRideBottomsheet(),
    //     settings: RouteSettings(
    //       arguments: OfferOverViewBottomsheetScreenParameters(
    //           requestDetails: requestDetails, type: type, seat: totalseat),
    //     ),
    //     isScrollControlled: true);
  }

  /* <---- Start trip button tap ----> */
  void onStartTripTap() {
    onPickupButtonTap(offerDetails.requests.firstOrNull ??
        PullingOfferDetailsRequest.empty());
    getRequestDetails();
  }

  /* <---- Complete ride button tap ----> */
  void onCompleteRideButtonTap() {
    /* if (offerDetails.type == 'passenger') {
      dropPassenger(offerDetails.requests.firstOrNull ??
          PullingOfferDetailsRequest.empty());
    } */
    completeRide();
  }

  /* <---- Make payment tap ----> */
  void onMakePaymentTap() async {
    await AppDialogs.showConfirmPaymentDialog(
        amount: offerDetails.requests.firstOrNull?.rate ??
            offerDetails.rate * offerDetails.seats.toDouble(),
        symbol: offerDetails.requests.firstOrNull?.currency.symbol ??
            offerDetails.currency.symbol,
        titleText: AppLanguageTranslation
            .paymentConfirmationTranskey.toCurrentLanguage,
        totalAmount: offerDetails.requests.firstOrNull?.rate ??
            offerDetails.rate * offerDetails.seats.toDouble(),
        noButtonText: AppLanguageTranslation.cancelTranskey.toCurrentLanguage,
        yesButtonText:
            AppLanguageTranslation.confirmToPayTransKey.toCurrentLanguage,
        onYesTap: () async {
          await Get.toNamed(AppPageNames.selectPaymentMethodsScreen,
              arguments: offerDetails.requests.firstOrNull?.id);
        },
        onNoTap: () {
          Get.back();
        });

    /* dynamic res = await Get.toNamed(AppPageNames.makePaymentScreen,
        arguments: offerDetails.type == 'passenger'
            ? offerDetails.requests.firstOrNull?.id
            : offerDetails.id);
    if (res is bool && res) {
      completeRide();
      return;
    }
    AppDialogs.showErrorDialog(
        messageText: 'Please Make payment to complete this Trip!'); */
  }

  /* <---- Complete ride from API ----> */
  Future<void> completeRide() async {
    RawAPIResponse? response = await APIRepo.completeRide(offerDetails.id);
    if (response == null) {
      log('No response for completing ride!');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessCompletingRide(response);
  }

  onSuccessCompletingRide(RawAPIResponse response) {
    Get.back();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  /* <---- Pickup button tap----> */
  void onPickupButtonTap(PullingOfferDetailsRequest request) async {
    log('$requestId got Tapped!');
    if (request.status == 'accepted' && offerDetails.type == 'passenger') {
      pickUpPassengers.value = true;
      update();
      getRequestDetails();
      dynamic res = await Get.bottomSheet(const SubmitOtpStartRideBottomSheet(),
          settings: RouteSettings(arguments: request));
      if (res is bool && res) {
        getRequestDetails();
      }
    } else if (request.status == 'accepted') {
      dynamic res = await Get.bottomSheet(const SubmitOtpStartRideBottomSheet(),
          settings: RouteSettings(arguments: request));
      if (res is bool && res) {
        getRequestDetails();
      }
    } else if (request.status == 'started') {
      dropPassenger(request);
      if (offerDetails.type == 'passenger') {
        completeRide();
      }
    } else if (offerDetails.type == 'passenger' &&
        request.status == 'completed') {
      completeRide();
    }
    getRequestDetails();
  }

  /*<----------- Drop passenger----------->*/
  Future<void> dropPassenger(PullingOfferDetailsRequest request) async {
    final Map<String, dynamic> requestBody = {
      '_id': request.id,
      'status': 'completed'
    };
    RawAPIResponse? response =
        await APIRepo.startRideWithSubmitOtp(requestBody);
    if (response == null) {
      log('No response for Dropping Passenger!');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessDroppingPassenger(response);
  }

  onSuccessDroppingPassenger(RawAPIResponse response) {
    getRequestDetails();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  /*<----------- Get request details from API ----------->*/
  Future<void> getRequestDetails() async {
    PullingOfferDetailsResponse? response =
        await APIRepo.getPullingOfferDetails(requestId);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForThisActionTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingRequestDetails(response);
  }

  onSuccessRetrievingRequestDetails(PullingOfferDetailsResponse response) {
    offerDetails = response.data;
    requests = response.data.requests;
    update();
    _assignParameters();
  }

  /*<----------- Fetch screen navigation argument----------->*/
  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is OfferOverViewScreenParameters) {
      requestId = params.id;
      type = params.type;
      totalseat = params.seat;
      update();
      if (requestId.isNotEmpty) {
        getRequestDetails();
      }
    } else if (params is String) {
      requestId = params;
      if (requestId.isNotEmpty) {
        getRequestDetails();
      }
      update();
    }
  }

  /* <---- Get polylines from Google API ----> */
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
      APIHelper.onFailure(
          AppLanguageTranslation.errorHappenedTransKey.toCurrentLanguage);
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
        position: LatLng(pickupLocation.latitude, pickupLocation.longitude),
        icon: pickUpIcon));
    googleMapMarkers.add(Marker(
        markerId: MarkerId(dropMarkerId),
        position: LatLng(dropLocation.latitude, dropLocation.longitude),
        icon: dropUpIcon));
  }

  _assignParameters() async {
    _addPickUpAndDropMarkers();
    pickupLocation = LocationModel(
        address: offerDetails.from.address,
        latitude: offerDetails.from.location.lat,
        longitude: offerDetails.from.location.lng);
    dropLocation = LocationModel(
        latitude: offerDetails.to.location.lat,
        longitude: offerDetails.to.location.lng,
        address: offerDetails.to.address);
    update();
    getPolyLines(
        // googleMapPolyLines,
        pickupLocation.latitude,
        pickupLocation.longitude,
        dropLocation.latitude,
        dropLocation.longitude);
    update();
  }

  void createCarsLocationIcon() async {
    nearestCarIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)),
        AppAssetImages.nearestCar);
    nearestMotorCycleIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)),
        AppAssetImages.nearestMotorCycle);
    update();
  }

  /*<-----------Get socket response for new pooling request ----------->*/
  dynamic onNewPullingRequest(dynamic data) async {
    if (data is PullingNewRequestSocketResponse) {
      newRequestOfferId = data;
      update();
      if (newRequestOfferId.offer.isNotEmpty) {
        Helper.showSnackBar('Your offer has a new request.');
      }
    }
  }

  /*<-----------Get socket response for pooling request status update ----------->*/
  dynamic onPullingRequestStatusUpdate(dynamic data) async {
    if (data is PullingRequestStatusSocketResponse) {
      requestStatusSocketResponse = data;
      update();
      if (requestStatusSocketResponse.status.isNotEmpty) {
        if (requestId == requestStatusSocketResponse.request) {
          getRequestDetails();
        }
      }
    }
  }

  StreamSubscription<PullingNewRequestSocketResponse>? listen;
  StreamSubscription<PullingRequestStatusSocketResponse>? listen2;
  @override
  void onInit() {
    _getScreenParameters();

    SocketController socketController = Get.find<SocketController>();

    listen = socketController.pullingRequestResponseData.listen((p0) {});
    listen?.onData((data) {
      onNewPullingRequest(data);
    });
    listen2 = socketController.pullingRequestStatusResponseData.listen((p0) {});
    listen2?.onData((data) {
      onPullingRequestStatusUpdate(data);
    });
    super.onInit();
  }

/* <---- Initial state ----> */

  void popScope() {
    listen?.cancel();
    listen2?.cancel();
  }

  @override
  void onClose() {
    dispose();
    listen?.cancel();
    listen2?.cancel();
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
