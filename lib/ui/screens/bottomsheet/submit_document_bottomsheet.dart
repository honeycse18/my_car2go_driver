import 'package:car2godriver/controller/bottom_screen_controller/submit_document_bottomsheet_controller.dart';
import 'package:car2godriver/ui/screens/bottomsheet/base_bottom_sheet.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/screen_widget/documents_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitDocumentBottomSheet extends StatelessWidget {
  const SubmitDocumentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubmitDocumentBottomSheetController>(
        init: SubmitDocumentBottomSheetController(),
        builder: (controller) {
          return BaseBottomSheet(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalGap(12),
              const BottomSheetTopNotch(),
              const VerticalGap(12),
              Text(
                controller.getTitleName,
                style: AppTextStyles.bodyLargeSemiboldTextStyle
                    .copyWith(color: AppColors.primaryTextColor),
              ),
              AppGaps.hGap12,
              Row(children: [
                Expanded(
                  child: ImageDocumentFieldWidget(
                    onTap: controller.takeFrontImageFromPhone,
                    onImageTap: () {
                      Get.toNamed(AppPageNames.imageZoomScreen,
                          arguments: controller.frontImageData);
                    },
                    title: 'Front',
                    subTitle: 'JPG, PNG',
                    imageData: controller.frontImageData,
                  ),
                ),
/*                 AppGaps.wGap16,
                Expanded(
                  child: ImageDocumentFieldWidget(
                    onTap: controller.takeBackImageFromPhone,
                    onImageTap: () {
                      Get.toNamed(AppPageNames.imageZoomScreen,
                          arguments: controller.backImageData);
                    },
                    title: 'Back',
                    subTitle: 'JPG,PNG',
                    imageData: controller.backImageData,
                  ),
                ), */
              ]),
              AppGaps.hGap32,
              CustomStretchedButtonWidget(
                  isLoading: controller.isLoading,
                  onTap: controller.shouldDisableSubmitButton
                      ? null
                      : controller.onSubmitButtonTap,
                  child: Text(controller.getButtonText)),
              const VerticalGap(30),
            ],
          ));
        });
  }
}
