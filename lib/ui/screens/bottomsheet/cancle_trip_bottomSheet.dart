import 'package:car2godriver/controller/bottom_screen_controller/update_document_bottomsheet_controller.dart';
import 'package:car2godriver/ui/screens/bottomsheet/base_bottom_sheet.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancleTripBottomsheet extends StatelessWidget {
  const CancleTripBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CancleTripBottomsheetController>(
        init: CancleTripBottomsheetController(),
        builder: (controller) {
          return BaseBottomSheet(
              child: Column(
            children: [
              const VerticalGap(19),
              Text(
                "Are you sure you want to cancel?",
                style: AppTextStyles.titleSemiSmallSemiboldTextStyle
                    .copyWith(color: AppColors.primaryTextColor),
              ),
              AppGaps.hGap32,
              CustomStretchedTextButtonWidget(
                  onTap: () {
                    Get.toNamed(AppPageNames.cancelRideReason);
                  },
                  buttonText: 'Yes, Cancel',
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
                    'No, Keep Ride',
                    style: AppTextStyles.bodyLargeSemiboldTextStyle
                        .copyWith(color: AppColors.buttonLightStandardColor),
                  ),
                ),
              ),
              const VerticalGap(30),
            ],
          ));
        });
  }
}
