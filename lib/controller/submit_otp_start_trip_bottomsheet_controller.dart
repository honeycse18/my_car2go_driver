import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/ride_details_response.dart';
import 'package:car2godriver/models/api_responses/ride_share_request_socket_response.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitOtpStartRideBottomSheetController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  RideShareRequestSocketResponse rideShareRequestDetails =
      RideShareRequestSocketResponse.empty();
  bool isSuccess = false;
  RideDetailsData rideDetails = RideDetailsData.empty();

  TextEditingController otpTextEditingController = TextEditingController();
  String rideId = '';

  /*<----------- Accept reject ride request from API ----------->*/
  Future<void> acceptRejectRideRequest() async {
    Map<String, dynamic> requestBody = {
      '_id': rideDetails.id,
      'status': 'started',
      'otp': otpTextEditingController.text,
    };
    RawAPIResponse? response =
        await APIRepo.startRideWithSubmitOtp(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessStartRideRequest(response);
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  _onSuccessStartRideRequest(RawAPIResponse response) async {
    return isSuccess = true;
  }

  /*<----------- Fetch screen navigation argument----------->*/
  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is RideDetailsData) {
      rideDetails = argument;
      update();
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    otpTextEditingController.dispose();
    super.dispose();
  }
}
