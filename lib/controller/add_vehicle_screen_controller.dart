import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:car2godriver/models/api_responses/driver_vehicle_dynamic_fields.dart';
import 'package:car2godriver/models/api_responses/profile_details.dart';
import 'package:car2godriver/models/api_responses/vehicle_brand_info.dart';
import 'package:car2godriver/models/api_responses/vehicle_model_info.dart';
import 'package:car2godriver/models/api_responses/vehicle_types_info.dart';
import 'package:car2godriver/models/local/dynamic_field_request.dart';
import 'package:car2godriver/services/profile_service.dart';
import 'package:car2godriver/ui/dialogs/vehicle_year_picker/vehicle_year_picker_dialog.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:collection/collection.dart';

import 'package:car2godriver/models/api_responses/vehicle_elements_data_response.dart';
import 'package:car2godriver/models/enums.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVehicleScreenController extends GetxController {
  final profileService = Get.find<ProfileService>();
  StreamSubscription<ProfileDetails>? profileUpdateSubscriber;
  ProfileDetails get profileDetails => profileService.profileDetails;
  set profileDetails(ProfileDetails value) {
    profileService.profileDetails = value;
  }

  bool isVehicleRegisterForSignup = false;
  List<VehicleTypeInfo> vehicleCategories = const [];
  VehicleTypeInfo selectedVehicleCategory = VehicleTypeInfo.empty();
  List<VehicleBrandInfo> vehicleBrands = [];
  VehicleBrandInfo? selectedVehicleBrand;
  List<VehicleModelInfo> vehicleModels = [];
  VehicleModelInfo? selectedVehicleModel;
  int? selectedSeatCount;
  int selectedYear = AppConstants.defaultUnsetDateTimeYear;
  List<String> vehicleImages = [];

  // int selectedOptionIndex = 0;
  /*<----------- Initialize variables ----------->*/
  DriverVehicleDynamicFields dynamicFields = DriverVehicleDynamicFields();
  List<DynamicFieldRequest> dynamicFieldValues = [];

  bool back = false;
  // Category selectedVehicleCategory = Category();

  String carId = '';
  CategoryShortItem categoryShortItems = CategoryShortItem();
  List<String> gearTypes = ['automatic', 'manual'];
  List<String> hasAcs = ['No', 'Yes'];
  List<Category> categories = [];
  List<Subcategory> subcategories = [];
  Subcategory? selectedSubcategory;
  Category? selectedCategory;
  TextEditingController yearController = TextEditingController();
  AddVehicleTabState _addVehicleState = AddVehicleTabState.vehicle;
  AddVehicleTabState get currentVehicleState => _addVehicleState;
  set currentVehicleState(AddVehicleTabState value) {
    _addVehicleState = value;
    update();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  bool _isBrandLoading = false;
  bool get isBrandLoading => _isBrandLoading;
  set isBrandLoading(bool value) {
    _isBrandLoading = value;
    update();
  }

  bool _isModelLoading = false;
  bool get isModelLoading => _isModelLoading;
  set isModelLoading(bool value) {
    _isModelLoading = value;
    update();
  }

  List<String> galleryImageURLs = [];
  List<dynamic> selectedVehicleImageURLs = [];
  List<dynamic> selectedDocumentsImageURLs = [];
  String selectedColor = 'red';
  String selectedFuelType = 'Water';
  String selectedGearType = 'automatic';
  String selectedVehicleModelType = 'Chevy II Nova 396';
  bool hasAC = false;
  bool isFirstTabSelected = false;
  bool isSecondTabSelected = false;
  bool isThirdTabSelected = false;

  TextEditingController vehicleNameTextEditingController =
      TextEditingController();
  TextEditingController vehicleModelTextEditingController =
      TextEditingController();
  TextEditingController modelYearTextEditingController =
      TextEditingController();
  TextEditingController maxPowerTextEditingController = TextEditingController();
  TextEditingController maxSpeedTextEditingController = TextEditingController();
  TextEditingController seatCapacityTextEditingController =
      TextEditingController();
  TextEditingController milageTextEditingController = TextEditingController();
  TextEditingController numberPlateTextEditingController =
      TextEditingController();
  TextEditingController vehicleColorTextEditingController =
      TextEditingController();
  // FileUploadController imagesUploadController = FileUploadController;

  final RxBool isSubmitAddVehicleLoading = false.obs;
  final RxBool isAddVehicleDetailsLoading = false.obs;

  bool get shouldGoToInformationStep => selectedVehicleCategory.isNotEmpty;
  bool get shouldNotGoToInformationStep => shouldGoToInformationStep == false;

  bool get shouldGoToDocumentsStep =>
      vehicleNameTextEditingController.text.isNotEmpty &&
      // selectedSubcategory != null &&
      vehicleModelTextEditingController.text.isNotEmpty &&
      modelYearTextEditingController.text.isNotEmpty &&
      numberPlateTextEditingController.text.isNotEmpty &&
      vehicleColorTextEditingController.text.isNotEmpty &&
      seatCapacityTextEditingController.text.isNotEmpty;
  bool get shouldNotGoToDocumentsStep => shouldGoToDocumentsStep == false;

  bool get isRequiredDynamicFieldValuesNotEmpty => dynamicFieldValues
      .where(
        (element) => element.driverFieldInfo.isRequired,
      )
      .every((element) => element.values.isNotEmpty);
  bool get shouldRegisterVehicle =>
      selectedVehicleBrand != null &&
      selectedVehicleModel != null &&
      selectedSeatCount != null &&
      selectedYear != AppConstants.defaultUnsetDateTimeYear &&
      numberPlateTextEditingController.text.isNotEmpty &&
      vehicleImages.isNotEmpty &&
      isRequiredDynamicFieldValuesNotEmpty;

  bool get shouldNotRegisterVehicle => shouldRegisterVehicle == false;

  bool get shouldSubmit =>
      selectedVehicleImageURLs.isNotEmpty &&
      selectedDocumentsImageURLs.isNotEmpty;
  bool get shouldNotSubmit => shouldSubmit == false;

  void onVehicleCategorySelected(VehicleTypeInfo category) {
    selectedVehicleCategory = category;
    selectedVehicleBrand = null;
    selectedVehicleModel = null;
    _getVehicleBrands(selectedVehicleTypeID: selectedVehicleCategory.id);
    update();
  }

  void onVehicleBrandSelected(VehicleBrandInfo? brand) {
    if (brand == null) {
      return;
    }
    selectedVehicleBrand = brand;
    selectedVehicleModel = null;
    _getVehicleModels(
        selectedVehicleTypeID: selectedVehicleCategory.id,
        selectedBrandID: selectedVehicleBrand!.id);
    update();
  }

  void onVehicleModelSelected(VehicleModelInfo? model) {
    selectedVehicleModel = model;
    update();
  }

  void onVehicleSeatSelected(int? seat) {
    selectedSeatCount = seat;
    update();
  }

  void onYearTap(BuildContext context) async {
    final result = await Get.dialog(const VehicleYearPickerDialog(),
        arguments: selectedYear);
    if (result is DateTime) {
      selectedYear = result.year;
      yearController.text = selectedYear.toString();
      update();
    }

    /* final now = DateTime.now();
    final firstDate = DateTime(
        now.year - AppConstants.minimumVehicleModelYearDecrementCounter,
        now.month,
        now.day);
    // Get.dialog(widget);
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: now,
        initialDate: now,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDatePickerMode: DatePickerMode.year);
    if (selectedDate == null) {
      return;
    }
    selectedYear = selectedDate.year;
    yearController.text = selectedYear.toString();
    update(); */
  }

  void onUploadVehicleImagesTap() async {
    final images =
        await Helper.pickThenUploadImages(fileName: 'vehicle_images');
    if (images.isEmpty) {
      AppDialogs.showErrorDialog(
          messageText: 'Failed to select images. Try again');
      return;
    }
    vehicleImages.addAll(images);
    update();
  }

  void onVehicleImageTap(int index) {
    Get.toNamed(AppPageNames.imageZoomScreen, arguments: vehicleImages[index]);
  }

  void onEditVehicleImagesTap(int index) async {
    final image = await Helper.pickThenUploadImage(fileName: 'vehicle_image');
    if (image.isEmpty) {
      AppDialogs.showErrorDialog(
          messageText: 'Failed to select images. Try again');
      return;
    }
    vehicleImages[index] = image;
    update();
  }

  void onDeleteVehicleImageTap(int index) {
    vehicleImages.removeAt(index);
    update();
  }

  bool validateVehicleRegister() {
    if (shouldNotRegisterVehicle) {
      AppDialogs.showErrorDialog(messageText: '');
      return false;
    }
    return shouldRegisterVehicle;
  }

  void onRegisterVehicleTap() async {
    if (validateVehicleRegister() == false) {
      return;
    }
    final request = <String, dynamic>{
      'driver_information': {
        'image': profileDetails.image,
        // 'driving_license': profileDetails.drivingLicense.front,
        'driving_license': profileDetails.drivingLicense,
        'dynamic_fields': profileDetails.dynamicFields
            .map((field) => field.toJson())
            .toList(),
      },
      'vehicle_information': {
        'vehicle_type': selectedVehicleCategory.id,
        'brand': selectedVehicleBrand!.name,
        'model': selectedVehicleModel!.name,
        'year': selectedYear,
        'seat': selectedSeatCount,
        'car_number_plate': numberPlateTextEditingController.text,
        'images': vehicleImages,
        'dynamic_fields':
            dynamicFieldValues.map((e) => e.toRequestJson()).toList(),
      },
    };
    final response = await APIRepo.createVehicle(request);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForUpdatingProfileImageTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    Helper.showSnackBar(response.message);
    Get.back(result: true);
  }

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

  void onUploadAddVehicleImageTap({bool forVehicle = true}) async {
    final pickedImages = await Helper.pickImages(
        // onSuccessUploadSingleImage: forVehicle ? _onSuccessOnUploadAddGalleryImageTap : _onSuccessOnUploadAddDocumentsImageTap,
        imageName: 'Vehicle Image');
    if (forVehicle) {
      _onSuccessOnUploadAddGalleryImageTap(pickedImages, {});
      return;
    }
    _onSuccessOnUploadAddDocumentsImageTap(pickedImages, {});
  }

  void _onSuccessOnUploadAddGalleryImageTap(
      List<Uint8List?> rawImagesData, Map<String, dynamic> additionalData) {
    selectedVehicleImageURLs
        .addAll(rawImagesData.map((e) => e as dynamic).toList());
    update();
    /*  Get.snackbar(
        AppLanguageTranslation.successfullyUploadedTranskey.toCurrentLanguage,
        AppLanguageTranslation
            .successfullyUploadedNewThumbnailImageTranskey.toCurrentLanguage,
        backgroundColor: AppColors.successColor); */
    Helper.showSnackBar('Successfully uploaded image');
  }

  void _onSuccessOnUploadAddDocumentsImageTap(
      List<Uint8List?> rawImagesData, Map<String, dynamic> additionalData) {
    selectedDocumentsImageURLs
        .addAll(rawImagesData.map((e) => e as dynamic).toList());
    update();
    /*  Get.snackbar(
        backgroundColor: AppColors.successColor,
        AppLanguageTranslation.successfullyUploadedTranskey.toCurrentLanguage,
        AppLanguageTranslation
            .successfullyUploadedNewThumbnailImageTranskey.toCurrentLanguage); */
    Helper.showSnackBar('Successfully uploaded image');
  }

  void onUploadDeleteVehicleImageTap(int index) {
    try {
      selectedVehicleImageURLs.removeAt(index);
      update();
      Get.snackbar(
          AppLanguageTranslation.successfullyRemovedTranskey.toCurrentLanguage,
          AppLanguageTranslation
              .successfullyRemovedThumbnailImageTranskey.toCurrentLanguage,
          backgroundColor: AppColors.successColor);
    } catch (e) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .somthingWentWrongWithRemovingExistingImageTranskey
              .toCurrentLanguage);
      return;
    }
  }

  void onTabTap(AddVehicleTabState tabState) {
    switch (tabState) {
      case AddVehicleTabState.vehicle:
        currentVehicleState = AddVehicleTabState.vehicle;
        isFirstTabSelected = true;
        isSecondTabSelected = false;
        isThirdTabSelected = false;
        break;
      case AddVehicleTabState.information:
        currentVehicleState = AddVehicleTabState.information;
        isFirstTabSelected = true;
        isSecondTabSelected = true;
        isThirdTabSelected = false;
        break;
      case AddVehicleTabState.documents:
        currentVehicleState = AddVehicleTabState.documents;
        isFirstTabSelected = true;
        isSecondTabSelected = true;
        isThirdTabSelected = true;
        break;
    }
    update();
  }

  /* <---- Upload delete document image button tap ----> */
  void onUploadDeleteDocumentImageTap(int index) {
    try {
      selectedDocumentsImageURLs.removeAt(index);
      update();
      Get.snackbar(
          AppLanguageTranslation.successfullyRemovedTranskey.toCurrentLanguage,
          AppLanguageTranslation
              .successfullyRemovedThumbnailImageTranskey.toCurrentLanguage,
          backgroundColor: AppColors.successColor);
    } catch (e) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .somthingWentWrongWithRemovingExistingImageTranskey
              .toCurrentLanguage);
      return;
    }
  }

