import 'package:car2godriver/controller/splash_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  /* <---- Splash screen shows for 2 seconds and go to intro screen ----> */

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<SplashScreenController>(
        init: SplashScreenController(),
        builder: (controller) => Scaffold(
              /* <-------- Body Content --------> */
              backgroundColor: AppColors.primaryColor,
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /* <----- App logo -----> */
                    Image.asset(AppAssetImages.splashImage,
                        height: 124, width: 187),
                    /* <-------- 10px width gap --------> */
                    AppGaps.wGap10,
                    /* <---- App Name text ----> */
                    Text(
                      // Edit this app version code text as it changes
                      AppLanguageTranslation.appTitleTransKey.toCurrentLanguage,

                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ));
  }
}
