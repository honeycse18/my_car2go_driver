import 'package:car2godriver/controller/menu_screen_controller/contact_us_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<ContactUsScreenController>(
        init: ContactUsScreenController(),
        builder: (controller) => CustomScaffold(
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleText: AppLanguageTranslation
                      .contactUsTransKey.toCurrentLanguage),
              // appBar: CoreWidgets.appBarWidget(screenContext: context),
              /* <-------- Body Content --------> */
              body: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppGaps.screenPaddingValue),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // margin: const EdgeInsets.all(15),
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                  color: AppColors.formBorderColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: GestureDetector(
                                    child: SvgPicture.asset(
                                      AppAssetImages.gpsSVGLogoLine,
                                      color: AppColors.primaryColor,
                                    ),
                                    onTap: () async {
                                      /* final Uri url = Uri.parse(controller
                                          .contactUsDetails.content.map);
                                      try {
                                        if (!await launchUrl(url)) {
                                          AppDialogs.showErrorDialog(
                                              messageText:
                                                  'Could not launch $url');
                                        }
                                      } catch (e) {
                                        AppDialogs.showErrorDialog(
                                            messageText:
                                                'Could not launch $url');
                                      } */
                                    },
                                  )),
                            ),
                            /* <-------- 20px width gap --------> */
                            AppGaps.wGap20,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLanguageTranslation
                                        .addressTransKey.toCurrentLanguage,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    controller
                                            .contactUsAdminDetails
                                            .content
                                            .contactUs
                                            .officeAddresses
                                            .firstOrNull
                                            ?.address ??
                                        '',
                                    maxLines: 2,
                                    style: AppTextStyles.bodyTextStyle.copyWith(
                                        color: AppColors.primaryTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        /* <-------- 25px height gap --------> */
                        AppGaps.hGap25,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // margin: const EdgeInsets.all(15),
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                  color: AppColors.formBorderColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    AppAssetImages.emailSVGLogoLine,
                                    color: AppColors.primaryColor,
                                  )),
                            ),
                            /* <-------- 20px width gap --------> */
                            AppGaps.wGap20,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLanguageTranslation
                                        .emailAddressTransKey.toCurrentLanguage,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    controller.contactUsAdminDetails.content
                                        .contactUs.email,
                                    style: AppTextStyles.bodyTextStyle.copyWith(
                                        color: AppColors.primaryTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        /* <-------- 25px height gap --------> */
                        AppGaps.hGap25,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // margin: const EdgeInsets.all(15),
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                  color: AppColors.formBorderColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  AppAssetImages.callingSVGLogoSolid,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            /* <-------- 20px width gap --------> */
                            AppGaps.wGap20,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLanguageTranslation
                                        .phoneTransKey.toCurrentLanguage,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    controller.contactUsAdminDetails.content
                                        .contactUs.phone,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        /* <-------- 30px height gap --------> */
                        AppGaps.hGap30,
                        /* <---- User full name text field ----> */
                        Text(
                          AppLanguageTranslation
                              .getInTouchTransKey.toCurrentLanguage,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        /* <-------- 15x height gap --------> */
                        AppGaps.hGap15,
                        /* <---- User full name text field ----> */
                        TextFormFieldWidget(
                            controller: controller.nameController,
                            validator: controller.nameFormValidator,
                            labelText: AppLanguageTranslation
                                .yourNameTransKey.toCurrentLanguage,
                            hintText: AppLanguageTranslation
                                .yourNameTransKey.toCurrentLanguage,
                            prefixIcon: SvgPicture.asset(
                              AppAssetImages.profileSVGLogoLine,
                              color: AppColors.primaryColor,
                            )),
                        /* <-------- 15px height gap --------> */
                        AppGaps.hGap15,

                        /* <---- User email text field ----> */
                        TextFormFieldWidget(
                          controller: controller.emailController,
                          // validator: Helper.emailFormValidator,
                          labelText: AppLanguageTranslation
                              .emailAddressTransKey.toCurrentLanguage,
                          hintText: '  contact@gmail.com',
                          prefixIcon: SvgPicture.asset(
                            AppAssetImages.emailSVGLogoLine,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        /* <-------- 15px height gap --------> */
                        AppGaps.hGap15,

                        /* <---- User phone number text field ----> */
                        TextFormFieldWidget(
                          controller: controller.phoneController,
                          // validator: Helper.phoneFormValidator,
                          labelText: AppLanguageTranslation
                              .phoneNumberTransKey.toCurrentLanguage,
                          hintText: '  +01712000000',
                          prefixIcon: SvgPicture.asset(
                            AppAssetImages.callingSVGLogoSolid,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        AppGaps.hGap15,
                        /* <---- Message subject text field ----> */
                        TextFormFieldWidget(
                          controller: controller.subjectController,
                          validator: controller.messageFormValidator,
                          labelText: AppLanguageTranslation
                              .subjectTransKey.toCurrentLanguage,
                          hintText: AppLanguageTranslation
                              .typeSubjectNameTransKey.toCurrentLanguage,
                        ),
                        /* <-------- 15px height gap --------> */
                        AppGaps.hGap15,
                        /* <---- User complain message text field ----> */
                        TextFormFieldWidget(
                          controller: controller.messageController,
                          validator: controller.messageFormValidator,
                          labelText: AppLanguageTranslation
                              .messageTransKey.toCurrentLanguage,
                          maxLines: 5,
                          hintText: AppLanguageTranslation
                              .typeMessageTransKey.toCurrentLanguage,
                        ),
                        /* <-------- 15px height gap --------> */
                        AppGaps.hGap15,
                      ],
                    ),
                  ),
                ),
              ),
              /* <-------- Bottom bar of sign up text --------> */
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /* <---- Sign up text button ----> */
                    CustomStretchedTextButtonWidget(
                        buttonText: AppLanguageTranslation
                            .sendMessageTransKey.toCurrentLanguage,
                        onTap: controller.postContactUsSms)
                  ],
                ),
              ),
            ));
  }
}