/*   List<Widget> currentOrderDetailsTabContentWidgets(
      AddVehicleTabState tabState) {
    switch (tabState) {
      case AddVehicleTabState.vehicle:
        return vehicleTabContentWidgets();
      case AddVehicleTabState.information:
        return informationTabContentWidgets();
      case AddVehicleTabState.documents:
        return documentsTabContentWidgets();
      default:
        return vehicleTabContentWidgets();
    }
  } */
/* 
  List<Widget> vehicleTabContentWidgets() {
    return [
      Column(
        children: [
          const Text(
            'Select your Vehicle',
            style: AppTextStyles.titleSemiboldTextStyle,
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: AppGaps.screenPaddingValue,
                    mainAxisSpacing: AppGaps.screenPaddingValue,
                    mainAxisExtent: 235,
                    crossAxisCount: 2,
                    childAspectRatio: 1),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  /// Per product data
                  final vehicles =
                      categories[index]; /* <---- Wishlist item widget ----> */
                  return Text(vehicles.name);
                }),
          )
        ],
      )
    ];
  } */

/*   List<Widget> informationTabContentWidgets() {
    return [
      const Column(
        children: [
          Text('Information'),
        ],
      )
    ];
  } */

/*   List<Widget> documentsTabContentWidgets() {
    return [
      const Column(
        children: [
          Text('Documents'),
        ],
      )
    ];
  }
 */
  Widget currentOrderDetailsTabBottomButtonWidget(
      AddVehicleTabState addVehicleStateValue) {
    Map<AddVehicleTabState, Widget> addVehicleStateWidgetMap = {
      AddVehicleTabState.vehicle: isSubmitAddVehicleLoading.value
          ? const EnrollPaymentButtonLoadingWidget()
          : StretchedTextButtonWidget(
              buttonText: AppLanguageTranslation.nextTranskey.toCurrentLanguage,
              onTap: shouldNotGoToInformationStep
                  ? null
                  : () async {
                      // await submitOrderCreate();
                      onTabTap(AddVehicleTabState.information);
                    }),
      AddVehicleTabState.information: isAddVehicleDetailsLoading.value
          ? const EnrollPaymentButtonLoadingWidget()
          : StretchedTextButtonWidget(
              buttonText: AppLanguageTranslation.nextTranskey.toCurrentLanguage,
              onTap: shouldNotGoToDocumentsStep
                  ? null
                  : () async {
                      currentVehicleState = AddVehicleTabState.documents;
                      onTabTap(AddVehicleTabState.documents);
                    }),
      AddVehicleTabState.documents: isAddVehicleDetailsLoading.value
          ? const EnrollPaymentButtonLoadingWidget()
          : carId.isNotEmpty
              ? StretchedTextButtonWidget(
                  buttonText: AppLanguageTranslation
                      .updateInformationTranskey.toCurrentLanguage,
                  onTap: onUpdateButtonTap)
              : StretchedTextButtonWidget(
                  buttonText:
                      AppLanguageTranslation.submitTranskey.toCurrentLanguage,
                  isLoading: isLoading,
                  onTap: shouldNotSubmit ? null : onSubmitButtonTap),
    };
    return addVehicleStateWidgetMap[addVehicleStateValue] ??
        Text(AppLanguageTranslation.emptyTransKey.toCurrentLanguage);
  }

  /* <---- Get vehicle category list from API ----> */
  Future<void> _getVehicleCategoryList() async {
    final response = await APIRepo.getVehicleTypes();
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.errorMessage);
      return;
    }
    vehicleCategories = response.data;
    update();
    // onSuccessGetWalletDetails(response);
  }

  void onSuccessGetWalletDetails(VehicleElementsDataResponse response) {
    categoryShortItems = response.data;
    categories = categoryShortItems.categories;
    log(categories.toString());
    update();
  }

  /* <---- Submit button tap ----> */
  void onSubmitButtonTap() {
    // if (validateAddVehicle()) {
    // addVehicle();
    // }
    onTabTap(AddVehicleTabState.documents);
  }

  /* <---- Update button tap ----> */
  void onUpdateButtonTap() {
    // if (validateAddVehicle()) {
    // addVehicle();
    // }
    onTabTap(AddVehicleTabState.documents);
  }
