import 'package:car2godriver/controller/bottom_screen_controller/profile_dynamic_field_bottomsheet_controller.dart';
import 'package:car2godriver/models/sealed_classes/dynamic_field_type.dart';
import 'package:car2godriver/ui/screens/bottomsheet/base_bottom_sheet.dart';
import 'package:car2godriver/ui/bottomsheets/dynamic_field/wallet_withdraw/wallet_withdraw_dynamic_field_bottomsheet_controller.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/screen_widget/profile_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletWithdrawDynamicFieldBottomSheet extends StatelessWidget {
  const WalletWithdrawDynamicFieldBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletWithdrawDynamicFieldBottomSheetController>(
        init: WalletWithdrawDynamicFieldBottomSheetController(),
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
                  appBarTitle: controller.valueDetails.keyValue,
                  subtitle: controller.valueDetails.keyValue,
                  child: controller.valueDetails.typeAsSealedClass.isTextField
                      ? CustomTextFormField(
                          controller: controller.textController,
                          textInputType: switch (
                              controller.valueDetails.typeAsSealedClass) {
                            DynamicFieldText() => TextInputType.text,
                            DynamicFieldTextarea() => TextInputType.multiline,
                            DynamicFieldEmail() => TextInputType.emailAddress,
                            DynamicFieldNumber() => TextInputType.number,
                            _ => TextInputType.text,
                          },
                          maxLines: switch (
                              controller.valueDetails.typeAsSealedClass) {
                            DynamicFieldTextarea() => 5,
                            _ => 1,
                          },
                          hintText: controller.valueDetails.keyValue,
                        )
                      : switch (controller.valueDetails.typeAsSealedClass) {
                          DynamicFieldImage() => switch (
                                controller.valueDetails.typeAsSealedClass) {
                              _ => SingleImageUploadWidget(
                                  width: null,
                                  label: controller.valueDetails.keyValue,
                                  imageData: controller.fieldValues.firstOrNull,
                                  onTap: controller.uploadSingleImage,
                                  onImageDeleteTap:
                                      controller.onSingleImageDeleteTap,
                                  onImageUploadTap:
                                      controller.uploadSingleImage),
                            },
                          _ => CustomTextFormField(
                              controller: controller.textController,
                              hintText: controller.valueDetails.keyValue,
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
