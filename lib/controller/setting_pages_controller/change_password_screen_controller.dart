import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordCreateController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  /// Toggle value of hide new password
  bool toggleHideOldPassword = true;
  bool toggleHideNewPassword = true;

  /// Toggle value of hide confirm password
  bool toggleHideConfirmPassword = true;

  /// Toggle value of over 5 characters requirement
  bool isPasswordOver8Characters = false;

  /// Toggle value of at least 1 digit number
  bool isPasswordHasAtLeastSingleNumberDigit = false;

  /// Create new password editing controller
  TextEditingController newPassword1EditingController = TextEditingController();
  TextEditingController currentPasswordEditingController =
      TextEditingController();
  TextEditingController newPassword2EditingController = TextEditingController();

  /// Find if any password text character has number digit.
  bool detectPasswordNumber(String passwordText) =>
      passwordText.contains(RegExp(r'[0-9]'));
  String? passwordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != newPassword2EditingController.text) {
        return AppLanguageTranslation
            .mustMatchWithConfirmPasswordTranskey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  String? confirmPasswordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != newPassword1EditingController.text) {
        return AppLanguageTranslation
            .passwordDoesnotMatchTranskey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  bool passMatched() {
    return newPassword1EditingController.text ==
        newPassword2EditingController.text;
  }

  /*<----------- Save password button ----------->*/
  void onSavePasswordButtonTap() {
    if (signUpFormKey.currentState?.validate() ?? false) {
      if (passMatched()) {
        sendPass();
      } else {
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .passwordDoesnotMatchTranskey.toCurrentLanguage);
      }
    }
  }

  /*<----------- Send password for changing old password ----------->*/
  Future<void> sendPass() async {
    final Map<String, dynamic> requestBody = {
      'old_password': currentPasswordEditingController.text,
      'new_password': newPassword1EditingController.text,
      'confirm_password': newPassword2EditingController.text,
    };
    RawAPIResponse? response = await APIRepo.updatePassword(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onError(response.msg);
      return;
    }
    onSuccessSavePassword();
  }

  void onSuccessSavePassword() {
    BuildContext? context = Get.context;
    if (context != null) {
      Get.offNamed(AppPageNames.passwordChangedScreen);
    }
  }

  /*  void changePassword() {
    if (newPassword1EditingController.text.isEmpty ||
        currentPasswordEditingController.text.isEmpty) {
      AppDialogs.showErrorDialog(messageText: 'Fields can\'t be empty!');
      return;
    } else if (!passMatched()) {
      AppDialogs.showErrorDialog(messageText: 'Passwords don\'t match.');
      return;
    }
    // changePass();
  } */

  onSuccess() {
    // Get.offNamed(AppPageNames.settingsScreen);
    // AppDialogs.showSuccessDialog(messageText: AppLanguageTranslation.successfullyUpdatePasswordTransKey.toCurrentLanguage);
  }

  /* <---- Initial state ----> */
  @override
  void onInit() {
    newPassword1EditingController = TextEditingController();

    super.onInit();
  }
}