/* 
  bool validateAddVehicle() {
    if (selectedSubcategory == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .youMustSelectCategoryTransKey.toCurrentLanguage);
      return false;
    }
    return true;
  } */

  /* <---- Add vehicle ----> */
/*   Future<void> addVehicle() async {
    isLoading = true;
    final selectedGalleryImages =
        await Future.wait(selectedVehicleImageURLs.map((e) async {
      if (e is String) {
        return e;
      } else {
        return await Helper.getTempFileFromImageBytes(e);
      }
    }).toList());
    final selectedDocumentsImages =
        await Future.wait(selectedDocumentsImageURLs.map((e) async {
      if (e is String) {
        return e;
      } else {
        return await Helper.getTempFileFromImageBytes(e);
      }
    }).toList());
    final selectedGalleryImageLinks =
        selectedGalleryImages.whereType<String>().toList();
    // selectedGalleryImageLinks.add('value');
    final selectedGalleryImageFiles =
        selectedGalleryImages.whereType<File>().toList();

    final selectedDocumentsImageLinks =
        selectedDocumentsImages.whereType<String>().toList();
    final selectedDocumentsImageFiles =
        selectedDocumentsImages.whereType<File>().toList();

    final FormData requestBody = FormData({
      'name': vehicleNameTextEditingController.text,
      'category': selectedVehicleCategory.subcategories.isNotEmpty
          ? selectedSubcategory?.id
          : selectedVehicleCategory.id,
      'model': vehicleModelTextEditingController.text,
      'year': modelYearTextEditingController.text,
      'max_power': maxPowerTextEditingController.text,
      'max_speed': maxSpeedTextEditingController.text,
      'capacity': seatCapacityTextEditingController.text,
      'color': vehicleColorTextEditingController.text,
      'fuel_type': selectedFuelType,
      'mileage': milageTextEditingController.text,
      'gear_type': selectedGearType,
      'vehicle_model': selectedVehicleModelType,
      'ac': hasAC,
      'vehicle_number': numberPlateTextEditingController.text,
      /* 'images': selectedGalleryImages.mapIndexed((index, imageRawData) {
        if (imageRawData is String) {
          return imageRawData;
        } else {
          return MultipartFile(imageRawData,
              filename: 'image_$index.jpg', contentType: 'image/jpeg');
        }
      }).toList(), */
      'images': selectedGalleryImageFiles
          .mapIndexed((index, imageRawData) => MultipartFile(imageRawData,
              filename: 'image_$index.jpg', contentType: 'image/jpeg'))
          .toList(),
      'documents': selectedDocumentsImageFiles
          .mapIndexed((index, imageRawData) => MultipartFile(imageRawData,
              filename: 'image_$index.jpg', contentType: 'image/jpeg'))
          .toList(), /* selectedDocumentsImages.mapIndexed((index, imageRawData) {
        if (imageRawData is String) {
          return imageRawData;
        } else {
          return MultipartFile(imageRawData,
              filename: 'image_doc_$index.jpg', contentType: 'image/jpeg');
        }
      }).toList(), */
    });
    // MultipartFile(data, filename: filename)
    RawAPIResponse? response;
    if (carId.isEmpty) {
      response = await APIRepo.addVehicle(requestBody);
    } else {
      requestBody.fields.add(MapEntry('_id', carId));
      /* for (var element in selectedGalleryImageLinks) {
        requestBody.fields.addAll([MapEntry('prev_images', element)]);
      } */
      requestBody.fields.addAll(
          selectedGalleryImageLinks.map((e) => MapEntry('prev_images', e)));
      /* for (var element in selectedDocumentsImageLinks) {
        requestBody.fields.addAll([MapEntry('prev_documents', element)]);
      } */
      requestBody.fields.addAll(selectedDocumentsImageLinks
          .map((e) => MapEntry('prev_documents', e)));

      // requestBody.fields
      //     .add(MapEntry('prev_images', selectedGalleryImageLinks));
      response = await APIRepo.updateVehicleDetails(requestBody);
    }
    try {
      await Future.wait(selectedGalleryImages.map((e) async {
        if (e is File) {
          return await e.delete();
        }
      }).toList());
    } catch (e) {}
    try {
      await Future.wait(selectedDocumentsImages.map((e) async {
        if (e is File) {
          return await e.delete();
        }
      }).toList());
    } catch (e) {}
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessAddingVehicle(response);
  } */

  /* <---- Update vehicle ----> */
