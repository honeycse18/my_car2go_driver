import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/ride_share_request_socket_response.dart';
import 'package:car2godriver/models/enums.dart';
import 'package:car2godriver/models/fakeModel/intro_content_model.dart';
import 'package:car2godriver/ui/screens/bottomsheet/view_schedule_ride_details_bottomsheet.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcceptRideBottomSheetController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  RideShareRequestSocketResponse rideShareRequestDetails =
      RideShareRequestSocketResponse.empty();
  FakeRentHistoryList fakeRideHistoryData = FakeRentHistoryList();

  /*<----------- Accept reject ride request----------->*/
  Future<void> acceptRejectRideRequest(String rideId, RideStatus status) async {
    Map<String, dynamic> requestBody = {
      '_id': rideId,
      'status': status.stringValue
    };
    RawAPIResponse? response =
        await APIRepo.acceptRejectRideRequest(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());

    _onSuccessAddDriver(response, status);
  }

  _onSuccessAddDriver(RawAPIResponse response, RideStatus status) async {
    Get.back();
    if (status == RideStatus.accepted) {
      Get.bottomSheet(const StartRideBottomSheetScreen(),
          settings: RouteSettings(arguments: response.data));
    }
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  /*<----------- Fetch screen navigation argument----------->*/
  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument != null) {
      if (argument is FakeRentHistoryList) {
        fakeRideHistoryData = argument;
      } else if (argument is RideShareRequestSocketResponse) {
        rideShareRequestDetails = argument;
        update();
      }
    }
  }

  /* <---- Initial state ----> */
  @override
  void onInit() {
    // TODO: implement onInit
    _getScreenParameter();
    super.onInit();
  }
}
