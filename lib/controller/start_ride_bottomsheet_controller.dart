import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/ride_details_response.dart';
import 'package:car2godriver/ui/screens/bottomsheet/cancle_trip_bottomSheet.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:get/get.dart';

class StartRideBottomSheetController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  String rideId = '';
  RideDetailsData rideDetails = RideDetailsData.empty();
  /*<----------- Ride details from API ----------->*/
  Future<void> getRideDetails() async {
    RideDetailsResponse? response = await APIRepo.getRideDetails(rideId);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingRideDetails(response);
  }

  onSuccessRetrievingRideDetails(RideDetailsResponse response) {
    rideDetails = response.data;
    update();
  }

  /*<----------- Cancle ride from API ----------->*/
  Future<void> cancelRide(Map<String, dynamic> requestBody) async {
    RawAPIResponse? response = await APIRepo.updateRideStatus(requestBody);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForCancellingRideTranskey.toCurrentLanguage);
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
    APIHelper.onError(AppLanguageTranslation
        .rideHasBeenCancelledSuccessfullyTranskey.toCurrentLanguage);
  }

  /*<----------- Bottom button tap ----------->*/
  void onBottomButtonTap({bool showDialogue = true}) async {
    String reason = 'No reason found';
    final Map<String, dynamic> requestBody = {
      '_id': rideId,
    };

    dynamic res = await Get.bottomSheet(const CancleTripBottomsheet());
    if (res is String) {
      reason = res;
      update();
      requestBody['status'] = 'cancelled';
      requestBody['cancel_reason'] = reason;
      cancelRide(requestBody);
    }

    log(reason);
  }

  /*<----------- Fetch screen navigation argument----------->*/
  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is String) {
      rideId = argument;
    }
  }

/* <---- Initial state ----> */
  @override
  void onInit() {
    _getScreenParameter();
    getRideDetails();
    super.onInit();
  }
}
