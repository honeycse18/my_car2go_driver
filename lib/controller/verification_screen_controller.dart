import 'dart:async';
import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/api_response.dart';
import 'package:car2godriver/models/api_responses/forgot_password_verify_otp.dart';
import 'package:car2godriver/models/api_responses/profile_details.dart';
import 'package:car2godriver/models/api_responses/registration_response.dart';
import 'package:car2godriver/models/api_responses/request_otp.dart';
import 'package:car2godriver/models/api_responses/send_user_profile_update_otp_response.dart';
import 'package:car2godriver/models/api_responses/user_details_response.dart';
import 'package:car2godriver/models/enums/otp_verify_purpose.dart';
import 'package:car2godriver/models/screenParameters/verification_screen_parameter.dart';
import 'package:car2godriver/services/profile_service.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_local_stored_keys.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
/* 
class VerificationScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  final bool shouldShowLoadingIndicator = false;
  TextEditingController otpInputTextController = TextEditingController();
  Map<String, dynamic> theData = {};
  Map<String, dynamic> resendCodeForgotPass = {};
  bool isEmail = true;
  bool isForRegistration = true;
  bool isOtpError = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }
  bool isDurationOver() {
    return otpTimerDuration.inSeconds <= 0;
  }

  /*<----------- OTP timer duration value----------->*/
  Duration otpTimerDuration = const Duration();

  Timer otpTimer = Timer(
    const Duration(seconds: 1),
    () {},
  );

  /*<-----------Reset OTP Timer ----------->*/
  _resetTimer() {
    otpTimerDuration = const Duration(seconds: 120);
  }

  /*<----------- Send code button tap ----------->*/
  onSendCodeButtonTap() {
    sendCode();
  }

  /*<----------- Resend button tap ----------->*/
  void onResendButtonTap() {
    if (isDurationOver()) {
      resendCode();
    } else {
      /* AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .pleaseWaitFewMoreSecondTransKey.toCurrentLanguage); */
      log('error in verification');
    }
  }

  /*<----------- Send code from API ----------->*/
  Future<void> sendCode() async {
    isLoading = true;

    theData['otp'] = otpInputTextController.text;
    if (isForRegistration) {
      RegistrationResponse? response = await APIRepo.registration(theData);
      isLoading = false;

      if (response == null) {
        isOtpError = true;
        update();
        return;
      } else if (response.error) {
        isOtpError = true;
        update();
        return;
      }
      isOtpError = false;
      update();
      log(response.toJson().toString());
      onSuccessResponse(response);
    } else {
      OtpVerificationResponse? response = await APIRepo.verifyOTP(theData);
      isLoading = false;

      if (response == null) {
        isOtpError = true;
        update();
        return;
      } else if (response.error) {
        isOtpError = true;
        update();
        return;
      }
      isOtpError = false;
      update();
      log(response.toJson().toString());
      onSuccessGettingOtpVerified(response);
    }
  }

  onSuccessGettingOtpVerified(OtpVerificationResponse response) {
    Get.offNamed(AppPageNames.createNewPasswordScreen,
        arguments: response.data.token);
  }

  /*<----------- Resend code from API ----------->*/
  Future<void> resendCode() async {
    isLoading = false;
    if (isForRegistration) {
      String key = 'phone';
      String value = theData['phone'];
      if (isEmail) {
        key = 'email';
        value = theData['email'];
      }
      final Map<String, dynamic> requestBody = {
        key: value,
        'action': 'registration',
      };
      OtpRequestResponse? response = await APIRepo.requestOTP(requestBody);
      isLoading = false;

      if (response == null) {
        isOtpError = true;
        update();
        return;
      } else if (response.error) {
        isOtpError = true;
        update();

        return;
      }
      isOtpError = false;
      update();
      log(response.toJson().toString());
      onSuccessResendCode();
    } else {
      OtpRequestResponse? response =
          await APIRepo.requestOTP(resendCodeForgotPass);
      isLoading = false;

      if (response == null) {
        isOtpError = true;
        update();
        return;
      } else if (response.error) {
        isOtpError = true;
        update();
        return;
      }
      isOtpError = false;
      update();
      log(response.toJson().toString());
      onSuccessSendingOTP(response);
    }
  }

  onSuccessSendingOTP(OtpRequestResponse response) {
    AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.codeHasBeenResentTranskey.toCurrentLanguage);
    _resetTimer();
  }

  /*<----------- For resending otp for Reset Password ----------->*/
  void onSuccessResendCode() {
    AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.codeHasBeenResentTranskey.toCurrentLanguage);
    _resetTimer();
  }

  void onSuccessResponse(RegistrationResponse response) {
    fetchUserDetails(response.data.token);
  }

  /*<----------- Fetch user details from API ----------->*/
  Future<void> fetchUserDetails(String token) async {
    await GetStorage().write(LocalStoredKeyName.loggedInDriverToken, token);
    getLoggedInUserDetails(token);
  }

