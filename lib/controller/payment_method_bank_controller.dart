import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/get_withdraw_saved_methods_details.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodBankScreenController extends GetxController {
  String id = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchCodeController = TextEditingController();
  WithdrawMethodsDetailsItem? withdrawMethod;

  void postUpdateData() {
    if (id.isEmpty) {
      addInfo();
    } else {
      updateInfo();
    }
  }

  Future<void> addInfo() async {
    final Map<String, dynamic> requestBody = {
      'type': 'bank',
      'details': {
        'bank_account_name': nameController.text,
        'bank_name': bankNameController.text,
        'branch_code': branchCodeController.text,
        'account_number': accountNumberController.text,
      }
    };
    RawAPIResponse? response = await APIRepo.addMethodInfo(requestBody);
    if (response == null) {
      APIHelper.onError('Data Do Not save Properly');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    Get.back(result: true);
  }

  Future<void> updateInfo() async {
    final Map<String, dynamic> requestBody = {
      '_id': id,
      'type': withdrawMethod?.type ?? 'bank',
      'details': {
        'bank_account_name': nameController.text,
        'bank_name': bankNameController.text,
        'branch_code': branchCodeController.text,
        'account_number': accountNumberController.text,
      }
    };
    RawAPIResponse? response = await APIRepo.updateInfo(requestBody);
    if (response == null) {
      APIHelper.onError('Data Do Not save Properly');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    Get.back(result: true);
  }

  Future<void> getWithdrawMethodDetails(String id) async {
    final GetWithdrawSavedMethodsDetailsResponse? response =
        await APIRepo.getWithdrawMethodDetails(id);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    _onSuccessGetMethod(response);
  }

  void _onSuccessGetMethod(GetWithdrawSavedMethodsDetailsResponse response) {
    withdrawMethod = response.data;
    nameController.text = withdrawMethod?.details.bankAccountName ?? '';
    accountNumberController.text = withdrawMethod?.details.accountNumber ?? '';
    bankNameController.text = withdrawMethod?.details.bankName ?? '';
    branchCodeController.text = withdrawMethod?.details.branchCode ?? '';
    update();
  }

  void _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      id = params;
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _getScreenParameters();
    if (id.isNotEmpty) {
      getWithdrawMethodDetails(id);
    }
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    nameController.dispose();
    accountNumberController.dispose();
    bankNameController.dispose();
    branchCodeController.dispose();
    super.onClose();
  }
}
