import 'package:car2godriver/models/api_responses/vehicle_details_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleDetailsInfoScreenController extends GetxController {
  final PageController imageController = PageController(keepPage: false);

  /*<----------- Initialize variables ----------->*/
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
    // TODO: implement onInit
    _getScreenParameters();

    super.onInit();
  }
}