/*<----------- Get loggedin user details from API ----------->*/
  Future<void> getLoggedInUserDetails(String token) async {
    UserDetailsResponse? response = await APIRepo.getUserDetails(token: token);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInUserDetails(response);
  }

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
    Get.offAllNamed(AppPageNames.zoomDrawerScreen);
  }
/*<----------- Fetch screen navigation argument----------->*/

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is Map<String, dynamic>) {
      theData = argument;
      isEmail = theData['isEmail'];
      isForRegistration = theData['isForRegistration'];
      theData.remove('isEmail');
      theData.remove('isForRegistration');
    }
    update();
    if (!isForRegistration) {
      resendCodeForgotPass = theData['resendCode'];
      theData.remove('resendCode');
      update();
    }
    resendCode();
  }

  final GetStorage _storage = GetStorage();
  void _startTimer() {
    otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimerDuration.inSeconds > 0) {
        otpTimerDuration = otpTimerDuration - const Duration(seconds: 1);
        _storage.write('otpTimerDuration', otpTimerDuration.inSeconds);
      }
      update();
    });
  }

  @override
  void onInit() {
    _getScreenParameter();
    int? storedDuration = _storage.read('otpTimerDuration');
    if (storedDuration != null && storedDuration > 0) {
      otpTimerDuration = Duration(seconds: storedDuration);
    } else {
      otpTimerDuration = const Duration(seconds: 120);
    }
    _startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    if (otpTimer.isActive) {
      otpTimer.cancel();
    }
    super.dispose();
  }
}
 */