/*   Future<void> updateVehicle() async {
    final selectedGalleryImages =
        await Future.wait(selectedVehicleImageURLs.map((e) async {
      if (e is String) {
        return e;
      } else {
        return await Helper.getTempFileFromImageBytes(e);
      }
    }).toList());
    final selectedDocumentsImages =
        await Future.wait(selectedDocumentsImageURLs.map((e) async {
      if (e is String) {
        return e;
      } else {
        return await Helper.getTempFileFromImageBytes(e);
      }
    }).toList());
    final selectedGalleryImageLinks =
        selectedGalleryImages.whereType<String>().toList();
    // selectedGalleryImageLinks.add('value');
    final selectedGalleryImageFiles =
        selectedGalleryImages.whereType<File>().toList();

    final selectedDocumentsImageLinks =
        selectedDocumentsImages.whereType<String>().toList();
    final selectedDocumentsImageFiles =
        selectedDocumentsImages.whereType<File>().toList();

    final FormData requestBody = FormData({
      'name': vehicleNameTextEditingController.text,
      'category': selectedVehicleCategory.subcategories.isNotEmpty
          ? selectedSubcategory?.id
          : selectedVehicleCategory.id,
      'model': modelYearTextEditingController.text,
      'year': modelYearTextEditingController.text,
      'max_power': maxPowerTextEditingController.text,
      'max_speed': maxSpeedTextEditingController.text,
      'capacity': seatCapacityTextEditingController.text,
      'color': selectedColor,
      'fuel_type': selectedFuelType,
      'mileage': milageTextEditingController.text,
      'gear_type': selectedGearType,
      'ac': hasAC,
      'vehicle_number': numberPlateTextEditingController.text,
      /* 'images': selectedGalleryImages.mapIndexed((index, imageRawData) {
        if (imageRawData is String) {
          return imageRawData;
        } else {
          return MultipartFile(imageRawData,
              filename: 'image_$index.jpg', contentType: 'image/jpeg');
        }
      }).toList(), */
      'images': selectedGalleryImageFiles
          .mapIndexed((index, imageRawData) => MultipartFile(imageRawData,
              filename: 'image_$index.jpg', contentType: 'image/jpeg'))
          .toList(),
      'documents': selectedDocumentsImageFiles
          .mapIndexed((index, imageRawData) => MultipartFile(imageRawData,
              filename: 'image_$index.jpg', contentType: 'image/jpeg'))
          .toList(), /* selectedDocumentsImages.mapIndexed((index, imageRawData) {
        if (imageRawData is String) {
          return imageRawData;
        } else {
          return MultipartFile(imageRawData,
              filename: 'image_doc_$index.jpg', contentType: 'image/jpeg');
        }
      }).toList(), */
    });
    // MultipartFile(data, filename: filename)
    RawAPIResponse? response;
    if (carId.isEmpty) {
      response = await APIRepo.addVehicle(requestBody);
    } else {
      requestBody.fields.add(MapEntry('_id', carId));
      /* for (var element in selectedGalleryImageLinks) {
        requestBody.fields.addAll([MapEntry('prev_images', element)]);
      } */
      requestBody.fields.addAll(
          selectedGalleryImageLinks.map((e) => MapEntry('prev_images', e)));
      /* for (var element in selectedDocumentsImageLinks) {
        requestBody.fields.addAll([MapEntry('prev_documents', element)]);
      } */
      requestBody.fields.addAll(selectedDocumentsImageLinks
          .map((e) => MapEntry('prev_documents', e)));

      // requestBody.fields
      //     .add(MapEntry('prev_images', selectedGalleryImageLinks));
      response = await APIRepo.updateVehicleDetails(requestBody);
    }
    try {
      await Future.wait(selectedGalleryImages.map((e) async {
        if (e is File) {
          return await e.delete();
        }
      }).toList());
    } catch (e) {}
    try {
      await Future.wait(selectedDocumentsImages.map((e) async {
        if (e is File) {
          return await e.delete();
        }
      }).toList());
    } catch (e) {}
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessAddingVehicle(response);
  } */

