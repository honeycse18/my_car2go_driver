import 'package:car2godriver/controller/login_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/constants/ui_constants.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<LoginScreenController>(
        global: false,
        init: LoginScreenController(),
        /* <-------- Custom Scaffold for background Scaffold design --------> */
        builder: (controller) => CustomScaffold(
              appBar: CoreWidgets.appBarWidget(
                  titleText:
                      AppLanguageTranslation.loginTransKey.toCurrentLanguage,
                  screenContext: context,
                  hasBackButton: true),
              /* <-------- Side padding for scaffold body contents  --------> */
              body: ScaffoldBodyWidget(
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
                                .welcomeAppTitleTransKey.toCurrentLanguage,
                            style: AppTextStyles.titleBoldTextStyle
                                .copyWith(color: AppColors.primaryTextColor),
                          ),
                          /* <-------- 8px height gap --------> */
                          AppGaps.hGap8,
                          Text(
                            controller.phoneMethod
                                ? AppLanguageTranslation
                                    .enterYourPhoneToCreateAccountTransKey
                                    .toCurrentLanguage
                                : AppLanguageTranslation
                                    .enterYourEmailToCreateAccountTransKey
                                    .toCurrentLanguage,
                            style: AppTextStyles.bodyLargeTextStyle.copyWith(
                                color: AppColors.bodyTextColor,
                                fontFamily:
                                    AppUIConstants.fontFamilySFProDisplay),
                          ),
                          /* <-------- 32px height gap --------> */
                          AppGaps.hGap32,
                          controller.phoneMethod
                              /* <-------- Phone Number Input Field --------> */
                              ? CustomPhoneNumberTextFormFieldWidget(
                                  initialCountryCode:
                                      controller.currentCountryCode,
                                  controller:
                                      controller.phoneTextEditingController,
                                  hintText: '0197464646',
                                  onCountryCodeChanged:
                                      controller.onCountryChange,
                                )
                              /* <-------- Email Input Field --------> */
                              : CustomTextFormField(
                                  // validator: Helper.emailFormValidator,
                                  controller:
                                      controller.emailTextEditingController,
                                  labelText: AppLanguageTranslation
                                      .emailAddressTransKey.toCurrentLanguage,
                                  hintText: 'E.g: demo.example@gmail.com',
                                  prefixIcon: const SvgPictureAssetWidget(
                                      AppAssetImages.emailSVGLogoLine),
                                ),
                          /* <-------- 32px height gap --------> */
                          AppGaps.hGap32,
                          /* <-------- Continue Button --------> */
                          CustomStretchedButtonWidget(
                            onTap: controller.onContinueButtonTap,
                            child: Text(AppLanguageTranslation
                                .continueTransKey.toCurrentLanguage),
                          ),
                          /* <-------- 32px height gap --------> */
                          AppGaps.hGap32,
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 0.5,
                                  decoration: const BoxDecoration(
                                      color: AppColors.bodyTextColor),
                                ),
                              ),
                              /* <-------- 8px width gap --------> */
                              AppGaps.wGap8,
                              Text(
                                AppLanguageTranslation
                                    .orWithTransKey.toCurrentLanguage,
                                style: AppTextStyles.bodyMediumTextStyle
                                    .copyWith(color: AppColors.bodyTextColor),
                              ),
                              /* <-------- 8px width gap --------> */
                              AppGaps.wGap8,
                              Expanded(
                                child: Container(
                                  height: 0.5,
                                  decoration: const BoxDecoration(
                                      color: AppColors.bodyTextColor),
                                ),
                              ),
                            ],
                          ),
                          /* <-------- 32px height gap --------> */
                          AppGaps.hGap32,
                          controller.phoneMethod
                              /* <-------- Login with email button --------> */

                              ? /* CustomStretchedOutlinedTextButtonWidget(
                                  image: Image.asset('assets/images/Email.png'),
                                  onTap: controller
                                      .onMethodButtonTap /* () {
                                      // Get.toNamed(AppPageNames.emailLogInScreen);
                                    } */
                                  ,
                                  buttonText: AppLanguageTranslation
                                      .continueWithEmailTransKey) */

                              ColoredOutlinedIconTextButton(
                                  icon: const SvgPictureAssetWidget(
                                      AppAssetImages.emailSVGLogoLine,
                                      color: AppColors.primaryTextColor),
                                  text: AppLanguageTranslation
                                      .continueWithEmailTransKey,
                                  onTap: controller.onMethodButtonTap)
                              /* <-------- Login with phone number button --------> */
                              : /* CustomStretchedOutlinedTextButtonWidget(
                                  image: Image.asset('assets/images/Phone.png'),
                                  onTap: controller
                                      .onMethodButtonTap /* () {
                                      // Get.toNamed(AppPageNames.emailLogInScreen);
                                    } */
                                  ,
                                  buttonText: AppLanguageTranslation
                                      .continueWithPhoneTransKey), */
                              ColoredOutlinedIconTextButton(
                                  icon: Image.asset('assets/images/Phone.png'),
                                  text: AppLanguageTranslation
                                      .continueWithPhoneTransKey,
                                  onTap: controller.onMethodButtonTap),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ));
  }
}
