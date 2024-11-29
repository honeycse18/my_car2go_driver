import 'dart:developer';
import 'package:car2godriver/controller/menu_screen_controller/wallet_screen_controller.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/api_response.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/driver_vehicle_dynamic_fields.dart';
import 'package:car2godriver/models/api_responses/site_settings.dart';
import 'package:car2godriver/models/api_responses/top_up_response.dart';
import 'package:car2godriver/models/api_responses/wallet_withdraw_response.dart';
import 'package:car2godriver/models/fakeModel/fake_data.dart';
import 'package:car2godriver/models/local/dynamic_field_request.dart';
import 'package:car2godriver/models/payment_option_model.dart';
import 'package:car2godriver/ui/screens/bottomsheet/profile_dynamic_field_bottomsheet.dart';
import 'package:car2godriver/ui/bottomsheets/dynamic_field/wallet_withdraw/wallet_withdraw_dynamic_field_bottomsheet.dart';
import 'package:car2godriver/ui/bottomsheets/dynamic_field/wallet_withdraw/wallet_withdraw_dynamic_field_bottomsheet_controller.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class WalletWithdrawScreenController extends GetxController {
  final walletScreenController = Get.find<WalletScreenController>();
  SettingsWithdrawMethodsInfo selectedWithdrawMethod =
      SettingsWithdrawMethodsInfo();

  String? selectedChannel;
  List<DynamicFieldRequest> dynamicFieldValues = [];
  final GlobalKey<FormState> walletWithdrawFormKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  TextEditingController amountController = TextEditingController();
  // SettingsPaymentGateway selectedPaymentOption = SettingsPaymentGateway();
  // int selectedPaymentMethodIndex = 0;
  // String id = '';
  // SelectPaymentOptionModel selectedPaymentOption = FakeData.topupOptionList[0];

  // int amount = 1;
  // DateTime selectedStartDate = DateTime.now();
  // TimeOfDay selectedStartTime = TimeOfDay.now();
  // final PageController imageController = PageController(keepPage: false);
  bool get shouldDisableWithdrawButton {
    if (double.tryParse(amountController.text) == null) {
      return true;
    }
    if (selectedWithdrawMethod.channels.isNotEmpty && selectedChannel == null) {
      return true;
    }
    final isAnyRequiredDynamicFieldEmpty = dynamicFieldValues
        .where((element) => element.isRequired)
        .any((dynamicField) =>
            dynamicField.values.isEmpty ||
            (dynamicField.values.firstOrNull ?? '').isEmpty);
    if (isAnyRequiredDynamicFieldEmpty) {
      return true;
    }
    return false;
  }

/*<-----------Topup wallet from API ----------->*/
  String? amountValidator(String? text) {
    if (text == null) {
      return 'Enter an amount';
    }
    if (text.isEmpty) {
      return 'Enter an amount';
    }
    if (double.tryParse(text) == null) {
      return 'Enter a valid amount';
    }
    final double amount = double.tryParse(text)!;
    if (amount < 0) {
      return 'Amount can not be negative';
    }
    if (amount > walletScreenController.walletDetails.currentBalance.total) {
      return 'Withdraw amount exceeds current balance';
    }
    return null;
  }

  void onChannelSelected(String? channel) {
    selectedChannel = channel;
    update();
  }

  Future<void> onDynamicFieldTap(DynamicFieldRequest field, int index) async {
    final result = await Get.bottomSheet(
        isScrollControlled: true,
        const WalletWithdrawDynamicFieldBottomSheet(),
        settings: RouteSettings(arguments: field));
    if (result is List<String>) {
      dynamicFieldValues[index].values = result;
      update();
    }
  }

  void onAmountTap(double amount) {
    amountController.text = amount.toInt().toString();
  }

  bool _validateWithdraw() {
    if (double.tryParse(amountController.text) == null) {
      return false;
    }

    if (selectedWithdrawMethod.channels.isNotEmpty) {
      if (selectedChannel == null) {
        return false;
      }
    }
    final isAnyRequiredDynamicFieldEmpty = dynamicFieldValues
        .where((element) => element.isRequired)
        .any((dynamicField) =>
            dynamicField.values.isEmpty ||
            (dynamicField.values.firstOrNull ?? '').isEmpty);
    if (isAnyRequiredDynamicFieldEmpty) {
      return false;
    }
    return true;
  }

  Future<void> makeWithdraw() async {
    // return;
    if ((walletWithdrawFormKey.currentState?.validate() ?? false) == false) {
      return;
    }
    if (_validateWithdraw() == false) {
      return;
    }
    final filteredDynamicFields = dynamicFieldValues
        .where(
          (element) =>
              element.values.isNotEmpty &&
              (element.values.firstOrNull != null &&
                  element.values.firstOrNull!.isNotEmpty),
        )
        .toList();
    final Map<String, dynamic> requestBody = {
      'amount': double.tryParse(amountController.text) ?? 0,
      'withdraw_method': selectedWithdrawMethod.name,
      'withdrawal_details': filteredDynamicFields
          .map((dynamicField) => {
                'key': dynamicField.keyValue,
                'value': dynamicField.values.firstOrNull,
                'type': dynamicField.type
              })
          .toList()
    };
    if (selectedWithdrawMethod.channels.isNotEmpty) {
      requestBody['bank_name'] = selectedChannel;
    }
    isLoading = true;
    final response = await APIRepo.walletWithdraw(requestBody: requestBody);
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.errorMessage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.errorMessage);
      return;
    }
    _onSuccessStartRentStatus(response);
  }

  void _onSuccessStartRentStatus(
      APIResponse<WalletWithdrawResponse> response) async {
    walletScreenController.getWalletDetails();
    await AppDialogs.showSuccessDialog(messageText: response.message);
    Get.back();
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is SettingsWithdrawMethodsInfo) {
      selectedWithdrawMethod = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    dynamicFieldValues = selectedWithdrawMethod.requiredFields
        .map((field) => DynamicFieldRequest(
            values: [],
            keyValue: field.name,
            type: field.type,
            isRequired: field.isRequired,
            driverFieldInfo: DriverDynamicField.empty(),
            vehicleFieldInfo: VehicleDynamicField.empty()))
        .toList();
    amountController.addListener(update);
    super.onInit();
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}