/*   void onSuccessAddingVehicle(RawAPIResponse response) async {
    final userDetails = Helper.getUser() as UserDetailsData;
    if (userDetails.isSubscriptionNotBought) {
      await AppDialogs.updateSuccessDialog(
          messageText: 'Please buy subscription',
          onYesTap: () async {
            await Get.toNamed(AppPageNames.tripPermitScreen);
            Helper.getBackToHomePage();
          });
      return;
    }
    await AppDialogs.updateSuccessDialog(
        messageText: response.msg,
        onYesTap: () async {
          // Get.offAllNamed(AppPageNames.zoomDrawerScreen);
          Helper.getBackToHomePage();
        });
    // Get.back();
  } */

  /* <---- Get car details from API ----> */
/*   Future<void> getCarDetails() async {
    VehicleDetailsResponse? response =
        await APIRepo.getVehicleDetails(productId: carId);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetVehicleDetailsResponse(response);
  }

  void _onSuccessGetVehicleDetailsResponse(VehicleDetailsResponse response) {
    VehicleDetailsItem vehicle = response.data;
    // selectedCategory = vehicle.category;
    selectCategory(vehicle.category.id);
    vehicle.category.id;
    vehicleNameTextEditingController.text = vehicle.name;
    vehicleModelTextEditingController.text = vehicle.model;
    modelYearTextEditingController.text = vehicle.year;
    // selectedDocumentsImageURLs.clear();
    selectedVehicleImageURLs.addAll(vehicle.images.map((e) => e).toList());

    // selectedVehicleImageURLs = vehicle.images;
    maxPowerTextEditingController.text = vehicle.maxPower;
    maxSpeedTextEditingController.text = vehicle.maxSpeed;
    seatCapacityTextEditingController.text = vehicle.capacity.toString();
    selectedColor = vehicle.color;
    vehicleColorTextEditingController.text = vehicle.color;
    selectedFuelType = vehicle.fuelType;
    milageTextEditingController.text = vehicle.mileage.toString();
    selectedGearType = vehicle.gearType;
    hasAC = vehicle.ac;
    numberPlateTextEditingController.text = vehicle.vehicleNumber;
    selectedDocumentsImageURLs.addAll(vehicle.documents);
    final foundSelectedCarCategory = categories
        .firstWhereOrNull((element) => element.id == vehicle.category.id);
    if (foundSelectedCarCategory != null) {
      selectedCategory = foundSelectedCarCategory;
    }
    // vehicleDetailsItem = response.data;
    // images = response.data.images;
    // documents = response.data.documents;
    log('Fetch success!');
    update();
  } */

