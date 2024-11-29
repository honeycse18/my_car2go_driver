import 'package:car2godriver/controller/trip_permit/trip_permit_payment_summery_screen_controller.dart';
import 'package:car2godriver/models/fakeModel/fake_data.dart';
import 'package:car2godriver/utils/app_singleton.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/double.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/select_payment_method_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripPermitPaymentSummeryScreen extends StatelessWidget {
  const TripPermitPaymentSummeryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripPermitPaymentSummeryScreenController>(
      global: false,
      init: TripPermitPaymentSummeryScreenController(),
      builder: (controller) => CustomScaffold(
        appBar: CoreWidgets.appBarWidget(
            screenContext: context,
            hasBackButton: true,
            titleText: controller.isRenew
                ? 'Renew now'
                : AppLanguageTranslation
                    .paymentMethodTranskey.toCurrentLanguage),
        body: CustomScaffoldBodyWidget(
            child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: ScreenTopGap()),
/*             SliverToBoxAdapter(
              child: Text(
                'Select method',
                style: AppTextStyles.poppinsBodySemiboldTextStyle
                    .copyWith(fontSize: 20),
              ),
            ),
            const SliverToBoxAdapter(child: VerticalGap(16)),
            SliverList.separated(
              itemCount:
                  AppSingleton.instance.settings.activePaymentGateways.length,
              itemBuilder: (context, index) {
                final paymentOption =
                    AppSingleton.instance.settings.activePaymentGateways[index];
                final bool isSelected =
                    paymentOption.name == controller.selectedPaymentOption.name;
                return CustomListTileWidget(
                    hasShadow: isSelected,
                    paddingValue: const EdgeInsets.all(0),
                    onTap: () => controller.onPaymentOptionTap(paymentOption),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      height: 60,
                      decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor.withOpacity(0.2)
                              : null,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.formBorderColor)),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CachedNetworkImageWidget(
                              imageURL: paymentOption.logo,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain)),
                              ),
                            ),
                          ),
                          AppGaps.wGap15,
                          Expanded(
                              child: Text(
                            paymentOption.name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          )),
                          // AppGaps.wGap16,
                          // CustomRadioWidget(
                          //     value: index,
                          //     groupValue: selectedPaymentOptionIndex,
                          //     onChanged: radioOnChange),
                        ],
                      ),
                    ));
              },
              separatorBuilder: (context, index) => const VerticalGap(16),
            ), */
            SliverToBoxAdapter(
              child: Text(
                'Payment method',
                style: AppTextStyles.poppinsBodySemiboldTextStyle
                    .copyWith(fontSize: 20),
              ),
            ),
            const SliverToBoxAdapter(child: VerticalGap(12)),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.wallet_rounded,
                      size: 35,
                      color: AppColors.primaryColor,
                    ),
                    AppGaps.wGap15,
                    Expanded(
                        child: Text(
                      'Wallet',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    )),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Current balance',
                          style: TextStyle(fontSize: 12),
                        ),
                        const HorizontalGap(12),
                        Text(
                          controller.tripPermitDetails.wallet.currentBalance
                              .getCurrencyFormattedText(),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                    // AppGaps.wGap16,
                    // CustomRadioWidget(
                    //     value: index,
                    //     groupValue: selectedPaymentOptionIndex,
                    //     onChanged: radioOnChange),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: VerticalGap(24)),
            SliverToBoxAdapter(
              child: Text(
                'Order details',
                style: AppTextStyles.poppinsBodySemiboldTextStyle
                    .copyWith(fontSize: 20),
              ),
            ),
            const SliverToBoxAdapter(child: VerticalGap(16)),
            SliverToBoxAdapter(
                child: Container(
              height: 116,
              decoration: BoxDecoration(
                color: AppColors.appbarTittleColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    blurStyle: BlurStyle.normal,
                    color: AppColors.yColor,
                    offset: Offset.zero,
                    spreadRadius: 1,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        '${controller.selectedPackage.durationInDay} days trip permit',
                        style: AppTextStyles.poppinsBodyTextStyle
                            .copyWith(fontSize: 18),
                      )),
                      Text(
                          controller.selectedPackage.price
                              .getCurrencyFormattedText(),
                          style: AppTextStyles.poppinsBodyMediumTextStyle
                              .copyWith(fontSize: 18)),
                    ],
                  ),
                  AppGaps.hGap10,
                  const Divider(color: AppColors.formBorderColor),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Total',
                        style: AppTextStyles.poppinsBodyTextStyle
                            .copyWith(fontSize: 18),
                      )),
                      Text(
                          controller.selectedPackage.price
                              .getCurrencyFormattedText(),
                          style: AppTextStyles.poppinsBodyMediumTextStyle
                              .copyWith(
                                  fontSize: 18, color: AppColors.primaryColor)),
                    ],
                  ),
                ],
              ),
            )),
            const SliverToBoxAdapter(child: ScreenBottomGap(height: 100)),
          ],
        )),
        bottomNavigationBar: ScaffoldBottomBarWidget(
            child: PoppinsStretchedTextButtonWidget(
          buttonText: 'Confirm and pay',
          isLoading: controller.isLoading,
          onTap: controller.onConfirmAndPayButtonTap,
        )
            //     PoppinsStretchedTextButtonWidget(
            //   buttonText: 'Confirm and pay',
            //   isLoading: controller.isLoading,
            //   onTap: controller.shouldEnableConfirmAndPayButton
            //       ? controller.onConfirmAndPayButtonTap
            //       : null,
            // )
            ),
      ),
    );
  }
}
