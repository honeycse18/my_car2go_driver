import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:car2godriver/controller/home_navigator_screen_controller.dart';
import 'package:car2godriver/ui/screens/car_pooling/requests_car_pooling.dart';
import 'package:car2godriver/ui/screens/home_navigator/home_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/wallet_screen.dart';
import 'package:car2godriver/ui/screens/ride_history_screen.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class HomeNavigatorScreen extends StatelessWidget {
  final String? titleWidget;
  const HomeNavigatorScreen({super.key, this.titleWidget = ''});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<HomeNavigatorScreenController>(
        global: false,
        init: HomeNavigatorScreenController(),
        // ignore: deprecated_member_use
        builder: (controller) => PopScope(
              onPopInvoked: (didPop) async {
                controller.onClose();
              },
              child: CustomScaffold(
                resizeToAvoidBottomInset: false,
                // key: controller.homeNavigationKey,
                extendBody: true,
                extendBodyBehindAppBar: true,
                /* <-------- AppBar --------> */
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    hasBackButton: false,
                    titleText: controller.titleText,
                    leading: Center(
                      child: RawButtonWidget(
                        onTap: () {
                          if (ZoomDrawer.of(context)?.isOpen() ?? false) {
                            ZoomDrawer.of(context)?.close();
                          } else {
                            ZoomDrawer.of(context)?.open();
                          }
                        },
                        child: const SvgPictureAssetWidget(
                            height: 24,
                            width: 24,
                            AppAssetImages.menuSVGLogoLine,
                            color: AppColors.primaryButtonColor),
                      ),
                    ),
                    actions: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: RawButtonWidget(
                            onTap: () async {
                              await Get.toNamed(
                                  AppPageNames.notificationScreen);
                            },
                            child: const SvgPictureAssetWidget(
                                height: 24,
                                width: 24,
                                AppAssetImages.notificationSVGLogoLine,
                                color: AppColors.primaryButtonColor)),
                      )
                    ]),
                /* <-------- Body Content --------> */
                body: /*  PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(controller.bottomBarPages.length,
                      (index) => controller.bottomBarPages[index]),
                ) */
                    IndexedStack(
                        index: controller.currentIndex,
                        children: const [
                      HomeScreen(),
                      RequestCarPullingScreen(),
                      RideHistoryScreen(),
                      WalletScreen(),
                    ]),
                /* <-------- Bottom bar button --------> */
                bottomNavigationBar: (controller.bottomBarPages.length <=
                        controller.maxCount)
                    ? AnimatedNotchBottomBar(
                        itemLabelStyle: AppTextStyles.bodySmallMediumTextStyle
                            .copyWith(color: AppColors.primaryButtonColor),
                        bottomBarWidth: width,
                        notchBottomBarController:
                            controller.notchBottomBarController,
                        color: AppColors.primaryColor,
                        showLabel: true,
                        shadowElevation: 1,
                        kBottomRadius: 12.0,
                        notchColor: AppColors.primaryColor,
                        removeMargins: false,
                        durationInMilliSeconds: 50,
                        bottomBarItems: [
                          BottomBarItem(
                            inActiveItem: const SvgPictureAssetWidget(
                                color: AppColors.primaryButtonColor,
                                height: 24,
                                width: 24,
                                AppAssetImages.homeSvgFillIcon),
                            activeItem: const SvgPictureAssetWidget(
                                color: AppColors.primaryButtonColor,
                                height: 24,
                                width: 24,
                                AppAssetImages.homeSvgFillIcon),
                            itemLabel: AppLanguageTranslation
                                .homeTransKey.toCurrentLanguage,
                          ),
                          BottomBarItem(
                            inActiveItem: const SvgPictureAssetWidget(
                                color: AppColors.primaryButtonColor,
                                height: 24,
                                width: 24,
                                AppAssetImages.requestsSvgFillIcon),
                            activeItem: const SvgPictureAssetWidget(
                                color: AppColors.primaryButtonColor,
                                height: 24,
                                width: 24,
                                AppAssetImages.requestsSvgFillIcon),
                            itemLabel: AppLanguageTranslation
                                .requestTransKey.toCurrentLanguage,
                          ),
                          BottomBarItem(
                            inActiveItem: const SvgPictureAssetWidget(
                                color: AppColors.primaryButtonColor,
                                height: 24,
                                width: 24,
                                AppAssetImages.routingSvgFillIcon),
                            activeItem: const SvgPictureAssetWidget(
                                color: AppColors.primaryButtonColor,
                                height: 24,
                                width: 24,
                                AppAssetImages.routingSvgFillIcon),
                            itemLabel: AppLanguageTranslation
                                .myTripTransKey.toCurrentLanguage,
                          ),
                          BottomBarItem(
                            inActiveItem: const SvgPictureAssetWidget(
                                color: AppColors.primaryButtonColor,
                                height: 24,
                                width: 24,
                                AppAssetImages.walletSvgFillIcon),
                            activeItem: const SvgPictureAssetWidget(
                                color: AppColors.primaryButtonColor,
                                height: 24,
                                width: 24,
                                AppAssetImages.walletSvgFillIcon),
                            itemLabel: AppLanguageTranslation
                                .walletTransKey.toCurrentLanguage,
                          ),
                        ],
                        onTap: (index) {
                          // controller.pageController.jumpToPage(index);
                          controller.currentIndex = index;
                          controller.update();
                        },
                        kIconSize: 24.0,
                      )
                    : null,
              ),
            ));
  }
}
