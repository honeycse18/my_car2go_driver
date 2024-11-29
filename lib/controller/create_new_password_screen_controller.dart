import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/api_response.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewPasswordScreenController extends GetxController {
  /// Toggle value of hide password
  /*<----------- Initialize variables ----------->*/
  final GlobalKey<FormState> changePassFormKey = GlobalKey<FormState>();

  RxBool toggleHidePassword = true.obs;
  String token = '';
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  /// Toggle value of hide confirm password
  RxBool toggleHideConfirmPassword = true.obs;
  RxBool toggleAgreeTermsConditions = false.obs;

  /*<----------- Password suffix eye button tap ----------->*/
  void onPasswordSuffixEyeButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  /*<----------- Confirm password suffix eye button button tap ----------->*/
  void onConfirmPasswordSuffixEyeButtonTap() {
    toggleHideConfirmPassword.value = !toggleHideConfirmPassword.value;
  }

  String? passwordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != confirmPasswordTextEditingController.text) {
        return AppLanguageTranslation
            .mustMatchWithConfirmPasswordTranskey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  /*<----------- Save password button tap ----------->*/
  void onSavePasswordButtonTap() {
    if (passwordTextEditingController.text.isEmpty ||
        passwordTextEditingController.text !=
            confirmPasswordTextEditingController.text) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .eitherFieldEmptyPasswordsdonnotMassTranskey.toCurrentLanguage);
      return;
    }
    createNewPass();
  }

  /*<----------- Create new password ----------->*/
  Future<void> createNewPass() async {
    Map<String, dynamic> requestBody = {
      'password': passwordTextEditingController.text,
      'confirm_password': confirmPasswordTextEditingController.text,
      // 'token': token
    };
    final APIResponse<void>? response =
        await APIRepo.createNewPasswordUpdated(requestBody, token: token);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.noResponseFoundTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    log(response
        .toJson(
          (data) => {},
        )
        .toString());
    onSuccessChangingPassword(response);
  }

  onSuccessChangingPassword(APIResponse<void> response) async {
    await AppDialogs.showPassChangedSuccessDialog(
        messageText: AppLanguageTranslation
            .passwordChangedSuccessfullyTransKey.toCurrentLanguage);
    Get.offNamed(AppPageNames.loginScreen);
  }

  /*<----------- Fetch screen navigation argument----------->*/
  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      token = params;
    }
    update();
  }

  /* <---- Initial state ----> */
  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}
