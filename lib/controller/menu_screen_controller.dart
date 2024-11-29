import 'dart:async';

import 'package:car2godriver/models/api_responses/profile_details.dart';
import 'package:car2godriver/services/profile_service.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:get/get.dart';

class MenuScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  final profileService = Get.find<ProfileService>();
  StreamSubscription<ProfileDetails>? profileUpdateSubscriber;
  ProfileDetails get profileDetails => profileService.profileDetails;
  set profileDetails(ProfileDetails value) {
    profileService.profileDetails = value;
  }

  void onLogOutButtonTap() async {
    await AppDialogs.showConfirmDialog(
        messageText:
            AppLanguageTranslation.wantToLogoutTransKey.toCurrentLanguage,
        titleText: AppLanguageTranslation.logOutTransKey.toCurrentLanguage,
        onYesTap: () async {
          Helper.logout();
        });
  }

  Future<void> getUserDetails() async => Helper.updateSavedDriverDetails();

  /* <---- Initial state ----> */
  @override
  void onInit() {
    profileUpdateSubscriber ??= profileService.profileDetailsRX.listen((data) {
      update();
    });
    // getUserDetails();
    super.onInit();
  }

  @override
  void onClose() {
    profileUpdateSubscriber?.cancel();
    profileUpdateSubscriber = null;
    super.onClose();
  }
}
