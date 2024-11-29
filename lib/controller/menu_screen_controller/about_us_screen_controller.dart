import 'dart:developer';

import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:get/get.dart';
import 'package:car2godriver/models/api_responses/about_us_response.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';

class AboutusScreenController extends GetxController {
  // WebViewController webViewController = WebViewController();
  /*<----------- Initialize variables ----------->*/
  AboutUsData aboutUsTextItem = AboutUsData.empty();

  /*<-----------Get about us text from API ----------->*/
  Future<void> getAboutusText() async {
    AboutUsResponse? response = await APIRepo.getAboutUsText();
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noResponseFoundTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingCategoriesList(response);
  }

  onSuccessRetrievingCategoriesList(AboutUsResponse response) {
    aboutUsTextItem = response.data;
    update();
  }

  /* <---- Initial state ----> */
  @override
  void onInit() {
    getAboutusText();
    super.onInit();
  }
}
