import 'package:car2godriver/controller/login_password_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPasswordScreen extends StatelessWidget {
  const LoginPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<LogInPasswordSCreenController>(
        init: LogInPasswordSCreenController(),
        /* <-------- Custom Scaffold for background Scaffold design --------> */
        builder: (controller) => CustomScaffold(
              extendBody: true,
              /* <-------- AppBar --------> */

              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText:
                      AppLanguageTranslation.loginTransKey.toCurrentLanguage,
                  hasBackButton: true),
              /* <-------- Body Content  --------> */
              /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
              body: ScaffoldBodyWidget(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.passwordFormKey,
                  child: Column(
                    children: [
                      /* <-------- 27px height gap --------> */
                      AppGaps.hGap27,
                      controller.isEmail
                          /* <-------- Email Input Field --------> */
                          ? CustomTextFormField(
                              isReadOnly: true,
                              initialText: controller.credentials['email'],
                              labelText: AppLanguageTranslation
                                  .emailAddressTransKey.toCurrentLanguage,
                              hintText: 'E.g: demo@example@gmail.com',
                              prefixIcon: const SvgPictureAssetWidget(
                                  AppAssetImages.emailSVGLogoLine),
                            )
                          /* <-------- Phone Number Input Field --------> */
                          : CustomPhoneNumberTextFormFieldWidget(
                              isReadOnly: true,
                              initialCountryCode:
                                  controller.selectedCountryCode,
                              initialText: controller.phoneNumber,
                              hintText: '0197464646',
                            ),
                      Obx(
                        /* <-------- Password Input Field --------> */
                        () => CustomTextFormField(
                          // validator: Helper.passwordFormValidator,
                          controller: controller.passwordTextEditingController,
                          isPasswordTextField:
                              controller.toggleHidePassword.value,
                          labelText: AppLanguageTranslation
                              .passwordTransKey.toCurrentLanguage,
                          hintText: '********',
                          prefixIcon: const SvgPictureAssetWidget(
                              AppAssetImages.unlockSVGLogoLine),
                          suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              color: Colors.transparent,
                              onPressed:
                                  controller.onPasswordSuffixEyeButtonTap,
                              icon: SvgPictureAssetWidget(
                                  controller.toggleHidePassword.value
                                      ? AppAssetImages.hideSVGLogoLine
                                      : AppAssetImages.showSVGLogoLine,
                                  color: controller.toggleHidePassword.value
                                      ? AppColors.bodyTextColor
                                      : AppColors.primaryColor)),
                        ),
                      ),
                      /* <-------- 16px height gap --------> */
                      AppGaps.hGap16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /* <---- Forget password text button ----> */
                          CustomTightTextButtonWidget(
                            onTap: controller.onForgotPasswordButtonTap,
                            child: Text(
                                AppLanguageTranslation
                                    .forgotPasswordTransKey.toCurrentLanguage,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: AppColors.primaryTextColor)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              /* <------- Bottom Navigation Bar --------> */
              bottomNavigationBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 30 + context.mediaQueryViewInsets.bottom,
                        right: 24,
                        left: 24),
                    /* <-------- Login Button --------> */
                    child: CustomStretchedTextButtonWidget(
                      buttonText: AppLanguageTranslation
                          .loginTransKey.toCurrentLanguage,
                      onTap: controller.onLoginButtonTap,
                    ),
                  ),
                ],
              ),
            ));
  }
}
