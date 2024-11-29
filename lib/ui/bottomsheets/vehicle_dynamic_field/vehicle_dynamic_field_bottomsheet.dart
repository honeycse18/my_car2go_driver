import 'package:car2godriver/models/sealed_classes/dynamic_field_type.dart';
import 'package:car2godriver/ui/screens/bottomsheet/base_bottom_sheet.dart';
import 'package:car2godriver/ui/bottomsheets/vehicle_dynamic_field/vehicle_dynamic_field_bottomsheet_controller.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/screen_widget/profile_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditVehicleDynamicFieldBottomSheet extends StatelessWidget {
  const EditVehicleDynamicFieldBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditVehicleDynamicFieldBottomSheetController>(
        init: EditVehicleDynamicFieldBottomSheetController(),
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
                      controller.valueDetails.vehicleFieldInfo.fieldName,
                  subtitle:
                      controller.valueDetails.vehicleFieldInfo.placeholder,
                  child: controller.valueDetails.vehicleFieldInfo
                          .typeAsSealedClass.isTextField
                      ? CustomTextFormField(
                          controller: controller.textController,
                          textInputType: switch (controller.valueDetails
                              .vehicleFieldInfo.typeAsSealedClass) {
                            DynamicFieldText() => TextInputType.text,
                            DynamicFieldTextarea() => TextInputType.multiline,
                            DynamicFieldEmail() => TextInputType.emailAddress,
                            DynamicFieldNumber() => TextInputType.number,
                            _ => TextInputType.text,
                          },
                          maxLines: switch (controller.valueDetails
                              .vehicleFieldInfo.typeAsSealedClass) {
                            DynamicFieldTextarea() => 5,
                            _ => 1,
                          },
                          hintText: controller
                              .valueDetails.vehicleFieldInfo.placeholder,
                        )
                      : switch (controller
                          .valueDetails.vehicleFieldInfo.typeAsSealedClass) {
                          DynamicFieldImage() => switch (controller.valueDetails
                                .vehicleFieldInfo.typeAsSealedClass) {
                              DynamicFieldSingleImage() =>
                                SingleImageUploadWidget(
                                    width: null,
                                    label: controller.valueDetails
                                        .vehicleFieldInfo.placeholder,
                                    imageData:
                                        controller.fieldValues.firstOrNull,
                                    onTap: controller.uploadSingleImage,
                                    onImageDeleteTap:
                                        controller.onSingleImageDeleteTap,
                                    onImageUploadTap:
                                        controller.uploadSingleImage),
                              DynamicFieldMultipleImage() =>
                                MultiImageUploadSectionWidget(
                                  label: controller.valueDetails
                                      .vehicleFieldInfo.placeholder,
                                  imageURLs: controller.fieldValues,
                                  onImageUploadTap: () =>
                                      controller.uploadMultipleImages(
                                          maxImageCount: (controller
                                                      .valueDetails
                                                      .vehicleFieldInfo
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
                                  label: controller.valueDetails
                                      .vehicleFieldInfo.placeholder,
                                  imageData: controller.fieldValues.firstOrNull,
                                  onImageUploadTap:
                                      controller.uploadSingleImage),
                            },
                          _ => CustomTextFormField(
                              controller: controller.textController,
                              hintText: controller
                                  .valueDetails.vehicleFieldInfo.placeholder,
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
