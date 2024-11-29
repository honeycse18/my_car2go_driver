import 'dart:async';
import 'dart:developer';

import 'package:car2godriver/controller/socket_controller.dart';
import 'package:car2godriver/models/api_responses/pulling_new_request_socket_response.dart';
import 'package:car2godriver/models/api_responses/pulling_request_status_socket_response.dart';
import 'package:car2godriver/models/api_responses/ride_details_response.dart';
import 'package:car2godriver/models/api_responses/ride_history_response.dart';
import 'package:car2godriver/models/api_responses/share_ride_history_response.dart';
import 'package:car2godriver/models/enums.dart';
import 'package:car2godriver/models/location_model.dart';
import 'package:car2godriver/models/screenParameters/accepted_request_screen_parameter.dart';
import 'package:car2godriver/models/screenParameters/choose_you_need_screen_parameter.dart';
import 'package:car2godriver/models/screenParameters/select_car_screen_parameter.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/datetime.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/utils/libraries/debouncer/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ScheduleRideListScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  TextEditingController cityController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;

  RideDetailsData rideDetails = RideDetailsData.empty();

  RxBool isShareRideTabSelected = false.obs;
  Rx<ShareRideHistoryStatus> selectedShareRideStatus =
      ShareRideHistoryStatus.unknown.obs;
  Rx<ShareRideActions> selectedActionForRideShare =
      ShareRideActions.unknown.obs;
  Rx<ShareRideHistoryStatus> shareRideTypeTab =
      ShareRideHistoryStatus.accepted.obs;
  PullingNewRequestSocketResponse newRequestOfferId =
      PullingNewRequestSocketResponse();
  PullingRequestStatusSocketResponse requestStatusSocketResponse =
      PullingRequestStatusSocketResponse();

  PagingController<int, ShareRideHistoryDoc> shareRideHistoryPagingController =
      PagingController(firstPageKey: 1);
  Debouncer debouncer = Debouncer();

  String get listLabel {
    final isCitySelected = cityController.text.isNotEmpty;
    final isCityNotSelected = isCitySelected == false;
    final isDateSelected = dateController.text.isNotEmpty;
    final isDateNotSelected = isDateSelected == false;
    if (isCityNotSelected && isDateNotSelected) {
      return '';
    }
    final buffer = StringBuffer('Showing by ');
    if (isCitySelected && isDateSelected) {
      buffer.write('location and date');
      return buffer.toString();
    }
    if (isCitySelected) {
      buffer.write('location');
      return buffer.toString();
    }
    if (isDateSelected) {
      buffer.write('date');
      return buffer.toString();
    }
    return buffer.toString();
  }

  void onSelectCityTextFieldTap() {}

  void onSelectCityClearButtonTap() {
    cityController.clear();
    update();
  }

  void onSelectDateClearButtonTap() {
    dateController.clear();
    selectedDate = null;
    update();
  }

  void onSelectDateTextFieldTap(BuildContext context) async {
    DateTime? pickedDate = await Helper.openDatePicker(
      context: context,
      selectedDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      helpText: 'Select schedule date',
    );
    if (pickedDate != null) {
      selectedDate = pickedDate;
      dateController.text = selectedDate!.formatted('dd MMM yyyy');
      update();
    }
  }

  void onShareRideTabTap(ShareRideHistoryStatus value) {
    shareRideTypeTab.value = value;

    update();
    log('Selected Action: ${selectedActionForRideShare.value.stringValueForView}\nSelected Tab: ${selectedShareRideStatus.value.stringValueForView}');
    shareRideHistoryPagingController.refresh();
  }

  onShareRideItemTap(String itemId, ShareRideHistoryDoc item, String type) {
    log('$itemId got tapped!');
    if (selectedActionForRideShare.value == ShareRideActions.myOffer) {
      Get.toNamed(AppPageNames.pullingOfferDetailsScreen,
          arguments: OfferOverViewScreenParameters(
              id: itemId, seat: item.seats, type: type));
    } else {
      if (item.offer.id.isEmpty) {
        Get.toNamed(AppPageNames.pullingOfferDetailsScreen, arguments: item.id);
      } else {
        log('$itemId Ride Got Tapped!');
        Get.toNamed(AppPageNames.pullingRequestDetailsScreen,
            arguments: itemId);
      }
    }
  }

  onRequestButtonTap(String requestId) async {
    log('$requestId got tapped!');
    await Get.toNamed(AppPageNames.viewRequestsScreen, arguments: requestId);
    shareRideHistoryPagingController.refresh();
  }

  void onRideWidgetTap(
    RideHistoryDoc ride,
  ) {
    log('${ride.id} got tapped');
    Get.toNamed(AppPageNames.acceptedRequestScreen,
        arguments: AcceptedRequestScreenParameter(
            rideId: ride.id,
            selectedCarScreenParameter: SelectCarScreenParameter(
                pickupLocation: LocationModel(
                    latitude: ride.from.location.lat,
                    longitude: ride.from.location.lng,
                    address: ride.from.address),
                dropLocation: LocationModel(
                    latitude: ride.to.location.lat,
                    longitude: ride.to.location.lng,
                    address: ride.to.address))));
  }

  /* <---- Get ride history from API ----> */
  Future<void> getShareRideHistory(currentPage) async {
    ShareRideHistoryResponse? response = await APIRepo.getShareRideHistory(
        page: currentPage,
        filter: shareRideTypeTab.value.stringValue,
        action: selectedActionForRideShare.value.stringValue ==
                ShareRideActions.unknown.stringValue
            ? ''
            : selectedActionForRideShare.value.stringValue);
    if (response == null) {
      log('No response for share Ride history list!');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessFetchingHistory(response);
  }

  onSuccessFetchingHistory(ShareRideHistoryResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      shareRideHistoryPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    shareRideHistoryPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  /*<----------- Get socket response for new pooling request ----------->*/
  dynamic onNewPullingRequest(dynamic data) async {
    if (data is PullingNewRequestSocketResponse) {
      newRequestOfferId = data;
      update();
      if (newRequestOfferId.offer.isNotEmpty) {
        shareRideHistoryPagingController.refresh();
      }
    }
  }

  /*<----------- Get socket response for pooling request status update ----------->*/
  dynamic onPullingRequestStatusUpdate(dynamic data) async {
    if (data is PullingRequestStatusSocketResponse) {
      requestStatusSocketResponse = data;
      update();
      if (requestStatusSocketResponse.status.isNotEmpty) {
        shareRideHistoryPagingController.refresh();
      }
    }
  }

  StreamSubscription<PullingNewRequestSocketResponse>? listen;
  StreamSubscription<PullingRequestStatusSocketResponse>? listen2;

  @override
  void onInit() {
    shareRideHistoryPagingController.addPageRequestListener((pageKey) {
      getShareRideHistory(pageKey);
    });
    SocketController socketController = Get.find<SocketController>();
    listen = socketController.pullingRequestResponseData.listen((p0) {});
    listen?.onData((data) {
      onNewPullingRequest(data);
    });
    listen2 = socketController.pullingRequestStatusResponseData.listen((p0) {});
    listen2?.onData((data) {
      onPullingRequestStatusUpdate(data);
    });
    cityController.addListener(
      () {
        debouncer.debounce(
          duration: const Duration(milliseconds: 400),
          onDebounce: () {
            update();
          },
        );
      },
    );
    super.onInit();
  }

/* <---- Initial state ----> */
  @override
  void onClose() {
    // listen?.cancel();
    // listen2?.cancel();
    cityController.dispose();
    dateController.dispose();
    debouncer.cancel();
    super.onClose();
  }

  void popScope() {
    // listen?.cancel();
    // listen2?.cancel();
  }
}
