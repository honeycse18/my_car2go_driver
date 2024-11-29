import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:car2godriver/models/api_responses/bottom_sheet_params/profile_entry_gender_bottom_sheet_parameter.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/api_response.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/country_list_response.dart';
import 'package:car2godriver/models/api_responses/driver_vehicle_dynamic_fields.dart';
import 'package:car2godriver/models/api_responses/profile_details.dart';
import 'package:car2godriver/models/api_responses/user_details_response.dart';
import 'package:car2godriver/models/enums/gender.dart';
import 'package:car2godriver/models/enums/api/profile_field_name.dart';
import 'package:car2godriver/models/local/dynamic_field_request.dart';
import 'package:car2godriver/models/location_model.dart';
import 'package:car2godriver/ui/screens/bottomsheet/profile_field_bottomsheet.dart';
import 'package:car2godriver/ui/screens/bottomsheet/profile_gender_bottomsheet.dart';
import 'package:car2godriver/ui/screens/bottomsheet/submit_document_bottomsheet.dart';
import 'package:car2godriver/services/profile_service.dart';
import 'package:car2godriver/ui/bottomsheets/confirm_bottom_sheet.dart';
import 'package:car2godriver/utils/app_singleton.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:collection/collection.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccountScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  final profileService = Get.find<ProfileService>();
  StreamSubscription<ProfileDetails>? profileUpdateSubscriber;
  // ProfileDetails driverProfile = ProfileDetails.empty();
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController phoneController = TextEditingController();
  // final TextEditingController genderController = TextEditingController();
  // Gender selectedGender = Gender.unknown;
  // final TextEditingController cityController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  DriverVehicleDynamicFields dynamicFields = DriverVehicleDynamicFields();
  List<DynamicFieldRequest> dynamicFieldValues = [];

  bool _isEditing = false;
  bool get isEditing => _isEditing;
  set isEditing(bool value) {
    _isEditing = value;
    update();
  }

  bool get isNotEditing => isEditing == false;

  UserDetailsCountry? selectedCountry;
  List<UserDetailsCountry> countryList = [];
  bool editActive = false;

  bool imageEdit = false;
  bool nameEdit = false;
  bool emailEdit = false;
  bool phoneEdit = false;
  bool dialEdit = false;
  bool genderEdit = false;
  bool addressEdit = false;
  // bool countryEdit = false;

  List<Uint8List> selectedProfileImages = [];
  // Uint8List selectedProfileImage = Uint8List(0);
  dynamic selectedProfileImage;

  bool emailVerified = false;
  bool phoneVerified = true;
  ProfileDetails get profileDetails => profileService.profileDetails;
  set profileDetails(ProfileDetails value) {
    profileService.profileDetails = value;
  }

  String dialCode = '';
  //String phoneNumber = '';
  // String? selectedGender;
  //Gender? selectedGender;
  LocationModel? selectedLocation;
  CountryCode currentCountryCode = AppSingleton.instance.currentCountryCode;
  // final RxBool isDropdownOpen = false.obs;
  // final RxString selectedGender = 'Select Gender'.obs;
  // TextEditingController emailTextEditingController = TextEditingController();
  // TextEditingController phoneTextEditingController = TextEditingController();
  // TextEditingController nameTextEditingController = TextEditingController();
  // TextEditingController addressTextEditingController = TextEditingController();

  // List<String> genderOptions = ["Male", "Female", "Other"];
  // List<String> genderOptions = ["Male", "Female", "Other"];
  bool _isImageUpdating = false;
  bool get isImageUpdating => _isImageUpdating;
  set isImageUpdating(bool value) {
    _isImageUpdating = value;
    update();
  }

  void onFullNameTap() {
    Get.bottomSheet(
        isScrollControlled: true,
        const EditProfileFieldBottomSheet(),
        settings: RouteSettings(
            arguments: ProfileEntryTextFieldBottomSheetParameter(
                profileFieldName: ProfileFieldName.name,
                initialValue: profileDetails.name)));
  }

  void onEmailAddressTap() {
    Get.bottomSheet(
        isScrollControlled: true,
        const EditProfileFieldBottomSheet(),
        settings: RouteSettings(
            arguments: ProfileEntryTextFieldBottomSheetParameter(
                profileFieldName: ProfileFieldName.email,
                initialValue: profileDetails.email)));
  }

  void onPhoneNumberTap() {
    Get.bottomSheet(
        isScrollControlled: true,
        const EditProfileFieldBottomSheet(),
        settings: RouteSettings(
            arguments: ProfileEntryTextFieldBottomSheetParameter(
                initialValue: profileDetails.phone,
                profileFieldName: ProfileFieldName.phone)));
  }

  void onGenderTap() async {
    final result = await Get.bottomSheet(
        isScrollControlled: true,
        const EditProfileGenderBottomsheet(),
        settings: RouteSettings(
            arguments: ProfileEntryGenderBottomSheetParameter(
                profileGenderName: profileDetails.genderAsEnum)));
    if (result is Gender) {
      profileDetails.gender = result.stringValue;
      update();
    }
    _refreshProfileUIDetails();
  }

  void onCityTap() async {
    final result = await Get.bottomSheet(
        isScrollControlled: true,
        const EditProfileFieldBottomSheet(),
        settings: RouteSettings(
            arguments: ProfileEntryTextFieldBottomSheetParameter(
                profileFieldName: ProfileFieldName.city,
                initialValue: profileDetails.city)));
    if (result is String) {
      profileDetails.city = result;
    }
  }

  void onEditProfileButtonTap() {
    AppDialogs.showConfirmDialog(
      messageText: 'Confirm to edit profile?',
      onYesTap: () async {
        isEditing = true;
      },
    );
  }

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    AppSingleton.instance.currentCountryCode = countryCode;
    update();
    if (currentCountryCode.dialCode == dialCode) {
      dialEdit = false;
    } else {
      dialEdit = true;
    }
    update();
    editable();
  }

  Widget countryElementsList(UserDetailsCountry country) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          CountryFlag.fromCountryCode(
            country.code,
            height: 60,
            width: 60,
            borderRadius: 15,
          ),
          AppGaps.wGap15,
          Expanded(
              child: Text(
            country.name,
            style: AppTextStyles.bodyBoldTextStyle,
          ))
        ],
      ),
    );
  }

  /*<----------- Get country elements ride from API ----------->*/
  Future<void> getCountryElementsRide() async {
    CountryListResponse? response = await APIRepo.getCountryList();
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForThisActionTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingElements(response);
  }

  onSuccessRetrievingElements(CountryListResponse response) {
    countryList = response.data;
    update();
  }

  /* <---- Address tap ----> */
  void onAddressTap() async {
    final result = await Get.bottomSheet(
        isScrollControlled: true,
        const EditProfileFieldBottomSheet(),
        settings: RouteSettings(
            arguments: ProfileEntryTextFieldBottomSheetParameter(
                profileFieldName: ProfileFieldName.address,
                initialValue: profileDetails.address)));
    if (result is String) {
      profileDetails.address = result;
    }
  }

  void onDriverLicenseTap() async {
    final result = await Get.bottomSheet(
      isScrollControlled: true,
      const ConfirmBottomSheet(
        title:
            'If you update your Driving License, your profile will be deactivated for verification!',
        yesButtonText: 'Yes, Update',
        noButtonText: 'No, Keep it',
      ),
    );
    if (result is bool && result) {
      Get.bottomSheet(const SubmitDocumentBottomSheet(),
          settings: RouteSettings(
              arguments: ProfileEntryDoubleImageBottomSheetParameter(
                  // backImage: profileDetails.drivingLicense.back,
                  // frontImage: profileDetails.drivingLicense.front,
                  backImage: profileDetails.drivingLicense,
                  frontImage: profileDetails.drivingLicense,
                  profileFieldName: ProfileFieldName.drivingLicense)));
    }
  }

  void onIDCardTap() async {
    final result = await Get.bottomSheet(
      isScrollControlled: true,
      const ConfirmBottomSheet(
        title:
            'If you update your ID card, your profile will be deactivated for verification!',
        yesButtonText: 'Yes, Update',
        noButtonText: 'No, Keep it',
      ),
    );
    if (result is bool && result) {
      Get.bottomSheet(const SubmitDocumentBottomSheet(),
          settings: RouteSettings(
              arguments: ProfileEntryDoubleImageBottomSheetParameter(
                  backImage: profileDetails.idCard.back,
                  frontImage: profileDetails.idCard.front,
                  profileFieldName: ProfileFieldName.idCard)));
    }
  }

  /* <---- Edit image button tap ----> */
  void onEditImageButtonTap() async {
    /*  if (fieldEditCheck()) {
      return;
    } */
    final pickedImages = await Helper.pickThenUploadImage(
        // onSuccessUploadSingleImage: _onSuccessUploadingProfileImage,
        fileName: 'Profile Image');
    // _onSuccessUploadingProfileImage(pickedImages, {});
    if (pickedImages.isEmpty) {
      return;
    }
    selectedProfileImage = pickedImages;
    isImageUpdating = true;
    await updateProfile(request: {'image': (selectedProfileImage as String)});
    isImageUpdating = false;
    update();
  }

  /* <---- Success uploading profile image ----> */
  void _onSuccessUploadingProfileImage(
      List<Uint8List?> rawImagesData, Map<String, dynamic> additionalData) {
    selectedProfileImages.clear();
    selectedProfileImages.addAll(rawImagesData.whereType<Uint8List>().toList());
    update();
    if (selectedProfileImages.isEmpty) {
      imageEdit = false;
    } else {
      imageEdit = true;
      selectedProfileImage = selectedProfileImages.firstOrNull ?? Uint8List(0);
    }
    update();
    editable();
    Get.snackbar(
        AppLanguageTranslation.successfullyUploadedTranskey.toCurrentLanguage,
        AppLanguageTranslation
            .successfullyuploadedNewProfileImageTransKey.toCurrentLanguage);
  }

  /* <---- Save changes button tap ----> */
  void onSaveChangesButtonTap() {
    log('Save Changes button got tapped!');
    // updateProfile();
  }

  /* <---- Update profile from API ----> */
  Future<APIResponse<ProfileDetails>?> updateProfile(
      {required Map<String, dynamic> request, bool showDialog = true}) async {
    final response = await APIRepo.updateProfileDetails(request);
    if (response == null) {
      if (showDialog) {
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .noResponseForUpdatingProfileImageTranskey.toCurrentLanguage);
      }
      return response;
    } else if (response.error) {
      if (showDialog) {
        AppDialogs.showErrorDialog(messageText: response.message);
      }
      return response;
    }
    log(response.toJson((data) => data.toJson()).toString());
    await Helper.updateSavedDriverDetails();
    await _refreshProfileUIDetails();
    if (showDialog) {
      AppDialogs.showSuccessDialog(messageText: response.message);
    }
    return response;
    // onSuccessUpdatingProfile(response);
  }

  onSuccessUpdatingProfile(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    setUpdatedUserDetailsToLocalStorage();
  }

  /* <---- Set updated user details to local storage  ----> */
  Future<void> setUpdatedUserDetailsToLocalStorage() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForThisActionTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInUserDetails(response);
  }

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data as ProfileDetails);
    getUser();
    selectedProfileImage = Uint8List(0);
    selectedProfileImages.clear();

    imageEdit = false;
    nameEdit = false;
    emailEdit = false;
    phoneEdit = false;
    dialEdit = false;
    genderEdit = false;
    addressEdit = false;
    // countryEdit = false;
    editable();
    update();
  }

  // void onGenderChange(Gender? newGender) {
  //   selectedGender = newGender;
  //   genderEdit = selectedGender != userDetails.genderAsEnum;
  //   update();
  //   editable();
  // }

  String getPhoneFormatted() {
    // return '${currentCountryCode.dialCode}${phoneTextEditingController.text}';
    return '${currentCountryCode.dialCode}${profileDetails.phone}';
  }

  void getUser() {
    profileDetails = Helper.getUser();
    _setPhoneNumber(profileDetails.phone);
    //_selectGender(userDetails.gender);
/*     LocationModel prevLocation = LocationModel(
        latitude: userDetails.location.lat,
        longitude: userDetails.location.lng,
        address: userDetails.address);
    selectedLocation = prevLocation; */
    if (dialCode.isNotEmpty) {
      currentCountryCode = CountryCode.fromDialCode(dialCode);
    }
    // selectedCountry = countryList
    //     .firstWhereOrNull((element) => element.id == userDetails.country.id);

    update();
  }

  void fillProfileDetails(ProfileDetails profile) {
    // profile = Helper.getUser();
    // nameTextEditingController.text = profile.name;
    if (profile.image.isNotEmpty) {
      selectedProfileImage = profile.image;
    }
    // _setPhoneNumber(profile.phone);
    //_selectGender(profile.gender);
/*     LocationModel prevLocation = LocationModel(
        latitude: profile.location.lat,
        longitude: profile.location.lng,
        address: profile.address);
    selectedLocation = prevLocation; */
    if (dialCode.isNotEmpty) {
      currentCountryCode = CountryCode.fromDialCode(dialCode);
    }
/*     dynamicFieldValues.forEachIndexed(
      (index,element) {
        element.key = driverDetails.dynamicFields[]
      },
    ); */
    // selectedCountry = countryList
    //     .firstWhereOrNull((element) => element.id == profile.country.id);

    update();
  }

  // void _selectGender(String gender) {
  //   final foundGender = Gender.list
  //       .firstWhereOrNull((element) => element.stringValue == gender);
  //   if (foundGender != null) {
  //     selectedGender = foundGender;
  //   }
  // }

  void _setPhoneNumber(String phoneNumber) {
    final phoneNumberParts = Helper.separatePhoneAndDialCode(phoneNumber);
    dialCode = phoneNumberParts?.dialCode ?? '';
    phoneNumber = phoneNumberParts?.strippedPhoneNumber ?? '';
    if (dialCode.isNotEmpty) {
      currentCountryCode = CountryCode.fromDialCode(dialCode);
    }
    // phoneController.text = phoneNumber;
    update();
  }

  bool imageEditCheck() {
    bool ret = false;
    if (imageEdit) {
      /* AppDialogs.showConfirmDialog(
        shouldCloseDialogOnceYesTapped: true,
        messageText: AppLanguageTranslation
            .youCanUpdateEitherImageOrFieldsOnceTranskey.toCurrentLanguage,
        onYesTap: () async {
          selectedProfileImage = Uint8List(0);
          imageEdit = false;
          editable();
          ret = false;
          update();
        },
      ); */
      if (imageEdit) {
        ret = true;
      }
    }
    return ret;
  }

  /*  bool fieldEditCheck() {
    bool ret = false;
    if (nameEdit ||
        emailEdit ||
        phoneEdit ||
        dialEdit ||
        genderEdit ||
        addressEdit /* countryEdit */) {
      /* AppDialogs.showConfirmDialog(
        messageText: AppLanguageTranslation
            .youCanUpdateEitherImageOrFieldsOnceTranskey.toCurrentLanguage,
        onYesTap: () async {
          nameTextEditingController.text = '';
          emailTextEditingController.text = '';
          phoneTextEditingController.text = '';
          addressTextEditingController.text = '';
          // selectedCountry = countryList.firstWhereOrNull(
          //     (element) => element.id == userDetails.country.id);
          nameEdit = false;
          emailEdit = false;
          phoneEdit = false;
          dialEdit = false;
          genderEdit = false;
          addressEdit = false;
          // countryEdit = false;
          ret = false;
          update();
          editable();
        },
      ); */
      if (nameEdit ||
              emailEdit ||
              phoneEdit ||
              dialEdit ||
              genderEdit ||
              addressEdit /* ||
          countryEdit */
          ) {
        ret = true;
      }
    }
    return ret;
  }
 */
  editable() {
    if (imageEdit ||
            nameEdit ||
            emailEdit ||
            phoneEdit ||
            dialEdit ||
            genderEdit ||
            addressEdit /* ||
        countryEdit */
        ) {
      editActive = true;
    } else {
      editActive = false;
    }
    update();
  }

  /// Return dynamic fields where the values set from profile dynamic values
  List<DynamicFieldRequest> _setDynamicFieldValuesFromProfile(
      {required List<DynamicFieldRequest> dynamicFieldValues,
      required List<ProfileDetailsDynamicField> profileDynamicFieldValues}) {
    dynamicFieldValues.forEachIndexed((index, dynamicFieldValue) {
      final found = profileDynamicFieldValues.firstWhereOrNull(
          (element) => element.key == dynamicFieldValue.keyValue);
      if (found != null) {
        dynamicFieldValue.values = found.value;
      }
    });
    return dynamicFieldValues;
  }

  /// Return dynamic fields where dynamic field values are added if not found in
  /// the profile
  List<DynamicFieldRequest> addDynamicFieldValuesNonExistingFromProfile(
      {required List<DynamicFieldRequest> dynamicFieldValues,
      required List<ProfileDetailsDynamicField> profileDynamicFieldValues}) {
    dynamicFieldValues.addAll(profileDynamicFieldValues
        .whereNot((driverDynamicField) => dynamicFieldValues
            .any((element) => element.keyValue == driverDynamicField.key))
        .map((e) => DynamicFieldRequest(
            driverFieldInfo: DriverDynamicField.empty(),
            vehicleFieldInfo: VehicleDynamicField.empty(),
            values: e.value,
            keyValue: e.key,
            type: e.type)));
    return dynamicFieldValues;
  }

  Future<void> _getDynamicFields() async {
    final response = await APIRepo.getDynamicFields();
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);
      return;
    }
    dynamicFields = response.data;
    dynamicFieldValues = dynamicFields.driverFields
        .map((e) => DynamicFieldRequest(
            driverFieldInfo: e,
            vehicleFieldInfo: VehicleDynamicField.empty(),
            keyValue: e.fieldName,
            type: e.type,
            values: []))
        .toList();
    update();
  }

  Future<void> _refreshProfileUIDetails() async {
    // driverDetails = Helper.getUser();
    fillProfileDetails(profileDetails);
  }

  @override
  void onInit() async {
    profileUpdateSubscriber ??= profileService.profileDetailsRX.listen((data) {
      update();
    });
    _refreshProfileUIDetails();
    // driverDetails = Helper.getUser();
    await _getDynamicFields();
    dynamicFieldValues = _setDynamicFieldValuesFromProfile(
        dynamicFieldValues: dynamicFieldValues,
        profileDynamicFieldValues: profileDetails.dynamicFields);
    super.onInit();
  }

  @override
  void onClose() {
    profileUpdateSubscriber?.cancel();
    profileUpdateSubscriber = null;
    super.onClose();
  }
}
