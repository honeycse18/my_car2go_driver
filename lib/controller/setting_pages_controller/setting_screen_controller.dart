import 'package:car2godriver/utils/app_singleton.dart';
import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:get/get.dart';

class SettingsScreenController extends GetxController {
  // RxBool isLoading = false.obs;
  /*<----------- Initialize variables ----------->*/
  RxBool toggleNotification = true.obs;
  String get currentLanguageText {
    final dynamic currentLanguageName =
        AppSingleton.instance.localBox.get(AppConstants.hiveDefaultLanguageKey);
    if (currentLanguageName is String) {
      return currentLanguageName;
    }
    return '';
  }
}
