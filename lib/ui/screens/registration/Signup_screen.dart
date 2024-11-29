import 'package:car2godriver/controller/registration_screen_controller.dart';
import 'package:car2godriver/models/enums/gender.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<RegistrationScreenController>(
        init: RegistrationScreenController(),
        builder: (controller) => CustomScaffold(
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText:
                      AppLanguageTranslation.registerTransKey.toCurrentLanguage,
                  hasBackButton: true),
              /* <-------- Body Content --------> */
              /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
              body: ScaffoldBodyWidget(
                  child: Form(
                autovalidateMode: AutovalidateMode.disabled,
                key: controller.signUpFormKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* <-------- 20px height gap --------> */
                      AppGaps.hGap20,
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLanguageTranslation
                                    .gettingStartedTransKey.toCurrentLanguage,
                                style: AppTextStyles.titleBoldTextStyle,
                              ),
                              /* <-------- 8px height gap --------> */
                              AppGaps.hGap8,
                              Text(
                                AppLanguageTranslation
                                    .setUpYourProfileTransKey.toCurrentLanguage,
                                style: AppTextStyles.bodyLargeTextStyle
                                    .copyWith(color: AppColors.bodyTextColor),
                              ),
                              /* <-------- 10px height gap --------> */
                              AppGaps.hGap10,
                              /* <-------- Full name input field --------> */
                              CustomTextFormField(
                                  validator: Helper.textFormValidator,
                                  controller:
                                      controller.nameTextEditingController,
                                  labelText: AppLanguageTranslation
                                      .fullNameTransKey.toCurrentLanguage,
                                  hintText: 'eg: John doe',
                                  prefixIcon: const SvgPictureAssetWidget(
                                      AppAssetImages.profileSVGLogoLine)),
                              /* <-------- 24px height gap --------> */
                              AppGaps.hGap24,
                              /* <-------- Email input field --------> */
                              if (controller.isEmail)
                                CustomTextFormField(
                                    validator: Helper.emailFormValidator,
                                    controller:
                                        controller.emailTextEditingController,
                                    isReadOnly:
                                        controller.screenParameter!.isEmail,
                                    labelText: AppLanguageTranslation
                                        .emailAddressTransKey.toCurrentLanguage,
                                    hintText: 'eg: abc@example.com',
                                    prefixIcon: const SvgPictureAssetWidget(
                                        AppAssetImages.emailSVGLogoLine)),
                              /* <-------- 24px height gap --------> */
                              AppGaps.hGap24,
                              /* <-------- phone number input field --------> */
                              if (controller.isEmail == false)
                                PhoneNumberTextFormFieldWidget(
                                  validator: Helper.phoneFormValidator,
                                  initialCountryCode:
                                      controller.currentCountryCode,
                                  controller:
                                      controller.phoneTextEditingController,
                                  isReadOnly:
                                      !controller.screenParameter!.isEmail,
                                  labelText: AppLanguageTranslation
                                      .phoneNumberTransKey,
                                  hintText: '197464646',
                                  onCountryCodeChanged:
                                      controller.onCountryChange,
                                ),
                              /* <-------- 16px height gap --------> */
                              // AppGaps.hGap16,
                              /* Obx(
                            () => CustomTextFormField(
                              isReadOnly: true,
                              controller: TextEditingController(
                                  text: controller.selectedGender.value),
                              labelText: 'Gender',
                              hintText: 'Gender',
                              prefixIcon:
                                  SvgPicture.asset(AppAssetImages.gender),
                              suffixIcon: InkWell(
                                onTap: () {
                                  controller.toggleDropdown();
                                },
                                child: const Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                          ),
                          Obx(
                            () => Visibility(
                              visible: controller.isDropdownOpen.value,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: const Text('Male'),
                                    onTap: () {
                                      controller.selectGender('Male');
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('Female'),
                                    onTap: () {
                                      controller.selectGender('Female');
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('Other'),
                                    onTap: () {
                                      controller.selectGender('Other');
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ), */
                              /* <-------- 24px height gap --------> */
                              AppGaps.hGap24,

                              DropdownButtonFormFieldWidget<Gender>(
                                value: controller.selectedGender,
                                hintText: 'Select Gender',
                                labelText: 'Gender',
                                validator: (value) {
                                  if (value == null) {
                                    return 'Gender is required';
                                  }
                                  return null;
                                },
                                // items: controller.genderOptions,
                                items: Gender.list,
                                getItemText: (gender) => gender
                                    .viewableTextTransKey.toCurrentLanguage,
                                onChanged: controller.onGenderChange,
                              ),
                              AppGaps.hGap24,
                              CustomTextFormField(
                                validator: controller.cityFormValidator,
                                controller: controller.cityController,
                                labelText: AppLanguageTranslation
                                    .cityTransKey.toCurrentLanguage,
                                hintText: 'San Francisco',
                                prefixIcon: const SvgPictureAssetWidget(
                                    AppAssetImages.pickLocationSVGLogoLine),
                              ),
                              AppGaps.hGap24,
                              CustomTextFormField(
                                validator: controller.addressFormValidator,
                                controller: controller.addressController,
                                labelText: AppLanguageTranslation
                                    .addressTransKey.toCurrentLanguage,
                                hintText: '27, Elephant road',
                                prefixIcon: const SvgPictureAssetWidget(
                                    AppAssetImages.pickLocationSVGLogoLine),
                              ),
                              AppGaps.hGap24,
                              /* <-------- Password input field --------> */
                              Obx(() => PasswordFormFieldWidget(
                                  passwordValidator:
                                      controller.passwordFormValidator,
                                  controller:
                                      controller.passwordTextEditingController,
                                  hidePassword:
                                      controller.toggleHidePassword.value,
                                  onPasswordVisibilityToggleButtonTap:
                                      controller.onPasswordSuffixEyeButtonTap,
                                  label: AppLanguageTranslation
                                      .passwordTransKey.toCurrentLanguage,
                                  showValidatorRules: true)),

                              /* <-------- 24px height gap --------> */
                              AppGaps.hGap24,
                              /* <-------- Confirm Password input field --------> */
                              Obx(() => CustomTextFormField(
                                    validator:
                                        controller.confirmPasswordFormValidator,
                                    controller: controller
                                        .confirmPasswordTextEditingController,
                                    isPasswordTextField: controller
                                        .toggleHideConfirmPassword.value,
                                    labelText: AppLanguageTranslation
                                        .confirmPasswordTransKey
                                        .toCurrentLanguage,
                                    hintText: '********',
                                    prefixIcon: const SvgPictureAssetWidget(
                                        AppAssetImages.unlockSVGLogoLine),
                                    suffixIcon: IconButton(
                                        padding: EdgeInsets.zero,
                                        visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity),
                                        color: Colors.transparent,
                                        onPressed: controller
                                            .onConfirmPasswordSuffixEyeButtonTap,
                                        icon: SvgPictureAssetWidget(
                                            controller.toggleHideConfirmPassword
                                                    .value
                                                ? AppAssetImages.hideSVGLogoLine
                                                : AppAssetImages
                                                    .showSVGLogoLine,
                                            color: controller
                                                    .toggleHideConfirmPassword
                                                    .value
                                                ? AppColors.bodyTextColor
                                                : AppColors.primaryColor)),
                                  )),
                              /* <-------- 16px height gap --------> */
                              AppGaps.hGap16,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: screenSize.width < 458
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Obx(() => Checkbox(
                                        value: controller
                                            .toggleAgreeTermsConditions.value,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        onChanged: controller
                                            .onToggleAgreeTermsConditions)),
                                  ),
                                  /* <-------- 16px width gap --------> */
                                  AppGaps.wGap12,
                                  /* <-------- Terms and condition option --------> */
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => controller
                                          .onToggleAgreeTermsConditions,
                                      /* controller
                                          .onToggleAgreeTermsConditions(
                                              !controller
                                                  .toggleAgreeTermsConditions
                                                  .value), */
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Text(
                                            AppLanguageTranslation
                                                .createingAccountYouAgreeTransKey
                                                .toCurrentLanguage,
                                            style: AppTextStyles.bodyTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .bodyTextColor),
                                          ),
                                          // AppGaps.wGap5,
                                          CustomTightTextButtonWidget(
                                              onTap: () {
                                                // Get.toNamed(AppPageNames
                                                //     .termsConditionScreen);
                                              },
                                              child: Text(
                                                AppLanguageTranslation
                                                    .termsConditionTransKey
                                                    .toCurrentLanguage,
                                                style: AppTextStyles
                                                    .bodyTextStyle
                                                    .copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        color: AppColors
                                                            .primaryColor),
                                              )),
                                          /* AppGaps.wGap5,
                                       const Text('and'),
                                      AppGaps.wGap5,
                                      CustomTightTextButtonWidget(
                                          onTap: () {
                                            // Get.toNamed(AppPageNames
                                            //     .privacyPolicyScreen);
                                          },
                                          child: Text(
                                            'Privacy Policy',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: AppColors
                                                        .primaryColor),
                                          )), */
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              /* <-------- 32px height gap --------> */
                              AppGaps.hGap32,
                              /* <-------- Continue Button --------> */
                              CustomStretchedTextButtonWidget(
                                buttonText: AppLanguageTranslation
                                    .continueTransKey.toCurrentLanguage,
                                onTap:
                                    controller.toggleAgreeTermsConditions.value
                                        ? controller.onContinueButtonTap
                                        : null,
                              ),
                              /* <-------- 32px height gap --------> */
                              AppGaps.hGap32,
                            ],
                          ),
                        ),
                      ),
                    ]),
              )),
            ));
  }
}
