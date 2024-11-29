import 'dart:developer';

import 'package:action_slider/action_slider.dart';
import 'package:car2godriver/controller/submit_otp_start_trip_bottomsheet_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitOtpStartRideBottomSheet extends StatelessWidget {
  const SubmitOtpStartRideBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubmitOtpStartRideBottomSheetController>(
      init: SubmitOtpStartRideBottomSheetController(),
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 12),
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              const BottomSheetTopNotch(),
              AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: RawButtonWidget(
                      child:
                          const BackButton(color: AppColors.primaryTextColor),
                      onTap: () {
                        Get.back();
                      }),
                  title: const Text(
                    'Start OTP',
                  )),
              //
              AppGaps.hGap27,
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppLanguageTranslation.otpTranskey.toCurrentLanguage,
                    style: AppTextStyles.bodyLargeMediumTextStyle,
                  ),
                  AppGaps.wGap4,
                  Text(
                    AppLanguageTranslation
                        .userProvideThisOtpTranskey.toCurrentLanguage,
                    style: AppTextStyles.bodySmallTextStyle.copyWith(
                      color: AppColors.bodyTextColor,
                    ),
                  ),
                ],
              ),
              AppGaps.hGap8,
              CustomTextFormField(
                textInputType: TextInputType.number,
                controller: controller.otpTextEditingController,
                hintText: 'eg,0515',
              ),
              AppGaps.hGap32,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ActionSlider.standard(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      icon: Transform.scale(
                        scaleX: -1,
                        child: const SvgPictureAssetWidget(
                          AppAssetImages.arrowLeftSVGLogoLine,
                          color: Colors.white,
                        ),
                      ),
                      successIcon: const SvgPictureAssetWidget(
                        AppAssetImages.tikSVGLogoSolid,
                        color: Colors.white,
                        height: 34,
                        width: 34,
                      ),
                      foregroundBorderRadius:
                          const BorderRadius.all(Radius.circular(18)),
                      backgroundBorderRadius:
                          const BorderRadius.all(Radius.circular(18)),
                      sliderBehavior: SliderBehavior.stretch,
                      width: MediaQuery.of(context).size.width * 0.85,
                      backgroundColor: AppColors.primaryColor,
                      toggleColor:
                          AppColors.primaryButtonColor.withOpacity(0.3),
                      action: (slideController) async {
                        slideController.loading();
                        await Future.delayed(const Duration(seconds: 2));
                        await controller.acceptRejectRideRequest();
                        if (controller.isSuccess) {
                          await Future.delayed(const Duration(seconds: 1));
                          slideController.success();
                        } else {
                          slideController.failure();
                          controller.otpTextEditingController.clear();
                          slideController.reset();
                        }
                        log('successfully tapped');
                        await Future.delayed(const Duration(seconds: 1));
                        Get.offNamed(
                          AppPageNames.startRideRequestScreen,
                          arguments: controller.rideDetails,
                        );
                      },
                      child: Text(
                        AppLanguageTranslation
                            .swapToStartTripTranskey.toCurrentLanguage,
                        style: AppTextStyles.bodyLargeSemiboldTextStyle
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              AppGaps.hGap8,
            ],
          ),
        ),
      ),
    );
  }
}
