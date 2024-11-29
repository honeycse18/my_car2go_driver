import 'dart:developer';

import 'package:car2godriver/models/api_responses/language_translations_response.dart';
import 'package:car2godriver/services/profile_service.dart';
import 'package:car2godriver/utils/app_singleton.dart';
import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  final profileService = Get.find<ProfileService>();
  /* <---- Splash screen shows for 2 seconds and go to intro screen ----> */
  Future<void> _serviceInitializationOnSplash() async {
    await profileService.initialization();
  }

  Future<void> delayAndGotoNextScreen() async {
    await _serviceInitializationOnSplash();
    await AppSingleton.instance.updateSiteSettings();
    await Future.delayed(const Duration(seconds: 3));
    // In case, the screen is not shown after 2 seconds, Do nothing.
    // Go to intro screen
    Get.offNamedUntil(_pageRouteName, (_) => false);
    // Get.toNamed(AppPageNames.introScreen);
  }

/* <---- Go to next page ----> */
  String get _pageRouteName {
    final String pageRouteName;
    if (Helper.isUserLoggedIn()) {
      pageRouteName = AppPageNames.zoomDrawerScreen;
    } else {
      pageRouteName = AppPageNames.introScreen;
    }
    return pageRouteName;
  }

  static Future<void> getLanguageTranslations() async {
    LanguageTranslationsResponse? response =
        await APIRepo.fetchLanguageTranslations();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetLanguageTranslations(response);
  }

  static void _onSuccessGetLanguageTranslations(
      LanguageTranslationsResponse response) async {
    dynamic defaultLanguage =
        AppSingleton.instance.localBox.get(AppConstants.hiveDefaultLanguageKey);
    bool isDefaultLanguageSet = (defaultLanguage is String);
    for (LanguageTranslation languageTranslation in response.data) {
      languageTranslation.translation[AppConstants.languageTranslationKeyCode] =
          '${languageTranslation.code}_${languageTranslation.flag}';
      await AppSingleton.instance.localBox
          .put(languageTranslation.name, languageTranslation.translation);
      if (!isDefaultLanguageSet && languageTranslation.isDefault) {
        await AppSingleton.instance.localBox
            .put(AppConstants.hiveDefaultLanguageKey, languageTranslation.name);
      }
    }
  }

/* <---- Initial state ----> */
  @override
  void onInit() {
    delayAndGotoNextScreen();
    getLanguageTranslations();
    super.onInit();
  }
}
