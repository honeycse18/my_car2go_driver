import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/api_response.dart';
import 'package:car2godriver/models/api_responses/find_account_response_updated.dart';
import 'package:car2godriver/models/screenParameters/sign_up_screen_parameter.dart';
import 'package:car2godriver/utils/app_singleton.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  bool phoneMethod = false;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  CountryCode currentCountryCode = AppSingleton.instance.currentCountryCode;
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    AppSingleton.instance.currentCountryCode = countryCode;
    update();
  }

  /* <---- Continue button tap ----> */
  void onContinueButtonTap() {
    // findAccount();
    findAccountUpdated();
  }

  /* <---- Method button tap ----> */
  void onMethodButtonTap() {
    phoneMethod = !phoneMethod;
    update();
  }

  String getPhoneFormatted() {
    return '${currentCountryCode.dialCode}${phoneTextEditingController.text}';
  }

  /* <---- Find Account ----> */
/*   Future<void> findAccount() async {
    String key = 'email';
    String value = emailTextEditingController.text;
    if (phoneMethod) {
      key = 'phone';
      value = getPhoneFormatted();
    }
    final Map<String, dynamic> requestBody = {
      key: value,
    };
    final APIResponse<FindAccountDataRefactored>? response =
        await APIRepo.findAccount(requestBody);
    if (response == null) {
      // Get.snackbar('Found Empty Response', response?.msg??'');
      APIHelper.onError(response?.message ?? '');
      return;
    } else if (response.error) {
      APIHelper.onNewFailure(
          AppLanguageTranslation.foundNoResponseTranskey.toCurrentLanguage,
          response.message);
      return;
    }
    log(response.toJson((data) => data.toJson()).toString());
    onSuccessFindingAccount(response);
  } */

  Future<void> findAccountUpdated() async {
    // String key = 'email';
    const String key = 'identifier';
    String value = emailTextEditingController.text;
    if (phoneMethod) {
      // key = 'phone';
      value = getPhoneFormatted();
    }
    final Map<String, dynamic> requestBody = {
      key: value,
    };
    final APIResponse<FindAccountDataRefactored>? response =
        await APIRepo.findAccountUpdated(requestBody);
    if (response == null) {
      // Get.snackbar('Found Empty Response', response?.msg??'');
      APIHelper.onError(response?.message ?? '');
      return;
    } else if (response.error) {
      final isAccountDoesNotExists = response.statusCode == 404 ||
          response.errorDetails.errorMessage == 'User not found !';
      if (isAccountDoesNotExists) {
        APIHelper.onNewFailure('Create your account to get started', '');
        Get.toNamed(AppPageNames.registrationScreen,
            arguments: SignUpScreenParameter(
                isEmail: !phoneMethod,
                countryCode: currentCountryCode,
                theValue: phoneMethod
                    ? phoneTextEditingController.text
                    : emailTextEditingController.text));

        return;
      }
      APIHelper.onNewFailure('Found No Response', response.message);
      return;
    }
    log(response.toJson((data) => data.toJson()).toString());

    // On success
    Get.toNamed(AppPageNames.logInPasswordScreen,
        arguments: SignUpScreenParameter(
            isEmail: !phoneMethod,
            theValue: phoneMethod
                ? getPhoneFormatted()
                : emailTextEditingController.text));
  }

/*   void onSuccessFindingAccount(
      FindAccountResponse response) {
    bool hasAccount = response.data.account;
    log(response.data.role);
    if (hasAccount) {
      if (response.data.role == AppConstants.userRoleUser) {
        Get.toNamed(AppPageNames.logInPasswordScreen,
            arguments: SignUpScreenParameter(
                isEmail: !phoneMethod,
                theValue: phoneMethod
                    ? getPhoneFormatted()
                    : emailTextEditingController.text));
      } else {
        Get.snackbar(
            AppLanguageTranslation.alreadyRegisteredTranskey.toCurrentLanguage,
            AppLanguageTranslation
                .alreadyHaveAccountWithThisCredentialTranskey.toCurrentLanguage,
            backgroundColor: AppColors.backgroundColor.withOpacity(0.5),
            overlayBlur: 2,
            snackStyle: SnackStyle.FLOATING,
            overlayColor: Colors.transparent);
        return;
      }
    } else {
      Get.toNamed(AppPageNames.registrationScreen,
          arguments: SignUpScreenParameter(
              isEmail: !phoneMethod,
              countryCode: currentCountryCode,
              theValue: phoneMethod
                  ? phoneTextEditingController.text
                  : emailTextEditingController.text));
    }
  } */

  void _getScreenParameters() {
    if (Get.arguments != null) {
      final SignUpScreenParameter parameter = Get.arguments;
      if (parameter.isEmail) {
        emailTextEditingController.text = parameter.theValue;
        phoneMethod = false;
      } else {
        phoneTextEditingController.text = parameter.theValue;
        currentCountryCode =
            parameter.countryCode ?? AppSingleton.instance.currentCountryCode;
        phoneMethod = true;
      }
    }
    update();
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}
