import 'package:car2godriver/controller/payment_method_paypal_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class PaymentMethodPaypalScreen extends StatelessWidget {
  const PaymentMethodPaypalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentMethodPaypalScreenController>(
      global: false,
      init: PaymentMethodPaypalScreenController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: CoreWidgets.appBarWidget(
            screenContext: context, titleWidget: const Text('Paypal')),
        body: ScaffoldBodyWidget(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppGaps.hGap20,
                CustomTextFormField(
                  labelTextColor: AppColors.primaryTextColor,
                  controller: controller.payPalNameController,
                  labelText: "Account Holder Name",
                  hintText: "Type account holder name",
                ),
                AppGaps.hGap20,
                CustomTextFormField(
                  labelTextColor: AppColors.primaryTextColor,
                  controller: controller.emailAddressController,
                  labelText: "Email Address",
                  hintText: "Type email address",
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ScaffoldBodyWidget(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomStretchedButtonWidget(
              onTap: controller.postUpdateData,
              child: const Text('Save'),
            ),
            AppGaps.hGap20,
          ],
        )),
      ),
    );
  }
}
