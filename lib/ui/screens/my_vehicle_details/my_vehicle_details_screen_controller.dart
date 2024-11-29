import 'dart:async';

import 'package:car2godriver/models/api_responses/driver_vehicle_dynamic_fields.dart';
import 'package:car2godriver/models/api_responses/my_vehicle_details.dart';
import 'package:car2godriver/models/local/dynamic_field_request.dart';
import 'package:car2godriver/ui/bottomsheets/confirm_bottom_sheet.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';

class MyVehicleDetailsScreenController extends GetxController {
  String myVehicleID = '';
  MyVehicleDetails myVehicleDetails = MyVehicleDetails.empty();
  DriverVehicleDynamicFields dynamicFields = DriverVehicleDynamicFields();
  List<DynamicFieldRequest> dynamicFieldValues = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  void onDeleteButtonTap() async {
    isLoading = true;
    final response = await APIRepo.deleteVehicle({'_id': myVehicleDetails.id});
    isLoading = false;
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);
      return;
    }
    Helper.showSnackBar('Successfully deleted vehicle');
    Get.back(result: true);
  }

  void onEditVehicleButtonTap() async {
    final confirmResult = await Get.bottomSheet(
      isScrollControlled: true,
      const ConfirmBottomSheet(
        title:
            'If you edit your vehicle details, it will be temporarily deactivated while we verify the changes.',
        yesButtonText: 'Yes, edit',
        noButtonText: 'Not now',
      ),
    );
    if (confirmResult != true) {
      return;
    }
    final result = await Get.toNamed(AppPageNames.myVehicleEdit,
        arguments: myVehicleDetails.id);
    if (result is bool && result) {
      getMyVehicleDetails();
    }
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is String) {
      myVehicleID = argument;
    }
  }

  List<DynamicFieldRequest> _setDynamicFieldValuesFromProfile(
      {required List<DynamicFieldRequest> dynamicFieldValues,
      required List<MyVehicleDynamicField> profileDynamicFieldValues}) {
    dynamicFieldValues.forEachIndexed((index, dynamicFieldValue) {
      final found = profileDynamicFieldValues.firstWhereOrNull(
          (element) => element.key == dynamicFieldValue.keyValue);
      if (found != null) {
        dynamicFieldValue.values = found.value;
      }
    });
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

  Future<void> getMyVehicleDetails() async {
    isLoading = true;
    final response =
        await APIRepo.getMyVehicleDetails(queries: {'_id': myVehicleID});
    isLoading = false;
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);
      return;
    }
    myVehicleDetails = response.data;
    update();
  }

  @override
  void onInit() async {
    _getScreenParameter();
    await _getDynamicFields();
    await getMyVehicleDetails();
    dynamicFieldValues = _setDynamicFieldValuesFromProfile(
        dynamicFieldValues: dynamicFieldValues,
        profileDynamicFieldValues: myVehicleDetails.dynamicFields);
    super.onInit();
  }
}
