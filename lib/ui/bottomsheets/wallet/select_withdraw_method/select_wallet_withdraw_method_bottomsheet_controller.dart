import 'package:car2godriver/models/api_responses/site_settings.dart';
import 'package:get/get.dart';

class SelectWalletWithdrawMethodBottomSheetController extends GetxController {
  SettingsWithdrawMethodsInfo selectedWithdrawMethod =
      SettingsWithdrawMethodsInfo();

  void onWithdrawMethodItemTap(SettingsWithdrawMethodsInfo withdrawMethod) {
    selectedWithdrawMethod = withdrawMethod;
    update();
  }

  bool get shouldDisableContinueButton => selectedWithdrawMethod.id.isEmpty;
  void onContinueButtonTap() {
    Get.back(result: selectedWithdrawMethod);
  }
}
