import 'package:car2godriver/controller/topup_screen_controller.dart';
import 'package:car2godriver/models/fakeModel/fake_data.dart';
import 'package:car2godriver/models/local/profile_dynamic_field_widget_paramter.dart';
import 'package:car2godriver/ui/screens/bottomsheet/profile_dynamic_field_bottomsheet.dart';
import 'package:car2godriver/ui/screens/wallet_withdraw/wallet_withdraw_screen_controller.dart';
import 'package:car2godriver/utils/app_singleton.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/double.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/screen_widget/amount_box.dart';
import 'package:car2godriver/ui/widgets/screen_widget/document_item.dart';
import 'package:car2godriver/ui/widgets/select_payment_method_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletWithdrawScreen extends StatelessWidget {
  const WalletWithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletWithdrawScreenController>(
        init: WalletWithdrawScreenController(),
        builder: (controller) => CustomScaffold(
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText: 'Withdraw',
                  hasBackButton: true),
              /* <-------- Body Content --------> */
              body: ScaffoldBodyWidget(
                  child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: controller.walletWithdrawFormKey,
                child: CustomScrollView(
                  slivers: [
                    /* <---- for extra 20px gap in height ----> */
                    const SliverToBoxAdapter(child: VerticalGap(20)),
                    SliverToBoxAdapter(
                        child: Text.rich(TextSpan(children: [
                      const TextSpan(
                        text: 'Your current wallet balance: ',
                      ),
                      TextSpan(
                          text: controller.walletScreenController.walletDetails
                              .currentBalance.total
                              .getCurrencyFormattedText(),
                          style: const TextStyle(color: AppColors.primaryColor))
                    ]))),
                    const SliverToBoxAdapter(child: VerticalGap(24)),
                    SliverToBoxAdapter(
                      child: CustomTextFormField(
                        validator: controller.amountValidator,
                        controller: controller.amountController,
                        prefixIcon: Text(AppComponents.currencySymbol),
                        prefixSpaceSize: 5,
                        labelText: 'How much do you want to withdraw?',
                        textInputType: TextInputType.number,
                        hintText: r'E.g 50',
                      ),
                    ),
                    const SliverToBoxAdapter(child: VerticalGap(24)),
                    SliverToBoxAdapter(
                        child: Text(
                      '${controller.selectedWithdrawMethod.name} information',
                      style: AppTextStyles.bodySemiboldTextStyle
                          .copyWith(fontSize: 20),
                    )),
                    if (controller.selectedWithdrawMethod.channels.isNotEmpty)
                      const SliverToBoxAdapter(child: VerticalGap(16)),
                    if (controller.selectedWithdrawMethod.channels.isNotEmpty)
                      SliverToBoxAdapter(
                        child: DropdownButtonFormFieldWidget(
                          value: controller.selectedChannel,
                          hintText: 'Select channel',
                          labelText: 'Select channel',
                          validator: (value) {
                            if (value == null) {
                              return 'Channel is required';
                            }
                            return null;
                          },
                          // items: controller.genderOptions,
                          items: controller.selectedWithdrawMethod.channels,
                          getItemText: (item) => item,
                          onChanged: controller.onChannelSelected,
                        ),
                      ),

                    const SliverToBoxAdapter(child: VerticalGap(16)),
                    // Dynamic fields
                    SliverList.separated(
                      itemBuilder: (context, index) {
                        final dynamicFieldValue =
                            controller.dynamicFieldValues[index];
                        return ProfileDocumentsDynamicItem(
                            title: dynamicFieldValue.keyValue,
                            type: dynamicFieldValue.typeAsSealedClass,
                            isRequired: dynamicFieldValue.isRequired,
                            values: dynamicFieldValue.values,
                            onTap: () => controller.onDynamicFieldTap(
                                dynamicFieldValue, index));
                      },
                      separatorBuilder: (context, index) =>
                          const VerticalGap(16),
                      itemCount: controller.dynamicFieldValues.length,
                    ),
                    const SliverToBoxAdapter(child: VerticalGap(100)),
                    /* <---- Top Up amount text field----> */
                  ],
                ),
              )),
              bottomNavigationBar: ScaffoldBodyWidget(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomStretchedButtonWidget(
                    isLoading: controller.isLoading,
                    onTap: controller.shouldDisableWithdrawButton
                        ? null
                        : controller.makeWithdraw,
                    child: Text(
                      AppLanguageTranslation.withdrawTransKey.toCurrentLanguage,
                    ),
                  ),
                  AppGaps.hGap20,
                ],
              )),
            ));
  }
}

class TopUpPaymentMethodItemWidget extends StatelessWidget {
  final String imageURL;
  final String name;
  final bool isSelected;
  final void Function()? onTap;
  const TopUpPaymentMethodItemWidget(
      {super.key,
      this.imageURL = '',
      this.name = '',
      this.isSelected = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
        onTap: onTap,
        borderRadiusValue: 8,
        backgroundColor:
            isSelected ? AppColors.primaryColor.withOpacity(0.2) : null,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.formBorderColor)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox.square(
                    dimension: 32,
                    child: CachedNetworkImageWidget(
                      imageURL: imageURL,
                      boxFit: BoxFit.contain,
                    ),
                  ),
                  const HorizontalGap(12),
                  Expanded(
                      child: Text(name,
                          style: AppTextStyles.bodyMediumTextStyle
                              .copyWith(fontSize: 16)))
                ]),
          ),
        ));
  }
}
