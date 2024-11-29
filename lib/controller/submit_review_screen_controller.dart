import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/screenParameters/submit_review_screen_parameter.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SubmitReviewBottomSheetScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  final GlobalKey<FormState> submitReviewFormKey = GlobalKey<FormState>();
  SubmitReviewScreenParameter? submitReview;
  TextEditingController commentTextEditingController = TextEditingController();

  RxDouble rating = 0.0.obs;

  void setRating(double value) {
    rating.value = value;
    update();
  }

  /*<----------- Submit rent review from API ----------->*/
  Future<void> submitRentReview() async {
    Map<String, dynamic> requestBody = {
      'object': submitReview!.id,
      'type': submitReview!.type,
      'rating': rating.value,
      'comment': commentTextEditingController.text
    };
    RawAPIResponse? response = await APIRepo.submitReviews(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSucessSendMessage(response);
  }

  void _onSucessSendMessage(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(
        messageText: AppLanguageTranslation
            .reviewSubmittedSuccessfullyTransKey.toCurrentLanguage);
    Get.back(result: true);
  }

/*<----------- Fetch screen navigation argument----------->*/
  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SubmitReviewScreenParameter) {
      submitReview = params;
      update();
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}
