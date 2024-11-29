import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/user_details_response.dart';
import 'package:car2godriver/models/api_responses/vehicle_details_response.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyVehicleInformationScreenController extends GetxController {
  // Rx<VehicleDetailsInfoTypeStatus> vehicleInfoStatusTab =
  //     VehicleDetailsInfoTypeStatus.specifications.obs;
  // VehicleDetailsInformationScreenController vehicleDetailsScreenController =
  //     VehicleDetailsInformationScreenController();

  /*<----------- Initialize variables ----------->*/
  UserDetailsData userDetailsData = UserDetailsData.empty();
  String vehicleId = '';
  VehicleDetailsItem vehicleDetailsItem = VehicleDetailsItem.empty();
  final PageController imageController = PageController(keepPage: false);

  List<String> images = [];
  List<String> documents = [];

  /* <---- Edit button tap ----> */
  void onEditButtonTap() async {
    await Get.offNamed(AppPageNames.addVehicleScreen,
        arguments: vehicleDetailsItem.id);
  }

  /*<----------- Get user details from API----------->*/
  Future<void> getUserDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInUserDetails(response);
  }

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) {
    userDetailsData = response.data;
    vehicleId = userDetailsData.vehicle.id;
    update();
    getVehicleDetails(vehicleId);
  }

  /*<----------- Get vehicle details from API----------->*/
  Future<void> getVehicleDetails(String vehicleId) async {
    VehicleDetailsResponse? response =
        await APIRepo.getVehicleDetails(productId: vehicleId);
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
    vehicleDetailsItem = response.data;
    images = response.data.images;
    documents = response.data.documents;
    update();
  }

  /* <---- Remove vahicle button tap ----> */
  void onRemoveVehicleTap() {
    removeVehicle();
  }

  /*<----------- Remove vehicle from API----------->*/
  Future<void> removeVehicle() async {
    RawAPIResponse? response =
        await APIRepo.removeVehicle(vehicleId: vehicleId);
    if (response == null) {
      Helper.showSnackBar(
          AppLanguageTranslation.noResponseRemoveTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRemovingVehicle(response);
  }

  onSuccessRemovingVehicle(RawAPIResponse response) {
    Get.back();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  /* <---- Initial state ----> */
  @override
  void onInit() {
    getUserDetails();

    super.onInit();
  }
}