/*   void selectGearType(String gearType) {
    final foundGearType =
        gearTypes.firstWhereOrNull((element) => element == gearType);
    if (foundGearType != null) {
      selectedGearType = foundGearType;
      update();
    }
  }

  void selectCategory(String categoryID) {
    final foundCategory =
        categories.firstWhereOrNull((element) => element.id == categoryID);
    if (foundCategory != null) {
      selectedVehicleCategory = foundCategory;
      update();
    }
  } */

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
    dynamicFieldValues = dynamicFields.vehicleFields
        .map((e) => DynamicFieldRequest(
            driverFieldInfo: DriverDynamicField.empty(),
            vehicleFieldInfo: e,
            keyValue: e.fieldName,
            type: e.type,
            values: []))
        .toList();
    update();
  }

  Future<void> _getVehicleBrands(
      {required String selectedVehicleTypeID}) async {
    isBrandLoading = true;
    final response =
        await APIRepo.getVehicleBrands(vehicleTypeID: selectedVehicleTypeID);
    isBrandLoading = false;
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);
      return;
    }
    vehicleBrands = response.data;
    update();
  }

  Future<void> _getVehicleModels(
      {required String selectedVehicleTypeID,
      required String selectedBrandID}) async {
    isModelLoading = true;
    final response = await APIRepo.getVehicleModels(
        vehicleTypeID: selectedVehicleTypeID, brandID: selectedBrandID);
    isModelLoading = false;
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);
      return;
    }
    vehicleModels = response.data;
    update();
  }

  /*<----------- Fetch screen navigation argument----------->*/
  void getScreenParameters() {
    dynamic param = Get.arguments;
    if (param is bool) {
      isVehicleRegisterForSignup = param;
    }
    update();
  }

  currentOrderDetailsTabContentWidgets(value) {}

  /* <---- Initial state ----> */
  @override
  void onInit() async {
    getScreenParameters();
    profileUpdateSubscriber ??= profileService.profileDetailsRX.listen((data) {
      update();
    });
    _getDynamicFields();
    _getVehicleCategoryList();
/*     await getVehicleCategoryList();
    if (carId.isNotEmpty) {
      getCarDetails();
    } */

    vehicleNameTextEditingController.addListener(update);
    vehicleModelTextEditingController.addListener(update);
    modelYearTextEditingController.addListener(update);
    maxPowerTextEditingController.addListener(update);
    maxSpeedTextEditingController.addListener(update);
    seatCapacityTextEditingController.addListener(update);
    milageTextEditingController.addListener(update);
    numberPlateTextEditingController.addListener(update);
    vehicleColorTextEditingController.addListener(update);
    super.onInit();
  }

  @override
  void onClose() {
    vehicleNameTextEditingController.dispose();
    vehicleModelTextEditingController.dispose();
    modelYearTextEditingController.dispose();
    maxPowerTextEditingController.dispose();
    maxSpeedTextEditingController.dispose();
    seatCapacityTextEditingController.dispose();
    milageTextEditingController.dispose();
    numberPlateTextEditingController.dispose();
    vehicleColorTextEditingController.dispose();
    yearController.dispose();
    profileUpdateSubscriber?.cancel();
    profileUpdateSubscriber = null;
    super.onClose();
  }
}
