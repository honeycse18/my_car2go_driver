import 'package:car2godriver/controller/create_new_password_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<CreateNewPasswordScreenController>(
        init: CreateNewPasswordScreenController(),
        builder: (controller) => CustomScaffold(
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                  titleText: '', screenContext: context, hasBackButton: true),
              /* <-------- Body Content --------> */
              /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
              body: ScaffoldBodyWidget(
                  child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: controller.changePassFormKey,
                child: Column(
                  children: [
                    /* <-------- 24px height gap --------> */
                    AppGaps.hGap24,
                    Expanded(
                        child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /* <-------- 32px height gap --------> */
                          AppGaps.hGap32,
                          Text(
                            AppLanguageTranslation
                                .createNewPasswordTransKey.toCurrentLanguage,
                            style: AppTextStyles.titleBoldTextStyle
                                .copyWith(color: AppColors.primaryTextColor),
                          ),
                          /* <-------- 8px height gap --------> */
                          AppGaps.hGap8,
                          Text(
                            AppLanguageTranslation
                                .youCanLoginTransKey.toCurrentLanguage,
                            style: AppTextStyles.bodyLargeTextStyle
                                .copyWith(color: AppColors.bodyTextColor),
                          ),
                          /* <-------- 32px height gap --------> */
                          AppGaps.hGap32,
                          Obx(() => CustomTextFormField(
                                validator: controller.passwordFormValidator,
                                controller:
                                    controller.passwordTextEditingController,
                                isPasswordTextField:
                                    controller.toggleHidePassword.value,
                                labelText: AppLanguageTranslation
                                    .newPasswordTransKey.toCurrentLanguage,
                                hintText: '********',
                                prefixIcon: const SvgPictureAssetWidget(
                                    AppAssetImages.unlockSVGLogoLine),
                                suffixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    color: Colors.transparent,
                                    onPressed:
                                        controller.onPasswordSuffixEyeButtonTap,
                                    icon: SvgPictureAssetWidget(
                                        AppAssetImages.hideSVGLogoLine,
                                        color:
                                            controller.toggleHidePassword.value
                                                ? AppColors.bodyTextColor
                                                : AppColors.primaryColor)),
                              )),
                          /* <-------- 24px height gap --------> */
                          AppGaps.hGap24,
                          Obx(() => CustomTextFormField(
                                validator: controller.passwordFormValidator,
                                controller: controller
                                    .confirmPasswordTextEditingController,
                                isPasswordTextField:
                                    controller.toggleHideConfirmPassword.value,
                                labelText: AppLanguageTranslation
                                    .confirmPasswordTransKey.toCurrentLanguage,
                                hintText: '********',
                                prefixIcon: const SvgPictureAssetWidget(
                                    AppAssetImages.unlockSVGLogoLine),
                                suffixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    color: Colors.transparent,
                                    onPressed: controller
                                        .onConfirmPasswordSuffixEyeButtonTap,
                                    icon: SvgPictureAssetWidget(
                                        AppAssetImages.hideSVGLogoLine,
                                        color: controller
                                                .toggleHideConfirmPassword.value
                                            ? AppColors.bodyTextColor
                                            : AppColors.primaryColor)),
                              )),
                          /* <-------- 32px height gap --------> */
                          AppGaps.hGap32,
                        ],
                      ),
                    ))
                  ],
                ),
              )),
              /* <-------- Bottom bar button --------> */
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                    bottom: 30 + context.mediaQueryViewInsets.bottom,
                    right: 24,
                    left: 24),
                /* <-------- Save password button --------> */
                child: CustomStretchedTextButtonWidget(
                  buttonText: AppLanguageTranslation
                      .savePasswordTransKey.toCurrentLanguage,
                  onTap: controller.onSavePasswordButtonTap,
                ),
              ),
            ));
  }
}
