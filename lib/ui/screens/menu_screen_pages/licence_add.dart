import 'package:car2godriver/controller/complete_profile_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddLicenseScreen extends StatelessWidget {
  const AddLicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompleteProfileScreenController>(
        init: CompleteProfileScreenController(),
        builder: (controller) => CustomScaffold(
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText:
                      AppLanguageTranslation.documentTranskey.toCurrentLanguage,
                  hasBackButton: true),
              body: ScaffoldBodyWidget(
                  child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(children: [
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: controller.documentsFormKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppGaps.hGap15,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      AppLanguageTranslation
                                          .documentTranskey.toCurrentLanguage,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.bodyTextColor)),
                                ],
                              ),
                              AppGaps.hGap20,
                              CustomTextFormField(
                                  validator: Helper.textFormValidator,
                                  isRequired: true,
                                  controller:
                                      controller.licenseNumberEditingController,
                                  labelText: AppLanguageTranslation
                                      .licenseNumberTransKey.toCurrentLanguage,
                                  hintText: AppLanguageTranslation
                                      .yourLicenseNumberTransKey
                                      .toCurrentLanguage,
                                  prefixIcon: SvgPicture.asset(
                                      AppAssetImages.profileSVGLogoLine)),
                              AppGaps.hGap24,
                              Row(
                                children: [
                                  Expanded(
                                    child: /* SingleImageUploadWidget(
                                      label: 'Front',
                                      isRequired: true,
                                      imageURL:
                                          controller.documentFrontImageURL,
                                      onImageUploadTap:
                                          controller.onFrontImageUploadTap,
                                      imageByte:
                                          controller.documentFrontImageByte,
                                      // onImageDeleteTap:
                                      //     controller.onFrontImageDeleteTap,
                                    ) */
                                        SingleMixedImageUploadWidget(
                                      label: 'Front image',
                                      isRequired: true,
                                      imageData:
                                          controller.documentFrontImageData,
                                      onTap: controller.onFrontImageUploadTap,
                                      onImageUploadTap:
                                          controller.onFrontImageUploadTap,
                                      onImageDeleteTap:
                                          controller.onFrontImageDeleteTap,
                                    ),
                                  ),
                                  AppGaps.wGap8,
                                  Expanded(
                                    child: /* SingleImageUploadWidget(
                                      label: 'Back Image',
                                      isRequired: true,
                                      imageURL: controller.documentBackImageURL,
                                      onImageUploadTap:
                                          controller.onBackImageUploadTap,
                                      imageByte:
                                          controller.documentBackImageByte,
                                      // onImageDeleteTap:
                                      //     controller.onFrontImageDeleteTap,
                                    ) */
                                        SingleMixedImageUploadWidget(
                                      label: 'Back image',
                                      isRequired: true,
                                      imageData:
                                          controller.documentBackImageData,
                                      onTap: controller.onBackImageUploadTap,
                                      onImageUploadTap:
                                          controller.onBackImageUploadTap,
                                      onImageDeleteTap:
                                          controller.onBackImageDeleteTap,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ]),
                  ))
                ],
              )),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(bottom: 37, right: 24, left: 24),
                child: CustomStretchedTextButtonWidget(
                  isLoading: controller.isLoading,
                  buttonText:
                      AppLanguageTranslation.completeTranskey.toCurrentLanguage,
                  onTap: controller.shouldEnableCompleteButton
                      ? controller.onContinueButtonTap
                      : null, /* () {
              Get.toNamed(AppPageNames.verificationScreen);
            }, */
                ),
              ),
            ));
  }
}
