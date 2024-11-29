import 'package:car2godriver/controller/add_vehicle_screen_controller.dart';
import 'package:car2godriver/models/local/dynamic_field_request.dart';
import 'package:car2godriver/models/local/profile_dynamic_field_widget_paramter.dart';
import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditVehicleDynamicFieldBottomSheetController extends GetxController {
  // final profileController = Get.find<MyAccountScreenController>();
  final addVehicleController = Get.find<AddVehicleScreenController>();
  TextEditingController textController = TextEditingController();
  DynamicFieldRequest valueDetails = DynamicFieldRequest.empty();
  final List<String> initialFieldValues = [];
  final List<String> fieldValues = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  bool get isFieldValueUpdated => initialFieldValues.isNotEmpty;

  String get buttonText => isFieldValueUpdated ? "Update" : "Submit";

  void uploadSingleImage() async {
    final imageURL = await Helper.pickThenUploadImage(fileName: 'single_img');
    if (imageURL.isEmpty) {
      return;
    }
    fieldValues.assign(imageURL);
    update();
  }

  void onSingleImageDeleteTap() {
    fieldValues.clear();
    update();
  }

  void onMultipleImageTap(int index) {
    Get.toNamed(AppPageNames.imageZoomScreen,
        arguments: fieldValues.elementAtOrNull(index));
  }

  void onMultipleImageEditTap(int index) async {
    final imageURL = await Helper.pickThenUploadImage(fileName: 'single_img');
    if (imageURL.isEmpty) {
      return;
    }
    fieldValues[index] = imageURL;
    update();
  }

  void onMultipleImageDeleteTap(int index) {
    fieldValues.removeAt(index);
    update();
  }

  Future<void> uploadMultipleImages({int? maxImageCount}) async {
    final maxAllowUnset =
        valueDetails.vehicleFieldInfo.fieldInfo.maxAllow == -1;
    final selectableMaxImageCount = (maxImageCount ??
        (maxAllowUnset
            ? AppConstants.maximumMultipleImageCount
            : valueDetails.vehicleFieldInfo.fieldInfo.maxAllow));
    if (fieldValues.length + 1 > selectableMaxImageCount) {
      AppDialogs.showErrorDialog(
          messageText:
              'You cannot select more than $selectableMaxImageCount images');
      return;
    }
    final imageURLs = await Helper.pickThenUploadImages(
        fileName: 'single_img', maxImages: selectableMaxImageCount);
    if (imageURLs.isEmpty) {
      return;
    }
    fieldValues.addAll(imageURLs);

    update();
  }

  void onSubmitButtonTap() {
    updateDynamicProfile();
  }

/*   bool validateProfileUpdate() {
    switch (valueDetails.vehicleFieldInfo.typeAsSealedClass) {
      case DynamicFieldText():
        if (textController.text.isEmpty) {
          AppDialogs.showErrorDialog(
              titleText: 'Text is empty',
              messageText: 'Please enter some text');
          return false;
        }
        return true;
      case DynamicFieldTextarea():
        if (textController.text.isEmpty) {
          AppDialogs.showErrorDialog(
              titleText: 'Text is empty',
              messageText: 'Please enter some text');
          return false;
        }
        return true;
      case DynamicFieldEmail():
        if (textController.text.isEmpty) {
          AppDialogs.showErrorDialog(
              titleText: 'Text is empty',
              messageText: 'Please enter some text');
          return false;
        }
        return true;
      case DynamicFieldNumber():
        if (textController.text.isEmpty) {
          AppDialogs.showErrorDialog(
              titleText: 'Text is empty',
              messageText: 'Please enter some text');
          return false;
        }
        return true;
      case DynamicFieldImage():
        switch (valueDetails.vehicleFieldInfo.typeAsSealedClass) {
          case DynamicFieldSingleImage():
            if (fieldValues.isEmpty) {
              AppDialogs.showErrorDialog(
                  titleText: 'No image set',
                  messageText: 'Please select image');
              return false;
            }
            return true;
          case DynamicFieldMultipleImage():
            if (fieldValues.isEmpty) {
              AppDialogs.showErrorDialog(
                  titleText: 'No image set',
                  messageText: 'Please select image');
              return false;
            }
            final multipleImageInfo = (valueDetails.vehicleFieldInfo
                .typeAsSealedClass as DynamicFieldMultipleImage);
            if (fieldValues.length < multipleImageInfo.maxImageCount) {
              AppDialogs.showErrorDialog(
                  titleText: 'All images must be set',
                  messageText: 'Please select all the images');
              return false;
            }
            return true;
          default:
            return true;
        }
      default:
        return true;
    }
  } */

  Future<void> updateDynamicProfile() async {
    if (valueDetails.vehicleFieldInfo.typeAsSealedClass.isTextField) {
      fieldValues.assign(textController.text);
    }
/*     if (validateProfileUpdate() == false) {
      return;
    } */
    final int foundIndex = addVehicleController.dynamicFieldValues
        .indexWhere((element) => element.keyValue == valueDetails.keyValue);
    if (foundIndex == -1) {
      AppDialogs.showErrorDialog(messageText: 'Failed to update info');
      return;
    }
    addVehicleController.dynamicFieldValues[foundIndex].values = fieldValues;
/*     final profileDynamicFields =
        addVehicleController.addDynamicFieldValuesNonExistingFromProfile(
            dynamicFieldValues: addVehicleController.dynamicFieldValues,
            profileDynamicFieldValues:
                addVehicleController.profileDetails.dynamicFields);
    final filteredProfileDynamicFields = profileDynamicFields
        .where((element) => element.values.isNotEmpty)
        .toList(); */
/*     isLoading = true;
    final response = await addVehicleController.updateProfile(request: {
      'dynamic_fields':
          filteredProfileDynamicFields.map((e) => e.toRequestJson()).toList(),
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
    } */
    Get.back(result: true);
  }

  void _setFieldValueIntoInitialUIState() {
    initialFieldValues.assignAll(valueDetails.values);
    fieldValues.assignAll(initialFieldValues);
    if (valueDetails.vehicleFieldInfo.typeAsSealedClass.isTextField) {
      textController.text = fieldValues.firstOrNull ?? '';
      return;
    }
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is ProfileDynamicFieldWidgetParameter) {
      valueDetails = argument.valueDetails;
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    _setFieldValueIntoInitialUIState();
    textController.addListener(update);
    super.onInit();
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
