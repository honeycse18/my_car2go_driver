import 'package:car2godriver/controller/profile_screen_controller.dart';
import 'package:car2godriver/models/api_responses/bottom_sheet_params/profile_entry_gender_bottom_sheet_parameter.dart';
import 'package:car2godriver/models/enums/api/profile_field_name.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:get/get.dart';

class SubmitDocumentBottomSheetController extends GetxController {
  final profileController = Get.find<MyAccountScreenController>();
  ProfileFieldName profileFieldName = ProfileFieldName.unknown;
  // ProfileDrivingLicense drivingLicense = ProfileDrivingLicense();
  String initialFrontImageURL = '';
  String initialBackImageURL = '';
  dynamic frontImageData;
  dynamic backImageData;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  bool get shouldEnableSubmitButton =>
      (frontImageData != null) && (backImageData != null);
  bool get shouldDisableSubmitButton =>
      (frontImageData == null) || (backImageData == null);

  bool get isUpdating =>
      initialBackImageURL.isNotEmpty && initialBackImageURL.isNotEmpty;

  String get getTitleName {
    switch (profileFieldName) {
      case ProfileFieldName.drivingLicense:
        return 'Driving license';
      case ProfileFieldName.idCard:
        return 'ID card';
      default:
        return 'Edit';
    }
  }

  String get getButtonText {
    switch (profileFieldName) {
      case ProfileFieldName.drivingLicense:
        return isUpdating
            ? 'Update driving license'
            : ' Submit driving license';
      case ProfileFieldName.idCard:
        return isUpdating ? 'Update ID card' : ' Submit ID card';
      default:
        return 'Submit';
    }
  }

  void takeFrontImageFromPhone() async {
    // return;
    final imageURL =
        await Helper.pickThenUploadImage(fileName: 'Document front image');
    if (imageURL.isNotEmpty) {
      frontImageData = imageURL;
    }
    update();
  }

  void takeBackImageFromPhone() async {
    // return;
    final pickedImage =
        await Helper.pickThenUploadImage(fileName: 'Document back image');
    if (pickedImage.isNotEmpty) {
      backImageData = pickedImage;
    }
    update();
  }

  void onSubmitButtonTap() async {
    switch (profileFieldName) {
      case ProfileFieldName.drivingLicense:
        updateProfileDrivingLicense();
        return;
      case ProfileFieldName.idCard:
        updateProfileIDCard();
        return;
      default:
        return;
    }
  }

  bool validateDoubleImage() {
    if (frontImageData == null) {
      AppDialogs.showErrorDialog(
          titleText: 'No front image', messageText: 'Select front image');
      return false;
    }
    if (backImageData == null) {
      AppDialogs.showErrorDialog(
          titleText: 'No back image', messageText: 'Select back image');
      return false;
    }
    if ((frontImageData is String) && (frontImageData as String).isEmpty) {
      AppDialogs.showErrorDialog(
          titleText: 'No front image', messageText: 'Select front image');
      return false;
    }
    if ((backImageData is String) && (backImageData as String).isEmpty) {
      AppDialogs.showErrorDialog(
          titleText: 'No back image', messageText: 'Select back image');
      return false;
    }
    return true;
  }

  Future<void> updateProfileDrivingLicense() async {
    if (validateDoubleImage() == false) {
      return;
    }
    isLoading = true;
    final response = await profileController.updateProfile(request: {
/*       'driving_license': {
        'front': (frontImageData as String),
        'back': (backImageData as String)
      } */
      'driving_license': (frontImageData as String)
    }, showDialog: false);
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

  Future<void> updateProfileIDCard() async {
    if (validateDoubleImage() == false) {
      return;
    }
    isLoading = true;
    final response = await profileController.updateProfile(request: {
/*       'id_card': {
        'front': (frontImageData as String),
        'back': (backImageData as String)
      } */
      'id_card': (frontImageData as String)
    }, showDialog: false);
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

  void _getParameter() {
    final argument = Get.arguments;
    if (argument is ProfileEntryDoubleImageBottomSheetParameter) {
      profileFieldName = argument.profileFieldName;
      initialFrontImageURL = argument.frontImage;
      if (initialFrontImageURL.isNotEmpty) {
        frontImageData = initialFrontImageURL;
      }
      initialBackImageURL = argument.backImage;
      if (initialBackImageURL.isNotEmpty) {
        backImageData = initialBackImageURL;
      }
    }
  }

  @override
  void onInit() {
    _getParameter();
    super.onInit();
  }
}
