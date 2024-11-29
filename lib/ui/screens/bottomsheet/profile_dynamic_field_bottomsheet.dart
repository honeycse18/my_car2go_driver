import 'package:car2godriver/controller/bottom_screen_controller/profile_dynamic_field_bottomsheet_controller.dart';
import 'package:car2godriver/models/sealed_classes/dynamic_field_type.dart';
import 'package:car2godriver/ui/screens/bottomsheet/base_bottom_sheet.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/screen_widget/profile_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileDynamicFieldBottomSheet extends StatelessWidget {
  const EditProfileDynamicFieldBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileDynamicFieldBottomSheetController>(
        init: ProfileDynamicFieldBottomSheetController(),
        global: false,
        builder: (controller) {
          return BaseBottomSheet(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VerticalGap(12),
              const BottomSheetTopNotch(),
              const VerticalGap(8),
              ProfileFieldWidget(
                  appBarTitle:
                      controller.valueDetails.driverFieldInfo.fieldName,
                  subtitle: controller.valueDetails.driverFieldInfo.placeholder,
                  child: controller.valueDetails.driverFieldInfo
                          .typeAsSealedClass.isTextField
                      ? CustomTextFormField(
                          controller: controller.textController,
                          textInputType: switch (controller
                              .valueDetails.driverFieldInfo.typeAsSealedClass) {
                            DynamicFieldText() => TextInputType.text,
                            DynamicFieldTextarea() => TextInputType.multiline,
                            DynamicFieldEmail() => TextInputType.emailAddress,
                            DynamicFieldNumber() => TextInputType.number,
                            _ => TextInputType.text,
                          },
                          maxLines: switch (controller
                              .valueDetails.driverFieldInfo.typeAsSealedClass) {
                            DynamicFieldTextarea() => 5,
                            _ => 1,
                          },
                          hintText: controller
                              .valueDetails.driverFieldInfo.placeholder,
                        )
                      : switch (controller
                          .valueDetails.driverFieldInfo.typeAsSealedClass) {
                          DynamicFieldImage() => switch (controller.valueDetails
                                .driverFieldInfo.typeAsSealedClass) {
                              DynamicFieldSingleImage() =>
                                SingleImageUploadWidget(
                                    width: null,
                                    label: controller.valueDetails
                                        .driverFieldInfo.placeholder,
                                    imageData:
                                        controller.fieldValues.firstOrNull,
                                    onTap: controller.uploadSingleImage,
                                    onImageDeleteTap:
                                        controller.onSingleImageDeleteTap,
                                    onImageUploadTap:
                                        controller.uploadSingleImage),
                              DynamicFieldMultipleImage() =>
                                MultiImageUploadSectionWidget(
                                  label: controller
                                      .valueDetails.driverFieldInfo.placeholder,
                                  imageURLs: controller.fieldValues,
                                  onImageUploadTap: () =>
                                      controller.uploadMultipleImages(
                                          maxImageCount: (controller
                                                      .valueDetails
                                                      .driverFieldInfo
                                                      .typeAsSealedClass
                                                  as DynamicFieldMultipleImage)
                                              .maxImageCount),
                                  onImageTap: controller.onMultipleImageTap,
                                  onImageEditTap:
                                      controller.onMultipleImageEditTap,
                                  onImageDeleteTap:
                                      controller.onMultipleImageDeleteTap,
                                ),
                              _ => SingleImageUploadWidget(
                                  label: controller
                                      .valueDetails.driverFieldInfo.placeholder,
                                  imageData: controller.fieldValues.firstOrNull,
                                  onImageUploadTap:
                                      controller.uploadSingleImage),
                            },
                          _ => CustomTextFormField(
                              controller: controller.textController,
                              hintText: controller
                                  .valueDetails.driverFieldInfo.placeholder,
                            ),
                        }),
              AppGaps.hGap32,
              CustomStretchedButtonWidget(
                isLoading: controller.isLoading,
                onTap: controller.onSubmitButtonTap,
                child: Text(controller.buttonText),
              ),
              const VerticalGap(30),
            ],
          ));
        });
  }
}
