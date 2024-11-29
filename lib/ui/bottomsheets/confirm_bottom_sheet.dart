import 'package:car2godriver/ui/screens/bottomsheet/base_bottom_sheet.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmBottomSheet extends StatelessWidget {
  final String title;
  final String yesButtonText;
  final String noButtonText;
  const ConfirmBottomSheet(
      {super.key,
      required this.title,
      required this.yesButtonText,
      required this.noButtonText});

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
        child: Column(
      children: [
        const VerticalGap(19),
        Text(
          title,
          style: AppTextStyles.titleSemiSmallSemiboldTextStyle
              .copyWith(color: AppColors.primaryTextColor),
        ),
        AppGaps.hGap32,
        CustomStretchedTextButtonWidget(
            onTap: () {
              Get.back(result: true);
            },
            buttonText: yesButtonText,
            backgroundColor: AppColors.errorColor),
        AppGaps.hGap16,
        RawButtonWidget(
          onTap: () {
            Get.back();
          },
          child: Container(
            height: 56,
            width: 360,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.secondaryButtonColor,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              noButtonText,
              style: AppTextStyles.bodyLargeSemiboldTextStyle
                  .copyWith(color: AppColors.buttonLightStandardColor),
            ),
          ),
        ),
        const VerticalGap(30),
      ],
    ));
  }
}
