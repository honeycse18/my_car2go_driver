import 'dart:async';

import 'package:car2godriver/models/api_responses/my_vehicles_data.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:get/get.dart';

class MyVehiclesScreenController extends GetxController {
  String? selectedStatus;
  String? selectedVehicleType;
  MyVehiclesData myVehiclesData = MyVehiclesData();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  void onAddNewButtonTap() async {
    final result = await Get.toNamed(AppPageNames.addVehicleScreen);
    if (result is bool && result) {
      getMyVehicles(status: selectedStatus, vehicleType: selectedVehicleType);
    }
  }

  void onVehicleTap(MyVehicle vehicle) {
    Get.toNamed(AppPageNames.myVehicleDetails, arguments: vehicle.id);
  }

  void onVehicleActiveIconButtonTap(MyVehicle vehicle) async {
    isLoading = true;
    final response = await APIRepo.activeToggleVehicle(
        {'vehicle_id': vehicle.id, 'isActive': !vehicle.isActive});
    isLoading = false;
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);
      return;
    }
    AppDialogs.showSuccessDialog(messageText: 'Successfully mark active');
    update();
    getMyVehicles();
  }

  Future<void> getMyVehicles({String? status, String? vehicleType}) async {
    final vehicleStatus = status ?? selectedStatus;
    final vehicleVehicleType = vehicleType ?? selectedVehicleType;
    final queries = <String, String>{};
    if (vehicleStatus != null) {
      queries['status'] = vehicleStatus;
    }
    if (vehicleVehicleType != null) {
      queries['vehicle_type'] = vehicleVehicleType;
    }
    isLoading = true;
    final response = await APIRepo.getMyVehicles(queries);
    isLoading = false;
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);
      return;
    }
    myVehiclesData = response.data;
    update();
  }

  /* <---- Initial state ----> */
  @override
  void onInit() async {
    getMyVehicles();
  }
}
