import 'package:car2godriver/controller/withdraw_dialouge_screen_dialouge_controller.dart';
import 'package:car2godriver/models/api_responses/get_withdraw_saved_methods.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class WithdrawDialogWidget extends StatelessWidget {
  final String title;
  final String description;
  // final String buttonText;

  const WithdrawDialogWidget({
    super.key,
    this.title = '',
    this.description = '',
    // required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawDialogWidgetScreenController>(
        global: false,
        init: WithdrawDialogWidgetScreenController(),
        builder: (controller) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                height: 400,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 61, 61, 61),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.withdrawKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextFormField(
                              validator: Helper.withdrawValidator,
                              controller: controller.amountController,
                              labelText: "Enter Amount",
                              labelTextColor: AppColors.primaryTextColor,
                              hintText: AppLanguageTranslation
                                  .enterYourAmountTransKey.toCurrentLanguage,
                            ),
                            AppGaps.hGap16,
                            Obx(() =>
                                DropdownButtonFieldWidget<WithdrawMethodsItem>(
                                  labelText: 'Select withdraw method',
                                  labelTextColor: AppColors.primaryTextColor,
                                  hintText: 'Select withdraw method',
                                  items: controller.withdrawMethod,
                                  isLoading: controller.isElementsLoading.value,
                                  value: controller.selectedSavedWithdrawMethod,
                                  getItemText: (item) => item.type,
                                  onChanged: controller.onMethodChanged,
                                )),
                            AppGaps.hGap16,
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: CustomStretchedTextButtonWidget(
                                  buttonText: AppLanguageTranslation
                                      .withdrawTransKey.toCurrentLanguage,
                                  // backgroundColor: AppColors.alertColor,
                                  onTap: controller.onContinueButtonTap,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
