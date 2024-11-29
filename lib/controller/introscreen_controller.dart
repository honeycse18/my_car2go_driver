import 'package:car2godriver/models/fakeModel/fake_data.dart';
import 'package:car2godriver/models/fakeModel/intro_content_model.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  IntroContent fakeIntroContent = FakeData.introContents.first;
  final PageController pageController = PageController(keepPage: false);
  int currentIndex = 0;

  /* <---- Go to next intro section ----> */
  void gotoNextIntroSection(BuildContext context) {
    // If intro section ends, goto sign in screen.
    if (isLastPage) {
      Get.toNamed(AppPageNames.loginScreen);
    }
    /*<----------- Go to previous intro section ----------->*/
    pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn);
    update();
  }

  /// Go to previous intro section
  void gotoPreviousIntroSection(BuildContext context) {
    // Goto next intro section
    pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  bool get isFirstPage {
    try {
      return pageController.page == pageController.initialPage;
    } catch (e) {
      return true;
    }
  }

  bool get isLastPage {
    try {
      return currentIndex == (FakeData.introContents.length - 1);
    } catch (e) {
      return false;
    }
  }
}
