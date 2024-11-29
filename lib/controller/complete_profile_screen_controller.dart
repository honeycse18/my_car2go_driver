import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/profile_details.dart';
import 'package:car2godriver/models/api_responses/user_details_response.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CompleteProfileScreenController extends GetxController {
  bool get shouldEnableCompleteButton {
    final isLicenseNumberNotEmpty =
        licenseNumberEditingController.text.isNotEmpty;
    final isDocumentFrontImageNotEmpty = switch (documentFrontImageData) {
      String() => (documentFrontImageData as String).isNotEmpty,
      Uint8List() => (documentFrontImageData as Uint8List).isNotEmpty,
      _ => false
    };
    final isDocumentBackImageNotEmpty = switch (documentBackImageData) {
      String() => (documentBackImageData as String).isNotEmpty,
      Uint8List() => (documentBackImageData as Uint8List).isNotEmpty,
      _ => false
    };
    return isLicenseNumberNotEmpty &&
        isDocumentFrontImageNotEmpty &&
        isDocumentBackImageNotEmpty;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  final GlobalKey<FormState> documentsFormKey = GlobalKey<FormState>();
  String originScreen = 'signUp';
  UserDetailsData userDetailsData = UserDetailsData.empty();

  // RxBool frontFile = false.obs;
  // RxBool backFile = false.obs;

  // String documentFrontImageURL = '';
  // String documentBackImageURL = '';
  // Uint8List documentFrontImageByte = Uint8List(0);
  // Uint8List documentBackImageByte = Uint8List(0);
  dynamic documentFrontImageData;
  dynamic documentBackImageData;

  TextEditingController licenseNumberEditingController =
      TextEditingController();
  File? selectedFrontImage;
  File? selectedBackImage;

  Future<FormData> getRequestBodyFormData() async {
    FormData formData =
        FormData({'license_no': licenseNumberEditingController.text});
    // List<MultipartFile> files = [];
    // List<String> prevDocuments = [];
    if (documentFrontImageData is Uint8List) {
      selectedFrontImage =
          // await Helper.getTempFileFromImageBytes(documentFrontImageByte);
          await Helper.getTempFileFromImageBytes(documentFrontImageData);
      final selectedFrontImageLink = selectedFrontImage;
      // files.add(MultipartFile(selectedFrontImageLink, filename: 'front_image.jpg', contentType: 'image/jpeg'));

      formData.files.add(MapEntry(
          'document_front',
          MultipartFile(selectedFrontImageLink,
              filename: 'front_image.jpg', contentType: 'image/jpeg')));
    }
/*     if (documentFrontImageData is String) {
      // prevDocuments.add(documentFrontImageURL);
      prevDocuments.add(documentFrontImageData);
    } */
    if (documentBackImageData is Uint8List) {
      selectedBackImage =
          // await Helper.getTempFileFromImageBytes(documentBackImageByte);
          await Helper.getTempFileFromImageBytes(documentBackImageData);
      final selectedBackImageLink = selectedBackImage;
      // files.add(MultipartFile(selectedBackImageLink, filename: 'back_image.jpg', contentType: 'image/jpeg'));
      formData.files.add(MapEntry(
          'document_back',
          MultipartFile(selectedBackImageLink,
              filename: 'back_image.jpg', contentType: 'image/jpeg')));
    }
/*     if (documentBackImageData is String) {
      // prevDocuments.add(documentBackImageURL);
      prevDocuments.add(documentBackImageData);
    }
    if (files.isNotEmpty) {
      formData.files.addAll(files.map((e) => MapEntry('documents', e)));
    }
    if (prevDocuments.isNotEmpty) {
      formData.fields
          .addAll(prevDocuments.map((e) => MapEntry('prev_documents', e)));
    } */
    return formData;
  }

  bool validateContinueButton() {
    if (documentsFormKey.currentState?.validate() == false) {
      return false;
    }
    final isDocumentFrontImageLocalDataEmpty = switch (documentFrontImageData) {
      // String() => (documentFrontImageData as String).isEmpty,
      Uint8List() => (documentFrontImageData as Uint8List).isEmpty,
      _ => true
    };
    final isDocumentBackImageLocalDataEmpty = switch (documentBackImageData) {
      // String() => (documentBackImageData as String).isEmpty,
      Uint8List() => (documentBackImageData as Uint8List).isEmpty,
      _ => true
    };
    bool isAnyImageLocalDataEmpty =
        // (documentFrontImageURL.isEmpty && documentFrontImageByte.isEmpty) ||
        // (documentBackImageURL.isEmpty && documentBackImageByte.isEmpty);
        isDocumentFrontImageLocalDataEmpty || isDocumentBackImageLocalDataEmpty;
    bool isAllImageLocalDataEmpty =
        isDocumentFrontImageLocalDataEmpty && isDocumentBackImageLocalDataEmpty;
    // bool isAnyImageSelected = isAnyImageLocalDataEmpty == false;
    bool isLicenseNumberNotChanged =
        userDetailsData.licenseNo == licenseNumberEditingController.text;
    if (isAllImageLocalDataEmpty && isLicenseNumberNotChanged) {
      AppDialogs.showErrorDialog(
          messageText:
              'Please update to license number or image to update documents');
      return false;
    }
    return true;
  }

  void onContinueButtonTap() async {
    if (validateContinueButton() == false) {
      return;
    }
    isLoading = true;
    final FormData requestData = await getRequestBodyFormData();
    RawAPIResponse? response = await APIRepo.updateUserProfile(requestData);
    if (response == null) {
      isLoading = false;
      Helper.showSnackBar('No response for updating vehicle');
      return;
    } else if (response.error) {
      isLoading = false;
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessUpdatingDocuments(response);
  }

  void onSuccessUpdatingDocuments(RawAPIResponse response) async {
    try {
      await selectedFrontImage?.delete();
      await selectedBackImage?.delete();
    } catch (_) {}
    selectedFrontImage = null;
    selectedBackImage = null;
    UserDetailsResponse? userDetails = await APIRepo.getUserDetails();
    isLoading = false;
    if (userDetails == null) {
      Helper.showSnackBar('No response for User Details!');
      return;
    } else if (userDetails.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessFetchingUserDetails(userDetails);
  }

  void onSuccessFetchingUserDetails(UserDetailsResponse userDetails) async {
    await Helper.setLoggedInUserToLocalStorage(
        userDetails.data as ProfileDetails);
    BuildContext? context = Get.context;
    if (context != null) {
      if (originScreen == 'signUp') {
        Get.offNamed(AppPageNames
            .zoomDrawerScreen); // TODO: Need to check should replace  Helper.getBackToHomePage();

        AppDialogs.showSuccessDialog(
            messageText: AppLanguageTranslation
                .documentsSubmittedSuccessfullyTransKey.toCurrentLanguage);
      } else if (originScreen == 'edit') {
        Get.back();
        AppDialogs.showSuccessDialog(
            messageText: AppLanguageTranslation
                .documentsUpdatedSuccessfullyTransKey.toCurrentLanguage);
      } else {
        AppDialogs.showErrorDialog(
            messageText: 'Origin Screen couldn\'t be recognized!');
      }
      return;
    }
    /* solve error
    write updated user details to localStorage */
  }

  void _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      originScreen = params;
      if (originScreen == 'edit') {
        // userDetailsData = Helper.getUser() as UserDetailsData; // TODO: uncomment this line once ready to fix this page
        licenseNumberEditingController.text = userDetailsData.licenseNo;
/*         if (userDetailsData.documents.length < 2) {
          // documentFrontImageURL = '';
          // documentBackImageURL = '';
          documentFrontImageData = null;
          documentBackImageData = null;
        } else {
          // documentFrontImageURL = userDetailsData.documents[0];
          // documentBackImageURL = userDetailsData.documents[1];
          documentFrontImageData = userDetailsData.documents[0];
          documentFrontImageData = userDetailsData.documents[1];
          frontFile.value = true;
          backFile.value = true;
        } */
        documentFrontImageData = userDetailsData.documents.front;
        // frontFile.value = (documentFrontImageData is String) && (documentFrontImageData as String).isNotEmpty;
        documentBackImageData = userDetailsData.documents.back;
        // backFile.value = (documentBackImageData is String) && (documentBackImageData as String).isNotEmpty;
        update();
      }
    }
    log(originScreen);
    update();
  }

  void onFrontImageUploadTap() async {
    final pickedImage = await Helper.pickImage(
        // onSuccessUploadSingleImage: _onSuccessUploadingFrontImageTap,
        imageName: 'Front image');
    _onSuccessUploadingFrontImageTap(pickedImage, {});
  }

  void _onSuccessUploadingFrontImageTap(
      Uint8List? rawImagesData, Map<String, dynamic> additionalData) {
    // documentFrontImageByte = rawImagesData ?? Uint8List(0);
    documentFrontImageData = rawImagesData ?? Uint8List(0);
    // frontFile.value = true;
    update();
    Helper.showSnackBar(
        AppLanguageTranslation.uploadedFrontImageTransKey.toCurrentLanguage);
  }

  void onFrontImageDeleteTap() {
    // documentFrontImageByte = Uint8List(0);
    // documentFrontImageURL = '';
    documentFrontImageData = null;
    // frontFile.value = false;
    // documentBackImageByte = Uint8List(0);
    // documentBackImageURL = '';
    // documentBackImageData = '';
    // backFile.value = false;
    update();
  }

  void onBackImageDeleteTap() {
    documentBackImageData = null;
    update();
  }

  void onBackImageUploadTap() async {
    final pickedImage = await Helper.pickImage(
        // onSuccessUploadSingleImage: _onSuccessUploadingBackImageTap,
        imageName: 'Back image');
    _onSuccessUploadingBackImageTap(pickedImage, {});
  }

  void _onSuccessUploadingBackImageTap(
      Uint8List? rawImagesData, Map<String, dynamic> additionalData) {
    // documentBackImageByte = rawImagesData ?? Uint8List(0);
    documentBackImageData = rawImagesData ?? Uint8List(0);
    // backFile.value = true;
    update();
    Helper.showSnackBar(
        AppLanguageTranslation.uploadedBackImageTransKey.toCurrentLanguage);
  }

/*   void onBackImageDeleteTap() {
    documentBackImageByte = Uint8List(0);
    documentBackImageURL = '';
    backFile = false;
    update();
  } */

  @override
  void onInit() {
    _getScreenParameters();
    licenseNumberEditingController.addListener(update);
    super.onInit();
  }
}
