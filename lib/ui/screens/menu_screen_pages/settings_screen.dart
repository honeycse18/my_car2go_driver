import 'package:car2godriver/controller/setting_pages_controller/setting_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/screen_widget/settings_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<SettingsScreenController>(
      init: SettingsScreenController(),
      global: false,
      builder: (controller) => CustomScaffold(
        /* <-------- AppBar --------> */
        appBar: CoreWidgets.appBarWidget(
            screenContext: context,
            titleText: AppLanguageTranslation.settingTransKey.toCurrentLanguage,
            hasBackButton: true),
        /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
        /* <-------- Body Content --------> */
        body: ScaffoldBodyWidget(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* AppGaps.hGap16,
                      /* <---- 'Notification' List Tile ----> */
                      SettingsListTileWidget(
                          titleText: 'Notification',
                          showRightArrow: false,
                          valueWidget: FlutterSwitch(
                            value: controller.toggleNotification.value,
                            width: 35,
                            height: 20,
                            toggleSize: 12,
                            activeColor: AppColors.primaryColor,
                            onToggle: (value) {
                              controller.toggleNotification.value = value;
                              controller.update();
                            },
                          ),
                          onTap: () {
                            controller.toggleNotification.value =
                                !controller.toggleNotification.value;
                            controller.update();
                          }), */
                    /* <-------- 32px height gap --------> */
                    AppGaps.hGap32,
                    /* <-------- Change password Button --------> */
                    SettingsListTileWidget(
                      titleText: AppLanguageTranslation
                          .changePasswordTransKey.toCurrentLanguage,
                      onTap: () {
                        Get.toNamed(AppPageNames.changePasswordPromptScreen);
                      },
                      settingsValueTextWidget: const Text(''),
                    ),
                    /* <-------- 24px height gap --------> */
                    AppGaps.hGap24,
                    /* <-------- Settings language Button --------> */
                    SettingsListTileWidget(
                      titleText: AppLanguageTranslation
                          .changeLanguageTransKey.toCurrentLanguage,
                      onTap: () async {
                        await Get.toNamed(AppPageNames.languageScreen);
                        controller.update();
                      },
                      settingsValueTextWidget: Text(
                        controller.currentLanguageText,
                        style: const TextStyle(color: AppColors.bodyTextColor),
                      ),
                    ),
                    /* <-------- 24px height gap --------> */
                    AppGaps.hGap24,
                    /* <-------- Settings delete account Button --------> */
                    SettingsListTileWidget(
                      titleText: AppLanguageTranslation
                          .deleteAccountTransKey.toCurrentLanguage,
                      onTap: () {
                        Get.toNamed(AppPageNames.deleteAccount);
                      },
                      settingsValueTextWidget: const Text(''),
                    ),
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
