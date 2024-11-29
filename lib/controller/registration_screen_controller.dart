import 'dart:developer';

import 'package:car2godriver/models/api_responses/t/register/send_otp.dart';
import 'package:car2godriver/models/enums/gender.dart';
import 'package:car2godriver/models/enums/otp_verify_purpose.dart';
import 'package:car2godriver/models/screenParameters/sign_up_screen_parameter.dart';
import 'package:car2godriver/models/screenParameters/verification_screen_parameter.dart';
import 'package:car2godriver/utils/app_singleton.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../models/api_responses/core_api_responses/api_response.dart';

class RegistrationScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  final RxBool isDropdownOpen = false.obs;
  Gender? selectedGender;
  // final RxString selectedGender = 'Select Gender'.obs;
  SignUpScreenParameter? screenParameter;
  bool isEmail = true;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  CountryCode currentCountryCode = AppSingleton.instance.currentCountryCode;

  bool validateSignUp() {
    if ((signUpFormKey.currentState?.validate() == true) == false) {
      return false;
    }
    if (checkEmpty(passwordTextEditingController) ||
        (passwordTextEditingController.text !=
            confirmPasswordTextEditingController.text)) {
      AppDialogs.showErrorDialog(messageText: 'Passwords don\'t match!');
      return false;
    }
    return true;
  }

  String? addressFormValidator(String? text) {
    if (text == null) {
      return "Enter your address";
    }
    if (text.isEmpty) {
      return "Address cannot be empty";
    }
    return null;
  }

  String? cityFormValidator(String? text) {
    if (text == null) {
      return "Enter your city name";
    }
    if (text.isEmpty) {
      return "City cannot be empty";
    }
    return null;
  }

  void onGenderChange(Gender? gender) {
    selectedGender = gender;
    update();
  }

  bool isFieldFillupped() {
    return signUpFormKey.currentState?.validate() ?? false;
  }

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    AppSingleton.instance.currentCountryCode = countryCode;
    update();
  }

  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

  void selectGender(String gender) {
    // selectedGender.value = gender;
    isDropdownOpen.value = false;
  }

  String? passwordFormValidator(String? text) {
    return Helper.passwordFormValidator(text);
  }

  String? confirmPasswordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != passwordTextEditingController.text) {
        return AppLanguageTranslation
            .passwordDoesnotMatchTranskey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  /// Toggle value of hide password
  RxBool toggleHidePassword = true.obs;

  /// Toggle value of hide confirm password
  RxBool toggleHideConfirmPassword = true.obs;
  RxBool toggleAgreeTermsConditions = false.obs;

  void onPasswordSuffixEyeButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  void onConfirmPasswordSuffixEyeButtonTap() {
    toggleHideConfirmPassword.value = !toggleHideConfirmPassword.value;
  }

  void onToggleAgreeTermsConditions(bool? value) {
    if (isFieldFillupped()) {
      toggleAgreeTermsConditions.value = value ?? false;
    }
    update();
  }

  bool checkEmpty(TextEditingController controller) {
    return controller.text.isEmpty;
  }

/* <---- Continue button tap ----> */

  void onContinueButtonTap() {
/*     if (checkEmpty(passwordTextEditingController) ||
        passwordTextEditingController.text !=
            confirmPasswordTextEditingController.text) {
      AppDialogs.showErrorDialog(messageText: 'Passwords don\'t match!');
      return;
    } */
/*     if (checkEmpty(nameTextEditingController) ||
        checkEmpty(emailTextEditingController) ||
        checkEmpty(phoneTextEditingController)) {
      AppDialogs.showErrorDialog(
          messageText: 'Please fill out all required fields first!');
      return;
    } */
    if (validateSignUp()) {
      if (!toggleAgreeTermsConditions.value) {
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .youMustAgreeTermsConditionsFirstTranskey.toCurrentLanguage);
        return;
      }
/*       String key = 'phone';
      String value = getPhoneFormatted();
      if (isEmail) {
        key = 'email';
        value = emailTextEditingController.text;
      }
      Map<String, dynamic> requestBodyForOTP = {
        key: value,
        'action': 'registration',
      }; */
      final request = {
        'identifier':
            isEmail ? emailTextEditingController.text : getPhoneFormatted(),
        'action': 'signup',
      };
      requestForOTP(request);
    }
/*     Map<String, dynamic> requestBodyForOTP = {
      'phone': getPhoneFormatted(),
      'email': emailTextEditingController.text,
      'action': 'registration',
    };
    onSuccessSendingOTP(requestBodyForOTP['action']); */
  }
  /* <---- Request for OTP from API ----> */

/*   Future<void> requestForOTP(Map<String, dynamic> data) async {
    OtpRequestResponse? response = await APIRepo.requestOTP(data);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForRequestingOtpTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessSendingOTP(response);
  } */

  String getPhoneFormatted() {
    return '${currentCountryCode.dialCode}${phoneTextEditingController.text}';
  }

/* <---- Request for OTP from API ----> */

  Future<void> requestForOTP(Map<String, dynamic> data) async {
    final response = await APIRepo.requestOTPUpdated(data);
    if (response == null) {
      APIHelper.onError('No response for requesting otp!');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    log(response.toJson((data) => data.toJson()).toString());
    onSuccessSendingOTP(response);
  }

  void onSuccessSendingOTP(APIResponse<SendOtp> response) {
    Map<String, dynamic> registrationData = {
      'name': nameTextEditingController.text,
      // 'email': emailTextEditingController.text,
      // 'phone': getPhoneFormatted(),
      'city': cityController.text,
      'address': addressController.text,
      'password': passwordTextEditingController.text,
      // 'confirm_password': confirmPasswordTextEditingController.text,
      'role': 'driver',
      'gender': selectedGender?.stringValue,
      'type': isEmail ? 'email' : 'phone',
      // 'isEmail': isEmail,
      // 'isForRegistration': true,
      // 'action': 'registration',
    };
    if (isEmail) {
      registrationData['email'] = emailTextEditingController.text;
    } else {
      registrationData['phone'] = getPhoneFormatted();
    }
    Get.toNamed(AppPageNames.verificationScreen,
        arguments: VerificationScreenParameter(
            purpose: OtpVerifyPurpose.signUp,
            isIdentifierTypeEmail: isEmail,
            identifier:
                isEmail ? emailTextEditingController.text : getPhoneFormatted(),
            signUpDetails: registrationData));
  }

/*<----------- Fetch screen navigation argument----------->*/
  void _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SignUpScreenParameter) {
      screenParameter = params;
      isEmail = screenParameter!.isEmail;
      if (screenParameter!.isEmail) {
        emailTextEditingController.text = screenParameter!.theValue;
      } else {
        phoneTextEditingController.text = screenParameter!.theValue;
        currentCountryCode = screenParameter!.countryCode ??
            AppSingleton.instance.currentCountryCode;
      }
    }
    update();
  }

/* <---- Initial state ----> */
  @override
  void onInit() {
    _getScreenParameters();
    passwordTextEditingController.addListener(() => update());
    super.onInit();
  }

  @override
  void onClose() {
    emailTextEditingController.dispose();
    phoneTextEditingController.dispose();
    nameTextEditingController.dispose();
    cityController.dispose();
    addressController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    super.onClose();
  }
}
