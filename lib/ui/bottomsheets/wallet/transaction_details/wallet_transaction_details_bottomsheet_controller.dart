import 'package:car2godriver/models/api_responses/wallet_details.dart';
import 'package:get/get.dart';

class WalletTransactionBottomSheetController extends GetxController {
  WalletTransaction transactionDetails = WalletTransaction.empty();
  void _getBottomSheetParameter() {
    final argument = Get.arguments;
    if (argument is WalletTransaction) {
      transactionDetails = argument;
    }
  }

  @override
  void onInit() {
    _getBottomSheetParameter();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