class VerificationScreenController extends GetxController {
  final bool shouldShowLoadingIndicator = false;
  TextEditingController otpInputTextController = TextEditingController();
  Map<String, dynamic> signUpDetails = {};
  Map<String, dynamic> forgetPasswordDetails = {};
  Map<String, dynamic> profileUpdateDetails = {};
  // Map<String, dynamic> theData = {};
  // Map<String, dynamic> resendCodeForgotPass = {};
  String identifier = '';
  bool isIdentifierTypeEmail = true;
  // bool isEmail = true;
  // bool isForRegistration = true;
  OtpVerifyPurpose purpose = OtpVerifyPurpose.unknown;
  Duration otpTimerDuration = const Duration(seconds: 120);
  Timer? otpTimer;
  final GetStorage _storage = GetStorage();
  bool _isOtpError = false;
  bool get isOtpError => _isOtpError;
  set isOtpError(bool value) {
    _isOtpError = value;
    update();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  String get identifierValue => switch (purpose) {
        OtpVerifyPurpose.signUp => signUpDetails['identifier'],
        OtpVerifyPurpose.forgetPassword => forgetPasswordDetails['identifier'],
        _ => '',
      };

  String get verificationSubtitleText {
    final identifierMethodName = isIdentifierTypeEmail
        ? AppLanguageTranslation.emailTransKey.toCurrentLanguage
        : AppLanguageTranslation.phoneTransKey.toCurrentLanguage;
    return '${AppLanguageTranslation.authCodeSendTransKey.toCurrentLanguage} $identifierMethodName. ${AppLanguageTranslation.whichIsTransKey.toCurrentLanguage} $identifierValue';
  }

  bool isDurationOver() {
    return otpTimerDuration.inSeconds <= 0;
  }

  void _resetTimer() {
    otpTimerDuration = const Duration(seconds: 120);
  }

  void onSendCodeButtonTap() {
    sendCode();
  }

  void onResendButtonTap() {
    if (isDurationOver()) {
      resendCode();
      otpInputTextController.clear();
    } else {
      AppDialogs.showErrorDialog(messageText: 'Please wait few more seconds');
    }
  }

/*   Future<void> sendCode() async {
    isLoading = true;
    theData['otp'] = otpInputTextController.text;
    if (isForRegistration) {
      RegistrationResponse? response = await APIRepo.registration(theData);
      isLoading = false;
      if (response == null || response.error) {
        isOtpError = true;
        update();
        return;
      }
      isOtpError = false;
      log(response.toJson().toString());
      onSuccessResponse(response);
    } else {
      OtpVerificationResponse? response = await APIRepo.verifyOTP(theData);
      isLoading = false;
      if (response == null || response.error) {
        isOtpError = true;
        update();
        return;
      }
      isOtpError = false;
      log(response.toJson().toString());
      onSuccessGettingOtpVerified(response);
    }
  }

  onSuccessGettingOtpVerified(OtpVerificationResponse response) {
    Get.offNamed(AppPageNames.createNewPasswordScreen,
        arguments: response.data.token);
  } */
  Future<void> sendCode() async {
    switch (purpose) {
      case OtpVerifyPurpose.signUp:
        sendCodeForRegistration();
        break;
      case OtpVerifyPurpose.forgetPassword:
        sendCodeForForgetPassword();
        break;
      case OtpVerifyPurpose.profileUpdate:
        verifyCodeForProfileUpdate();
        break;
      default:
    }
  }

  Future<void> sendCodeForRegistration() async {
    final request = <String, dynamic>{'otp': otpInputTextController.text};
    request.addAll(signUpDetails);
    final APIResponse<RegistrationDataUpdated>? response =
        await APIRepo.registrationUpdated(request);
    if (response == null) {
      APIHelper.onError('No response for verifying otp!');
      isOtpError = true;
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      isOtpError = true;
      return;
    }
    isOtpError = false;
    log(response.toJson((data) => data.toJson()).toString());
    onSuccessResponse(response);
  }

  void onSuccessResponse(APIResponse<RegistrationDataUpdated> response) async {
    await GetStorage().write(
        LocalStoredKeyName.loggedInDriverToken, response.data.accessToken);
    final isSuccess = await Helper.updateSavedDriverDetails();
    if (isSuccess) {
      Get.offAllNamed(AppPageNames.zoomDrawerScreen);
    } else {
      Get.offAllNamed(AppPageNames.loginScreen);
    }
  }

  Future<void> sendCodeForForgetPassword() async {
    final request = <String, dynamic>{
      'otp': otpInputTextController.text,
      // 'type': isIdentifierTypeEmail ? 'email' : 'phone',
    };
    request.addAll(forgetPasswordDetails);
    /*<----------- Verify code from API ----------->*/
    final APIResponse<ForgotPasswordVerifyOTP>? response =
        await APIRepo.forgotPasswordVerifyOTP(request);
    if (response == null) {
      APIHelper.onError('No response for verifying otp!');
      isOtpError = true;
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      isOtpError = true;
      return;
    }
    isOtpError = false;
    log(response
        .toJson(
          (data) => data.toJson(),
        )
        .toString());
    onSuccessGettingOtpVerified(response);
  }

  void onSuccessGettingOtpVerified(
      APIResponse<ForgotPasswordVerifyOTP> response) {
    Get.offNamed(AppPageNames.createNewPasswordScreen,
        arguments: response.data.accessToken);
  }

  Future<void> verifyCodeForProfileUpdate() async {
    final request = <String, dynamic>{
      'otp': otpInputTextController.text,
    };
    request.addAll(profileUpdateDetails);
    /*<----------- Verify code from API ----------->*/
    final response = await APIRepo.veryUserProfileOTP(requestBody: request);
    if (response == null) {
      APIHelper.onError('No response for verifying otp!');
      isOtpError = true;
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      isOtpError = true;
      return;
    }
    isOtpError = false;
    log(response
        .toJson(
          (data) => data.toJson(),
        )
        .toString());
    _onSuccessVerifyCodeForProfileUpdate(response);
  }

  void _onSuccessVerifyCodeForProfileUpdate(
      APIResponse<ProfileDetails> response) {
    Helper.updateSavedDriverDetails();
    Get.back(result: true);
  }

/*   Future<void> resendCode() async {
    isLoading = true;
    if (isForRegistration) {
      Map<String, dynamic> requestBody = {
        'phone': theData['phone'],
        'email': theData['email'],
        'action': 'registration',
      };
      OtpRequestResponse? response = await APIRepo.requestOTP(requestBody);
      isLoading = false;
      isOtpError = false;

      if (response == null) {
        // AppDialogs.showErrorDialog(
        //     messageText: AppLanguageTranslation
        //         .noResponseForResendingCodeTranskey.toCurrentLanguage);
        return;
      } else if (response.error) {
        log(response.msg);
        AppDialogs.showErrorDialog(messageText: response.msg);
        return;
      }
      log(response.toJson().toString());
      onSuccessResendCode();
    } else {
      OtpRequestResponse? response =
          await APIRepo.requestOTP(resendCodeForgotPass);
      isLoading = false;

      if (response == null) {
        // AppDialogs.showErrorDialog(
        //     messageText: AppLanguageTranslation
        //         .noResponseForthisOperationTranskey.toCurrentLanguage);
        return;
      } else if (response.error) {
        // AppDialogs.showErrorDialog(messageText: response.msg);
        return;
      }
      log(response.toJson().toString());
      onSuccessSendingOTP(response);
    }
  }

  onSuccessSendingOTP(OtpRequestResponse response) {
    /* AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.codeHasBeenResentTranskey.toCurrentLanguage); */
    Get.snackbar('Otp Sent Successfully', 'Otp code has been sent successfully',
        snackPosition: SnackPosition.TOP);
    _resetTimer();
  } */

