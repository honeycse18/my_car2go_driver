import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/get_withdraw_saved_methods.dart';
import 'package:car2godriver/models/enums.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodScreenController extends GetxController {
  Rx<PaymentHistoryStatus> paymentTypeTab = PaymentHistoryStatus.card.obs;
  String date = '';

  TextEditingController cardNameTextEditingController = TextEditingController();
  TextEditingController cardPostalCodeTextEditingController =
      TextEditingController();
  TextEditingController cardNumberTextEditingController =
      TextEditingController();
  TextEditingController cardExpireDateTextEditingController =
      TextEditingController();
  TextEditingController cardCvvNumberTextEditingController =
      TextEditingController();
  TextEditingController postalCodeTextEditingController =
      TextEditingController();
  TextEditingController accountHolderNameTextEditingController =
      TextEditingController();
  TextEditingController payAccountHolderNameTextEditingController =
      TextEditingController();
  TextEditingController accountNumberTextEditingController =
      TextEditingController();
  TextEditingController bankNameTextEditingController = TextEditingController();
  TextEditingController branchCodeTextEditingController =
      TextEditingController();
  TextEditingController emailAddressTextEditingController =
      TextEditingController();
  List<WithdrawMethodsItem> withdrawMethods = [];
  WithdrawMethodsItem selectedWithdrawMethod = WithdrawMethodsItem.empty();

  void onPaymentTabTap(PaymentHistoryStatus value) {
    paymentTypeTab.value = value;
    update();
  }

  Future<void> deleteCard(String id) async {
    RawAPIResponse? response = await APIRepo.deleteCard(id);
    if (response == null) {
      APIHelper.onError('Data Do Not save Properly');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    getWithdrawMethod();
  }

  Future<void> getWithdrawMethod() async {
    final GetWithdrawSavedMethodsResponse? response =
        await APIRepo.getWithdrawMethod();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    _onSuccessGetMethods(response);
  }

  void _onSuccessGetMethods(GetWithdrawSavedMethodsResponse response) {
    withdrawMethods = response.data;

    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getWithdrawMethod();
    super.onInit();
  }
}
