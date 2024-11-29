import 'package:car2godriver/ui/screens/bottomsheet/base_bottom_sheet.dart';
import 'package:car2godriver/ui/bottomsheets/wallet/select_withdraw_method/select_wallet_withdraw_method_bottomsheet_controller.dart';
import 'package:car2godriver/utils/app_singleton.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/screen_widget/withdraw_method_bottomsheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectWalletWithdrawMethodBottomSheet extends StatelessWidget {
  const SelectWalletWithdrawMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectWalletWithdrawMethodBottomSheetController>(
        init: SelectWalletWithdrawMethodBottomSheetController(),
        builder: (controller) => BaseBottomSheet(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const VerticalGap(12),
                const BottomSheetTopNotch(),
                const VerticalGap(8),
                Row(
                  children: [
                    TightIconButtonWidget(
                      onTap: () => Get.back(),
                      icon: const SvgPictureAssetWidget(
                        AppAssetImages.backButtonSVGLogoLine,
                        color: AppColors.primaryColor,
                        height: 16,
                        width: 16,
                      ),
                    ),
                    const HorizontalGap(12),
                    Text(
                      'Select withdraw method',
                      style: AppTextStyles.bodySemiboldTextStyle
                          .copyWith(fontSize: 20),
                    ),
                  ],
                ),
                const VerticalGap(28),
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final withdrawMethod = AppSingleton
                          .instance.settings.withdrawMethodsInfo[index];
                      return RawButtonWidget(
                          borderRadiusValue: 8,
                          onTap: () => controller
                              .onWithdrawMethodItemTap(withdrawMethod),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: AppColors.formBorderColor)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox.square(
                                  dimension: 32,
                                  child: CachedNetworkImageWidget(
                                    imageURL: withdrawMethod.logo,
                                    boxFit: BoxFit.contain,
                                  ),
                                ),
                                const HorizontalGap(12),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        withdrawMethod.name,
                                        style: AppTextStyles.bodyMediumTextStyle
                                            .copyWith(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const HorizontalGap(5),
                                SvgPictureAssetWidget(
                                    controller.selectedWithdrawMethod.id ==
                                            withdrawMethod.id
                                        ? AppAssetImages.radioSVG
                                        : AppAssetImages.radioUnselectedSVG),
                              ],
                            ),
                          ));
                    },
                    separatorBuilder: (context, index) => const VerticalGap(16),
                    itemCount: AppSingleton
                        .instance.settings.withdrawMethodsInfo.length),
                const VerticalGap(32),
                CustomStretchedTextButtonWidget(
                  buttonText:
                      AppLanguageTranslation.continueTransKey.toCurrentLanguage,
                  onTap: controller.shouldDisableContinueButton
                      ? null
                      : controller.onContinueButtonTap,
                ),
                const VerticalGap(30),
              ],
            )));
  }
}
