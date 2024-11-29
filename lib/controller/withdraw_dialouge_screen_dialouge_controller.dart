import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/get_withdraw_saved_methods.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawDialogWidgetScreenController extends GetxController {
  TextEditingController amountController = TextEditingController();
  RxBool isElementsLoading = false.obs;
  List<WithdrawMethodsItem> withdrawMethod = [];
  List<WithdrawMethodsItem> selectedWithdrawMethod = [];
  WithdrawMethodsItem? selectedSavedWithdrawMethod;
  WithdrawMethodsItem? lastSelectedMethod;
  final GlobalKey<FormState> withdrawKey = GlobalKey<FormState>();
  // void onSelectMethodChange(WithdrawMethodsItem? coupon) {
  //   if (coupon == null) {
  //     return;
  //   }
  //   final WithdrawMethodsItem? foundExistingCoupon = selectedWithdrawMethod
  //       .firstWhereOrNull((element) => element.id == coupon.id);
  //   if (foundExistingCoupon != null) {
  //     // selectedCoupons.remove(foundExistingCoupon);
  //   } else {
  //     selectedWithdrawMethod.add(coupon);
  //   }
  //   update();
  // }

  void onMethodChanged(WithdrawMethodsItem? value) {
    selectedSavedWithdrawMethod = value!;
    update();
  }

  void onAddNewMethodButtonTap() async {
    await Get.toNamed(AppPageNames.paymentMethodScreen);
  }

  void onCouponDeleteChange(int index, WithdrawMethodsItem? selectedItem) {
    selectedWithdrawMethod.remove(selectedItem);

    update();
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
    log((response.toJson().toString()));
    _onSuccessGetCoupons(response);
  }

  void _onSuccessGetCoupons(GetWithdrawSavedMethodsResponse response) {
    withdrawMethod = response.data;
    update();
  }

  void onContinueButtonTap() {
    if (withdrawKey.currentState?.validate() ?? false) {
      requestWithdraw();
    }
  }

  Future<void> requestWithdraw() async {
    final Map<String, dynamic> requestBody = {
      'amount': double.tryParse(amountController.text) ?? 0,
      'withdraw_method': selectedSavedWithdrawMethod?.id,
    };
    RawAPIResponse? response = await APIRepo.withdrawRequest(requestBody);
    if (response == null) {
      // APIHelper.onError(AppLanguageTranslation
      //     .noResponseCallingPendingTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessCancellingRequest(response);
  }

  onSuccessCancellingRequest(RawAPIResponse response) {
    Get.back();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getWithdrawMethod();
    super.onInit();
  }
}
