import 'package:car2godriver/controller/profile_screen_controller.dart';
import 'package:car2godriver/models/api_responses/bottom_sheet_params/profile_entry_gender_bottom_sheet_parameter.dart';
import 'package:car2godriver/models/enums/gender.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:get/get.dart';

class ProfileGenderBottomsheetController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  final profileController = Get.find<MyAccountScreenController>();
  Gender initialValue = Gender.unknown;
  Gender _selectedGender = Gender.unknown;
  Gender get selectedGender => _selectedGender;
  set selectedGender(Gender value) {
    _selectedGender = value;
    update();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

/*   // Getter for gender name
  String get getItemName {
    switch (profileGenderName.value) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      default:
        return 'Other';
    }
  } */

/*   // Method to set the selected gender
  void setGender(String gender) {
    if (gender == 'Male') {
      profileGenderName.value = Gender.male;
    } else if (gender == 'Female') {
      profileGenderName.value = Gender.female;
    } else {
      profileGenderName.value = Gender.other;
    }
  } */

  // Continue button tap action
  void onContinueButtonTap() {
    updateProfileGender();
  }

  Future<void> updateProfileGender() async {
    isLoading = true;
    final response = await profileController.updateProfile(
        request: {'gender': selectedGender.stringValue}, showDialog: false);
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

  // Get parameters passed to the screen
  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is ProfileEntryGenderBottomSheetParameter) {
      initialValue = argument.profileGenderName;
      selectedGender = initialValue;
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    super.onInit();
  }
}
