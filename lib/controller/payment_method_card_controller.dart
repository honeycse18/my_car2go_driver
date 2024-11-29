import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/get_withdraw_saved_methods_details.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodCardScreenController extends GetxController {
  String id = '';
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardExpireDateController = TextEditingController();
  TextEditingController cardCvvNumberController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  WithdrawMethodsDetailsItem? withdrawMethod;
  var selectedExpireDate = DateTime.now().obs;

  void updateSelectedExpireDate(DateTime newDate) {
    selectedExpireDate.value = newDate;
  }

  void postUpdateData() {
    if (id.isEmpty) {
      addInfo();
    } else {
      updateInfo();
    }
  }

  Future<void> addInfo() async {
    final Map<String, dynamic> requestBody = {
      'type': 'card',
      'details': {
        'card_name': cardNameController.text,
        'card_number': cardNumberController.text,
        'card_expire_date':
            Helper.yyyyMMddFormattedDateTime(selectedExpireDate.value),
        'cvv_number': cardCvvNumberController.text,
        'postal_code': postalCodeController.text
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
      'type': withdrawMethod?.type ?? 'card',
      'details': {
        'card_name': cardNameController.text,
        'card_number': cardNumberController.text,
        'card_expire_date':
            Helper.yyyyMMddFormattedDateTime(selectedExpireDate.value),
        'cvv_number': cardCvvNumberController.text,
        'postal_code': postalCodeController.text
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
    cardNumberController.text = withdrawMethod!.details.cardNumber;
    cardNameController.text = withdrawMethod!.details.cardName;
    selectedExpireDate.value =
        DateTime.parse(withdrawMethod!.details.cardExpiry);
    cardCvvNumberController.text = withdrawMethod!.details.cardCvvNumber;
    postalCodeController.text = withdrawMethod!.details.postalCode;
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
    cardNumberController.dispose();
    cardNameController.dispose();
    cardExpireDateController.dispose();
    cardCvvNumberController.dispose();
    postalCodeController.dispose();
    super.onClose();
  }
}
