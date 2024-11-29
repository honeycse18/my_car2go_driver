import 'package:car2godriver/controller/menu_screen_controller/add_bank_details_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBankDetailsScreen extends StatelessWidget {
  const AddBankDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<AddBankDetailsScreenController>(
        init: AddBankDetailsScreenController(),
        global: false,
        builder: (controller) => CustomScaffold(
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleText:
                    AppLanguageTranslation.withdrawTransKey.toCurrentLanguage,
                hasBackButton: true,
              ),
              body: ScaffoldBodyWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppGaps.hGap24,
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Your Current Wallet Balance: ',
                                  style: AppTextStyles.walletBalanceSemiBold
                                      .copyWith(
                                    color: AppColors.bodyTextColor,
                                  )),
                              TextSpan(
                                  text: '\$2024 ',
                                  style: AppTextStyles.walletBalanceSemiBold
                                      .copyWith(
                                    color: AppColors.primaryColor,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    AppGaps.hGap24,
                    CustomTextFormField(
                      controller:
                          controller.withdrawAmountTextEditingController,
                      labelText: 'How much do you want to Withdraw?',
                      hintText: 'E.g \$50',
                    ),
                    AppGaps.hGap24,
                    Text(
                      'Bank Information',
                      style: AppTextStyles.titleSemiSmallSemiboldTextStyle
                          .copyWith(color: AppColors.primaryTextColor),
                    ),
                    AppGaps.hGap24,
                    Expanded(
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: CustomTextFormField(
                              controller: controller
                                  .withdrawAmountTextEditingController,
                              labelText: 'Account Holder\'s Name:',
                              hintText: 'e.g Liton Nandi',
                            ),
                          ),
                          const SliverToBoxAdapter(child: AppGaps.hGap24),
                          SliverToBoxAdapter(
                            child: CustomTextFormField(
                              controller: controller
                                  .withdrawAmountTextEditingController,
                              labelText: 'Bank Account Number',
                              hintText: 'e.g Liton Nandi',
                            ),
                          ),
                          const SliverToBoxAdapter(child: AppGaps.hGap24),
                          SliverToBoxAdapter(
                            child: CustomTextFormField(
                              controller: controller
                                  .withdrawAmountTextEditingController,
                              labelText: 'Branch Information',
                              hintText: 'e.g Liton Nandi',
                            ),
                          ),
                          const SliverToBoxAdapter(child: AppGaps.hGap24),
                          SliverToBoxAdapter(
                            child: CustomTextFormField(
                              controller: controller
                                  .withdrawAmountTextEditingController,
                              labelText: 'SWIFT Code',
                              hintText: 'e.g Liton Nandi',
                            ),
                          ),
                          const SliverToBoxAdapter(child: AppGaps.hGap100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                child: CustomStretchedTextButtonWidget(
                    buttonText: AppLanguageTranslation
                        .withdrawTransKey.toCurrentLanguage,
                    onTap: () {
                      AppDialogs.shareRideSuccessDialog(
                        titleText: 'Withdraw Request Success',
                        messageText:
                            'You have successfully sent your \$50 withdrawal request. We will send money 9 business days in your bank account.',
                        homeButtonTap: () async {
                          Get.back();
                        },
                      );
                    }
                    // controller.onSavePasswordButtonTap
                    ),
              ),
            ));
  }
}
