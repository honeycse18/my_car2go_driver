import 'package:car2godriver/models/api_responses/vehicle_details_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsVehicleScreenController extends GetxController {
  /*  TextEditingController emailTextEditingController = TextEditingController();
  String vehicleId = '';
  VehicleDetailsItem vehicleDetailsItem = VehicleDetailsItem.empty();
  final PageController imageController = PageController(keepPage: false);

  //var isLoading = false.obs;
  //List<String> galleryImageURLs = [];
  // List<dynamic> selectedVehicleImageURLs = [];
  // List<dynamic> selectedDocumentsImageURLs = [];
  String selectedColor = 'Red';
  String selectedFuelType = 'Diesel';
  String selectedGearType = 'automatic';
  String selectedVehicleModelType = 'Chevy II Nova 396';
  // bool hasAC = false;
  // bool isFirstTabSelected = false;
  // bool isSecondTabSelected = false;

  List<String> images = [];
  List<String> documents = [];

  Future<void> getVehicleDetails(String productId) async {
    VehicleDetailsResponse? response =
        await APIRepo.getVehicleDetails(productId: productId);
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

  void onRemoveVehicleTap() {
    removeVehicle();
  }

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

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      vehicleId = argument;
    }
  } */
  /*<----------- Initialize variables ----------->*/
  final PageController imageController = PageController(keepPage: false);

  VehicleDetailsItem vehicleDetailsItem = VehicleDetailsItem.empty();
  List<String> documents = [];

  /*<----------- Fetch screen navigation argument----------->*/
  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is VehicleDetailsItem) {
      vehicleDetailsItem = params;
      documents = vehicleDetailsItem.documents;
    }
    update();
  }

  /* <---- Initial state ----> */
  @override
  void onInit() {
    _getScreenParameters();
    // getVehicleDetails(vehicleId);

    super.onInit();
  }
}
