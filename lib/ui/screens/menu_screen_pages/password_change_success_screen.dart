import 'package:car2godriver/controller/setting_pages_controller/password_change_success_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordChangSuccessScreen extends StatelessWidget {
  const PasswordChangSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<PasswordChangSuccessScreenController>(
      init: PasswordChangSuccessScreenController(),
      builder: (controller) => CustomScaffold(
        /* <-------- AppBar --------> */
        appBar: CoreWidgets.appBarWidget(
            screenContext: context, hasBackButton: false),
        /* <-------- Body Content --------> */
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppAssetImages.passwordChangeSuccessIllustration,
                    cacheHeight: (240 * 1.5).toInt(),
                    cacheWidth: (260 * 1.5).toInt(),
                    height: 240,
                    width: 260),
                /* <-------- 56px height gap --------> */
                AppGaps.hGap56,
                /* HighlightAndDetailTextWidget(
                  textColor: Colors.black,
                  subtextColor: Color(0xff888AA0),
                  isSpaceShorter: true,
                  slogan: AppLanguageTranslation
                      .greatePasswordChangeTransKey.toCurrentLanguage,
                  subtitle: AppLanguageTranslation
                      .problemWithYourAccountTransKey.toCurrentLanguage,
                ), */
                /* <-------- 30px height gap --------> */
                AppGaps.hGap30,
              ],
            ),
          ),
        ),
        /* <-------- Bottom bar button --------> */
        bottomNavigationBar: CustomScaffoldBottomBarWidget(
          child: CustomStretchedTextButtonWidget(
            buttonText: AppLanguageTranslation.loginTransKey.toCurrentLanguage,
            onTap: () {
              Get.offAllNamed(AppPageNames.loginScreen);
            },
          ),
        ),
      ),
    );
  }
}