  Future<void> resendCode() async {
    switch (purpose) {
      case OtpVerifyPurpose.signUp:
        resendCodeForRegistration();
        break;
      case OtpVerifyPurpose.forgetPassword:
        resendCodeForForgetPassword();
        break;
      case OtpVerifyPurpose.profileUpdate:
        resendCodeForProfileUpdate();
        break;
      default:
    }
  }

  Future<void> resendCodeForRegistration() async {
/*     String key = 'phone';
    String value = theData['phone'];
    if (isIdentifierTypeEmail) {
      key = 'email';
      value = theData['email'];
    }
    final Map<String, dynamic> requestBody = {
      key: value,
      'action': 'registration',
    }; */
    final identifier =
        isIdentifierTypeEmail ? signUpDetails['email'] : signUpDetails['phone'];
    final request = {'identifier': identifier, 'action': 'signup'};
    final response = await APIRepo.requestOTPUpdated(request);
    if (response == null) {
      isOtpError = true;
      return;
    } else if (response.error) {
      isOtpError = true;
      return;
    }
    isOtpError = false;
    log(response.toJson((data) => data.toJson()).toString());
    onSuccessResendCode();
  }

  /*<----------- For resending otp for Reset Password ----------->*/
  void onSuccessResendCode() {
    AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.codeHasBeenResentTranskey.toCurrentLanguage);
    _resetTimer();
  }

  Future<void> resendCodeForForgetPassword() async {
    final identifier =
        isIdentifierTypeEmail ? signUpDetails['email'] : signUpDetails['phone'];
    final request = {'identifier': identifier, 'action': 'forget_password'};
    final APIResponse<RequestOtp>? response =
        await APIRepo.requestForgotPasswordOTPUpdated(request);
    if (response == null) {
      isOtpError = true;
      return;
    } else if (response.error) {
      isOtpError = true;
      return;
    }
    isOtpError = false;
    log(response.toJson((data) => data.toJson()).toString());
    onSuccessSendingOTP(response);
  }

  void onSuccessSendingOTP(APIResponse<RequestOtp> response) {
    AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.codeHasBeenResentTranskey.toCurrentLanguage);
    _resetTimer();
  }

  Future<void> resendCodeForProfileUpdate() async {
    final response =
        await APIRepo.sendUserProfileOTP(requestBody: profileUpdateDetails);
    if (response == null) {
      isOtpError = true;
      return;
    } else if (response.error) {
      isOtpError = true;
      return;
    }
    isOtpError = false;
    log(response.toJson((data) => data.toJson()).toString());
    _onSuccessResendCodeForProfileUpdate(response);
  }

  void _onSuccessResendCodeForProfileUpdate(
      APIResponse<SendUserProfileUpdateOtpResponse> response) {
    AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.codeHasBeenResentTranskey.toCurrentLanguage);
    _resetTimer();
  }

