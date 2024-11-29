import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:get/get.dart';

class VehicleYearPickerDialogController extends GetxController {
  final firstDate = DateTime(DateTime.now().year -
      AppConstants.minimumVehicleModelYearDecrementCounter);
  final lastDate = DateTime.now();
  DateTime? selectedYear;

  void onDateChanged(DateTime value) {
    Get.back(result: value);
  }

  void _getDialogParameter() {
    final argument = Get.arguments;
    if (argument is int) {
      selectedYear = DateTime(argument);
    }
  }

  @override
  void onInit() {
    _getDialogParameter();
    super.onInit();
  }
}
