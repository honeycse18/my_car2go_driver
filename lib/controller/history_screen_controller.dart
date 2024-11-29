import 'dart:async';
import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/ride_history_response.dart';
import 'package:car2godriver/models/api_responses/ride_request_response.dart';
import 'package:car2godriver/models/api_responses/user_details_response.dart';
import 'package:car2godriver/models/enums.dart';
import 'package:car2godriver/models/location_model.dart';
import 'package:car2godriver/models/screenParameters/accepted_request_screen_parameter.dart';
import 'package:car2godriver/models/screenParameters/select_car_screen_parameter.dart';
import 'package:car2godriver/ui/screens/bottomsheet/view_schedule_ride_details_bottomsheet.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RideHistoryListScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  RxBool isShareRideTabSelected = false.obs;
  UserDetailsData userDetails = UserDetailsData.empty();

  // RxBool isPendingTabSelected = false.obs;
  PagingController<int, RideHistoryDoc> rideHistoryPagingController =
      PagingController(firstPageKey: 1);
  String status = '';

  Rx<RideHistoryStatusEnum> selectedStatus = RideHistoryStatusEnum.pending.obs;
  List<RideHistoryDoc> pendingRideList = [];

  String dropdownvalue = 'Rent';
  RideHistoryDoc? previousDate(int currentIndex, RideHistoryDoc date) {
    log(currentIndex.toString());
    final previousIndex = currentIndex - 1;
    if (previousIndex == -1) {
      return null;
    }
    RideHistoryDoc? previousNotification =
        rideHistoryPagingController.value.itemList?[previousIndex];
    return previousNotification;
    // return notification.previousNotification;
  }

  bool isDateChanges(
      RideHistoryDoc notification, RideHistoryDoc? previousDate) {
    if (previousDate == null) {
      return true;
    }
    final notificationDate = DateTime(notification.createdAt.year,
        notification.createdAt.month, notification.createdAt.day);
    final previousNotificationDate = DateTime(previousDate.createdAt.year,
        previousDate.createdAt.month, previousDate.createdAt.day);
    Duration dateDifference =
        notificationDate.difference(previousNotificationDate);
    return (dateDifference.inDays >= 1 || (dateDifference.inDays <= -1));
  }

  /*<----------- Ride widget button tap ----------->*/
  void onRideWidgetTap(
    RideHistoryDoc ride,
  ) {
    log('${ride.id} got tapped');
    Get.toNamed(AppPageNames.startRideRequestScreen,
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

  /* // List of items in our dropdown menu
  var items = [
    'Rent',
    'Ride',
  ]; */

  /*<----------- Pending ride button tap ----------->*/
  void onPendingRideTabTap(RideHistoryStatusEnum value) {
    getPendingRideRequestResponse();
    selectedStatus.value = value;
    update();
    rideHistoryPagingController.refresh();
  }

  /*<----------- Ride button tap ----------->*/
  void onRideTabTap(RideHistoryStatusEnum value) {
    selectedStatus.value = value;
    update();
    rideHistoryPagingController.refresh();
  }

  void onTabTap(RideHistoryStatusEnum value) {
    selectedStatus.value = value;
    rideHistoryPagingController.refresh();
    update();
  }

  /*<----------- Accept reject ride request----------->*/
  Future<void> acceptRejectRideRequest(String rideId, RideStatus status) async {
    Map<String, dynamic> requestBody = {
      '_id': rideId,
      'status': status.stringValue
    };
    RawAPIResponse? response =
        await APIRepo.acceptRejectRideRequest(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseFoundForThisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessUpdateRideRequest(response, status);
  }

  _onSuccessUpdateRideRequest(
      RawAPIResponse response, RideStatus status) async {
    if (status == RideStatus.accepted) {
      Get.bottomSheet(const StartRideBottomSheetScreen(),
          settings: RouteSettings(arguments: response.data));
    }
    await getPendingRideRequestResponse();
    AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
  }

  /*<----------- Get pending ride request from API ----------->*/
  Future<void> getPendingRideRequestResponse() async {
    RideRequestResponse? response =
        await APIRepo.getPendingRideRequestResponse();
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseFoundForThisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetPendingRideRequestResponse(response);
  }

  void onSuccessGetPendingRideRequestResponse(RideRequestResponse response) {
    pendingRideList = response.data;
    update();
  }

  //------------Get Method----------------

  /*<----------- Get ride history list from API ----------->*/
  Future<void> getRideHistoryList(int currentPageNumber) async {
    final String key = selectedStatus.value.stringValue;
    rideHistoryPagingController.appendLastPage([
      RideHistoryDoc(
          payment: Payment(),
          from: RideHistoryFrom(
            address: 'My addrersss',
            location: RideHistoryLocation(),
          ),
          to: RideHistoryTo(
            address: 'My addrersss',
            location: RideHistoryLocation(),
          ),
          distance: RideHistoryDistance(text: 'jhhkjhjkh', value: 500),
          duration: RideHistoryDuration(),
          currency: RideHistoryCurrency(),
          driver: RideHistoryDriver(),
          user: RideHistoryUser(),
          ride: RideHistoryRide(),
          date: AppComponents.defaultUnsetDateTime,
          createdAt: AppComponents.defaultUnsetDateTime,
          updatedAt: AppComponents.defaultUnsetDateTime),
      RideHistoryDoc.empty(),
      RideHistoryDoc.empty(),
      RideHistoryDoc.empty(),
      RideHistoryDoc.empty(),
      RideHistoryDoc.empty(),
      RideHistoryDoc.empty(),
    ]);
    return;
    RideHistoryResponse? response =
        await APIRepo.getRideHistoryList(currentPageNumber, key);

    if (response == null) {
      onErrorGetHireDriverList(response);
      return;
    } else if (response.error) {
      onFailureGetHireDriverList(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetHireDriverList(response);
  }

  void onErrorGetHireDriverList(RideHistoryResponse? response) {
    rideHistoryPagingController.error = response;
  }

  void onFailureGetHireDriverList(RideHistoryResponse response) {
    rideHistoryPagingController.error = response;
  }

  void onSuccessGetHireDriverList(RideHistoryResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      rideHistoryPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    rideHistoryPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  /* <---- Initial state ----> */
  @override
  void onInit() {
    Helper.getUser();
    getPendingRideRequestResponse();
    rideHistoryPagingController.addPageRequestListener((pageKey) {
      getRideHistoryList(pageKey);
    });

    super.onInit();
  }

  @override
  void onClose() {
    rideHistoryPagingController.dispose();
    super.onClose();
  }
}