/*   void onSuccessResendCode() {
    /* AppDialogs.showSuccessDialog(
        messageText: 'Otp code has been sent successfully'); */

    Get.snackbar('Otp Sent Successfully', 'Otp code has been sent successfully',
        snackPosition: SnackPosition.TOP);

    _resetTimer();
  } */

/*   void onSuccessResponse(RegistrationResponse response) {
    fetchUserDetails(response.data.token);
  } */

  Future<void> fetchUserDetails(String token) async {
    await GetStorage().write(LocalStoredKeyName.loggedInDriverToken, token);
    getLoggedInUserDetails(token);
  }

  Future<void> getLoggedInUserDetails(String token) async {
    UserDetailsResponse? response = await APIRepo.getUserDetails(token: token);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInUserDetails(response);
  }

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data as ProfileDetails);
    BuildContext? context = Get.context;
    if (context != null) {
      Get.offAllNamed(AppPageNames.zoomDrawerScreen);
      // Get.until((route) => Get.currentRoute == AppPageNames.zoomDrawerScreen);
    }
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
/*     if (argument is Map<String, dynamic>) {
      theData = argument;
      isEmail = theData['isEmail'];
      isForRegistration = theData['isForRegistration'];
      theData.remove('isEmail');
      theData.remove('isForRegistration');
    } */
    if (argument is VerificationScreenParameter) {
      // theData = argument;
      // isEmail = theData['isEmail'];
      // isForRegistration = theData['isForRegistration'];
      // theData.remove('isEmail');
      // theData.remove('isForRegistration');
      purpose = argument.purpose;
      identifier = argument.identifier;
      isIdentifierTypeEmail = argument.isIdentifierTypeEmail;
      switch (argument.purpose) {
        case OtpVerifyPurpose.signUp:
          signUpDetails = argument.signUpDetails;
          break;
        case OtpVerifyPurpose.forgetPassword:
          forgetPasswordDetails = argument.forgetPasswordDetails;
          break;
        case OtpVerifyPurpose.profileUpdate:
          profileUpdateDetails = argument.profileUpdateDetails;
          break;
        default:
      }
    }
  }

  void _startTimer() {
    otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimerDuration.inSeconds > 0) {
        otpTimerDuration = otpTimerDuration - const Duration(seconds: 1);
        _storage.write('otpTimerDuration', otpTimerDuration.inSeconds);
      }
      update();
    });
  }

  @override
  void onInit() {
    _getScreenParameter();
/*     update();
    if (!isForRegistration) {
      resendCodeForgotPass = theData['resendCode'];
      theData.remove('resendCode');
      update();
    } */
    // resendCode();
    int? storedDuration = _storage.read('otpTimerDuration');
    if (storedDuration != null && storedDuration > 0) {
      otpTimerDuration = Duration(seconds: storedDuration);
    } else {
      otpTimerDuration = const Duration(seconds: 120);
    }
    _startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    if (otpTimer?.isActive ?? false) {
      otpTimer?.cancel();
    }
    super.dispose();
  }

  void onBackButtonPressed() {
    Get.back();
  }
}
