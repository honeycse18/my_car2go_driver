import 'package:car2godriver/controller/profile_screen_controller.dart';
import 'package:car2godriver/models/api_responses/bottom_sheet_params/profile_entry_gender_bottom_sheet_parameter.dart';
import 'package:car2godriver/models/enums/api/profile_field_name.dart';
import 'package:car2godriver/models/enums/otp_verify_purpose.dart';
import 'package:car2godriver/models/screenParameters/verification_screen_parameter.dart';
import 'package:car2godriver/utils/app_singleton.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileFieldBottomsheetController extends GetxController {
  final profileController = Get.find<MyAccountScreenController>();
  /*<----------- Initialize variables ----------->*/
  final textController = TextEditingController();
  String initialText = "";
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  CountryCode currentCountryCode = AppSingleton.instance.currentCountryCode;
  ProfileFieldName profileFieldName = ProfileFieldName.unknown;

  String get fullPhoneNumber =>
      '${currentCountryCode.dialCode}${textController.text}';

  String get getTitleName {
    switch (profileFieldName) {
      case ProfileFieldName.name:
        return 'Edit Full Name';
      case ProfileFieldName.email:
        return 'Edit Email';
      case ProfileFieldName.phone:
        return 'Edit Phone number';
      case ProfileFieldName.city:
        return 'Edit City';
      case ProfileFieldName.address:
        return 'Edit Address';
      default:
        return 'Edit';
    }
  }

  String get getSubtitleName {
    switch (profileFieldName) {
      case ProfileFieldName.name:
        return 'This name will be visible to other users across the app.';
      case ProfileFieldName.email:
        return ' This email will be used for login and important notifications.';
      case ProfileFieldName.phone:
        return 'This number may be used for verification and important updates.';
      case ProfileFieldName.city:
        return 'Update the city associated with your profile to personalize local content and services based on your location.';
      case ProfileFieldName.address:
        return 'Update the address';
      default:
        return 'Edit';
    }
  }

  // // Function to update full name
  void onCountryCodeChanged(CountryCode countryCode) {
    currentCountryCode = countryCode;
    AppSingleton.instance.currentCountryCode = countryCode;
    update();
  }

  void onSubmitButtonTap() {
    switch (profileFieldName) {
      case ProfileFieldName.name:
        updateProfileFullName();
        return;
      case ProfileFieldName.email:
        updateEmailAddress();
        return;
      case ProfileFieldName.phone:
        updatePhoneNumber();
        return;
      case ProfileFieldName.city:
        updateProfileCity();
        return;
      case ProfileFieldName.address:
        updateProfileAddress();
        return;
      default:
    }
  }

  Future<void> updateEmailAddress() async {
    isLoading = true;
    final requestBody = {
      'email': textController.text,
      'action': 'profile_update'
    };
    final response = await APIRepo.sendUserProfileOTP(requestBody: requestBody);
    isLoading = false;
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForUpdatingProfileImageTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    Helper.showSnackBar('Please verify the email to update');
    final result = await Get.toNamed(AppPageNames.verificationScreen,
        arguments: VerificationScreenParameter(
            purpose: OtpVerifyPurpose.profileUpdate,
            isIdentifierTypeEmail: false,
            identifier: textController.text,
            profileUpdateDetails: requestBody));
    if (result is bool && result) {
      Get.back(result: true);
      AppDialogs.showSuccessDialog(messageText: 'Profile successfully updated');
    }
    return;
  }

  Future<void> updatePhoneNumber() async {
    isLoading = true;
    final requestBody = {'phone': fullPhoneNumber, 'action': 'profile_update'};
    final response = await APIRepo.sendUserProfileOTP(requestBody: requestBody);
    isLoading = false;
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForUpdatingProfileImageTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    Helper.showSnackBar('Please verify the phone number to update');
    final result = await Get.toNamed(AppPageNames.verificationScreen,
        arguments: VerificationScreenParameter(
            purpose: OtpVerifyPurpose.profileUpdate,
            isIdentifierTypeEmail: false,
            identifier: fullPhoneNumber,
            profileUpdateDetails: requestBody));
    if (result is bool && result) {
      Get.back(result: true);
      AppDialogs.showSuccessDialog(messageText: 'Profile successfully updated');
    }
    return;
  }

  Future<void> updateProfileFullName() async {
    isLoading = true;
    final response = await profileController.updateProfile(
        request: {'name': textController.text}, showDialog: false);
    isLoading = false;
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForUpdatingProfileImageTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    } else if (response.success) {
      await AppDialogs.showSuccessDialog(messageText: response.message);
      Get.back(result: true);
      return;
    }
  }

  Future<void> updateProfileCity() async {
    isLoading = true;
    final response = await profileController.updateProfile(
        request: {'city': textController.text}, showDialog: false);
    isLoading = false;
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForUpdatingProfileImageTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    } else if (response.success) {
      await AppDialogs.showSuccessDialog(messageText: response.message);
      Get.back(result: true);
      return;
    }
  }

  Future<void> updateProfileAddress() async {
    isLoading = true;
    final response = await profileController.updateProfile(
        request: {'address': textController.text}, showDialog: false);
    isLoading = false;
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForUpdatingProfileImageTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    } else if (response.success) {
      Get.back(result: true);
      AppDialogs.showSuccessDialog(messageText: response.message);
      return;
    }
  }

  void _setPhoneNumber(String fullPhoneNumber) {
    final phoneNumberParts = Helper.separatePhoneAndDialCode(fullPhoneNumber);
    final dialCode = phoneNumberParts?.dialCode ?? '';
    final phoneNumber = phoneNumberParts?.strippedPhoneNumber ?? '';
    if (dialCode.isNotEmpty) {
      currentCountryCode = CountryCode.fromDialCode(dialCode);
    }
    textController.text = phoneNumber;
    update();
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is ProfileEntryTextFieldBottomSheetParameter) {
      initialText = argument.initialValue;
      profileFieldName = argument.profileFieldName;
      if (profileFieldName == ProfileFieldName.phone) {
        _setPhoneNumber(initialText);
      } else {
        textController.text = initialText;
      }
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    textController.addListener(update);
    super.onInit();
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
