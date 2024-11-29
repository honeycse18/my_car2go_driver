import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/api_response.dart';
import 'package:car2godriver/models/api_responses/login_response.dart';
import 'package:car2godriver/models/api_responses/profile_details.dart';
import 'package:car2godriver/models/api_responses/t/register/send_otp.dart';
import 'package:car2godriver/models/enums/otp_verify_purpose.dart';
import 'package:car2godriver/models/screenParameters/sign_up_screen_parameter.dart';
import 'package:car2godriver/models/screenParameters/verification_screen_parameter.dart';
import 'package:car2godriver/utils/app_singleton.dart';
import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_local_stored_keys.dart';

import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LogInPasswordSCreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  RxBool toggleHidePassword = true.obs;
  TextEditingController passwordTextEditingController = TextEditingController();
  SignUpScreenParameter? screenParameter;
  Map<String, dynamic> credentials = {};
  String phoneNumber = '';
  CountryCode selectedCountryCode = AppSingleton.instance.currentCountryCode;
  bool isEmail = false;

  void onPasswordSuffixEyeButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  void onForgotPasswordButtonTap() {
    forgotPassword();
  }

  void _setPhoneNumber(String phoneNumber) {
    final phoneNumberParts = Helper.separatePhoneAndDialCode(phoneNumber);
    final dialCode = phoneNumberParts?.dialCode ?? '';
    phoneNumber = phoneNumberParts?.strippedPhoneNumber ?? '';
    if (dialCode.isNotEmpty) {
      selectedCountryCode = CountryCode.fromDialCode(dialCode);
    }
    update();
  }

  /*<----------- Forgot password ----------->*/
  Future<void> forgotPassword() async {
/*     String key = 'phone';
    String value = '';
    if (isEmail) {
      value = credentials['email'];
      key = 'email';
    } else {
      value = credentials['phone'];
    }
    Map<String, dynamic> requestBody = {
      key: value,
      'action': 'forgot_password'
    }; */
    final request = {
      'identifier': isEmail ? credentials['email'] : credentials['phone'],
      'action': 'forget_password',
    };
    final APIResponse<SendOtp>? response =
        await APIRepo.requestOTPUpdated(request);
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.error) {
      APIHelper.onFailure(
          AppLanguageTranslation.foundEmptyResponseTranskey.toCurrentLanguage,
          response.message);
      return;
    }
    log(response
        .toJson(
          (data) => data.toJson(),
        )
        .toString());
    _onSuccessSendingOTP(response, request);
  }

  void _onSuccessSendingOTP(
      APIResponse<SendOtp> response, Map<String, dynamic> requestBody) {
/*     Map<String, dynamic> forgetPasswordData = {
      // 'theData': data,
      'isEmail': screenParameter!.isEmail ? true : false,
      'isForRegistration': false,
      'action': 'forgot_password',
      'resendCode': requestBody
    };
    if (isEmail) {
      forgetPasswordData["email"] = data;
    } else {
      forgetPasswordData["phone"] = data;
    } */
    requestBody['type'] = isEmail ? 'email' : 'phone';
    Get.offNamed(AppPageNames.verificationScreen,
        arguments: VerificationScreenParameter(
            purpose: OtpVerifyPurpose.forgetPassword,
            isIdentifierTypeEmail: isEmail,
            identifier: isEmail ? credentials['email'] : credentials['phone'],
            forgetPasswordDetails: requestBody));
  }

  /*<----------- Login button tap ----------->*/
  void onLoginButtonTap() {
    /*  if (passwordFormKey.currentState?.validate() ?? false) {
      login();
    } */
    // login();
    loginUpdated();
  }

  /*<----------- Login ----------->*/
  Future<void> login() async {
    credentials['password'] = passwordTextEditingController.text;
    LoginResponse? response = await APIRepo.login(credentials);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessLogin(response);
  }

  Future<void> loginUpdated() async {
    final String identifier =
        isEmail ? credentials['email'] : credentials['phone'];
    final APIResponse<LoginDataUpdated>? response = await APIRepo.loginUpdated({
      'identifier': identifier,
      'password': passwordTextEditingController.text,
      'role': AppConstants.userRoleDriver,
    });
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);
      return;
    }
    log(response
        .toJson(
          (data) => data.toJson(),
        )
        .toString());
    final token = response.data.accessToken;
    await GetStorage().write(LocalStoredKeyName.loggedInDriverToken, token);
    _getLoggedInDriverDetails(token);
  }

  /*<----------- Success login ----------->*/
  Future<void> _onSuccessLogin(LoginResponse response) async {
    final token = response.data.token;
    await GetStorage().write(LocalStoredKeyName.loggedInDriverToken, token);
    _getLoggedInDriverDetails(token);
    // Get.offAllNamed(AppPageNames.zoomDrawerScreen);
  }

  /*<----------- Get Loggedin user details ----------->*/
  Future<void> _getLoggedInDriverDetails(String token) async {
    final bool isSuccess = await Helper.updateSavedDriverDetails();
    if (isSuccess == false) {
      return;
    }
    Get.offAllNamed(AppPageNames.zoomDrawerScreen);
  }

  void _onSuccessGetLoggedInUserDetails(
      APIResponse<ProfileDetails> response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
    BuildContext? context = Get.context;
    if (context != null) {
      Get.offAllNamed(AppPageNames.zoomDrawerScreen);
      log('Login');
    }
  }

  /*<----------- Fetch screen navigation argument----------->*/
  void _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SignUpScreenParameter) {
      screenParameter = params;
      String key = 'phone';
      if (screenParameter!.isEmail) {
        key = 'email';
        isEmail = true;
      }
      credentials[key] = screenParameter!.theValue;
      if (screenParameter!.isEmail == false) {
        _setPhoneNumber(credentials['phone']);
      }
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
