import 'package:car2godriver/controller/menu_screen_controller/helps_support_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/screen_widget/settings_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<HelpSupportScreenController>(
      init: HelpSupportScreenController(),
      global: false,
      builder: (controller) => CustomScaffold(
        /* <-------- AppBar --------> */
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleText:
              AppLanguageTranslation.helpSupportTransKey.toCurrentLanguage,
          hasBackButton: true,
        ),
        /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
        body: ScaffoldBodyWidget(
            child: Column(
          children: [
            /* <-------- 30px height gap --------> */
            AppGaps.hGap30,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /* <-------- Content --------> */

                    AppGaps.hGap16,
                    SettingsListTileWidget(
                      titleText: AppLanguageTranslation
                          .contactUsTransKey.toCurrentLanguage,
                      /* valueWidget: SettingsValueTextWidget(
                        text: controller.currentLanguageText), */
                      onTap: () {
                        Get.toNamed(AppPageNames.contactUs);
                      },
                      settingsValueTextWidget: const Text(''),
                    ),
                    /* <-------- 16px height gap --------> */
                    AppGaps.hGap16,
                    SettingsListTileWidget(
                      titleText: AppLanguageTranslation
                          .privacyPolicyTranskey.toCurrentLanguage,
                      /* valueWidget: SettingsValueTextWidget(
                        text: controller.currentLanguageText), */
                      onTap: () {
                        Get.toNamed(AppPageNames.privacyPolicyScreen);
                      },
                      settingsValueTextWidget: const Text(''),
                    ),
                    /* <-------- 16px height gap --------> */
                    AppGaps.hGap16,
                    SettingsListTileWidget(
                      titleText: AppLanguageTranslation
                          .termsConditionTransKey.toCurrentLanguage,
                      /* valueWidget: SettingsValueTextWidget(
                        text: controller.currentLanguageText), */
                      onTap: () {
                        Get.toNamed(
                          AppPageNames.termCondition,
                        );
                        // await Get.toNamed(AppPageNames.languageScreen);
                        controller.update();
                      },
                      settingsValueTextWidget: const Text(''),
                    ),
                    /* <-------- 50px height gap --------> */
                    AppGaps.hGap50,
                    /* <-------- FAQA Button --------> */
                    CustomStretchedOutlinedButtonWidget(
                      child: Text(
                        AppLanguageTranslation.faqaTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyLargeBoldTextStyle
                            .copyWith(color: AppColors.primaryColor),
                      ),
                      onTap: () {
                        Get.toNamed(AppPageNames.faqaScreen);
                      }
                      // onTap: controller
                      //     .onMethodButtonTap /* () {
                      //     // Get.toNamed(AppPage Names.emailLogInScreen);
                      //   } */
                      ,
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
