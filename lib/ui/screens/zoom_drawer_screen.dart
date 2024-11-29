import 'package:car2godriver/controller/drawer_screen_controller.dart';
import 'package:car2godriver/ui/screens/home_navigator_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class ZoomDrawerScreen extends StatelessWidget {
  const ZoomDrawerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<ZoomDrawerScreenController>(
        global: false,
        init: ZoomDrawerScreenController(),
        builder: (controller) => PopScope(
              onPopInvoked: (didPop) {
                controller.onClose();
              },
              child: Scaffold(
                extendBody: true,
                extendBodyBehindAppBar: true,
                /* <-------- Body Content --------> */
                body: ZoomDrawer(
                  menuBackgroundColor: AppColors.primaryColor.withOpacity(0.5),
                  controller: controller.zoomDrawerController,
                  menuScreen: const MenuScreen(),
                  mainScreen: const HomeNavigatorScreen(),
                  showShadow: true,
                  style: DrawerStyle.defaultStyle,
                  angle: 0.0,
                  isRtl: false,
                  disableDragGesture: true,
                  androidCloseOnBackTap: true,
                  mainScreenTapClose: true,
                  moveMenuScreen: true,
                  // disableDragGesture: false,
                  // androidCloseOnBackTap: true,
                  // mainScreenTapClose: true,
                  // moveMenuScreen: true,
                ),
                /* bottomNavigationBar:
                    (controller.bottomBarPages.length <= controller.maxCount)
                        ? AnimatedNotchBottomBar(
                            color: AppColors.primaryColor,
                            showLabel: true,
                            shadowElevation: 5,
                            kBottomRadius: 28.0,
                            notchColor: Colors.black87,
                            removeMargins: false,
                            bottomBarWidth: 500,
                            durationInMilliSeconds: 30,
                            itemLabelStyle:
                                const TextStyle(color: AppColors.bodyTextColor),
                            bottomBarItems: const [
                              BottomBarItem(
                                inActiveItem: Icon(
                                  Icons.home_filled,
                                  color: AppColors.bodyTextColor,
                                ),
                                activeItem: Icon(
                                  Icons.home_filled,
                                  color: AppColors.primaryColor,
                                ),
                                itemLabel: 'Home',
                              ),
                              BottomBarItem(
                                inActiveItem: SvgPictureAssetWidget(
                                  AppAssetImages.requestSVGLogoLine,
                                  color: AppColors.bodyTextColor,
                                ),
                                activeItem: SvgPictureAssetWidget(
                                    AppAssetImages.requestSVGLogoLine
          
                                    //  color: AppColors.primaryColor,
                                    ),
                                itemLabel: 'Request',
                              ),
                              BottomBarItem(
                                inActiveItem: SvgPictureAssetWidget(
                                    AppAssetImages.upcomingSVGLogoLine
          
                                    //  color: AppColors.primaryColor,
                                    ),
                                activeItem: SvgPictureAssetWidget(
                                    AppAssetImages.upcomingSVGLogoLine
          
                                    //  color: AppColors.primaryColor,
                                    ),
                                itemLabel: 'Upcoming',
                              ),
                              BottomBarItem(
                                inActiveItem: SvgPictureAssetWidget(
                                    AppAssetImages.walletSVGLogoLine
          
                                    //  color: AppColors.primaryColor,
                                    ),
                                activeItem: SvgPictureAssetWidget(
                                    AppAssetImages.walletSVGLogoLine
          
                                    //  color: AppColors.primaryColor,
          
                                    ),
                                itemLabel: 'Wallet',
                              ),
                            ],
                            notchBottomBarController:
                                controller.notchBottomBarController,
                            onTap: (index) {
                              controller.pageController.jumpToPage(index);
                            },
                            kIconSize: 24.0,
                          )
                        : null, */
              ),
            ));
  }
}
