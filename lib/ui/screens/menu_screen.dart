import 'package:car2godriver/controller/menu_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/drawer_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<MenuScreenController>(
        global: false,
        init: MenuScreenController(),
        builder: (controller) => Scaffold(
              // backgroundColor: AppColors.primaryColor.withOpacity(0.5),
              /* <-------- Body Content --------> */
              body: RefreshIndicator(
                onRefresh: controller.getUserDetails,
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Container(
                      color: AppColors.primaryColor.withOpacity(0.5),
                      /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
                      child: ScaffoldBodyWidget(
                        child: SafeArea(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /* <-------- 50px height gap --------> */
                                AppGaps.hGap50,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 115,
                                      width: 115,
                                      /* <-------- Fetch user image from API --------> */
                                      child: CachedNetworkImageWidget(
                                        imageURL:
                                            controller.profileDetails.image,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                /* <-------- 20px height gap --------> */
                                AppGaps.hGap20,
                                RawButtonWidget(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  controller
                                                      .profileDetails.name,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .titlesemiSmallMediumTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .primaryTextColor))),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  controller
                                                      .profileDetails.email,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .bodySmallTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .primaryTextColor))),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    // await Get.toNamed(AppPageNames.myAccountScreen);
                                    controller.getUserDetails();
                                  },
                                ),
                                /* <-------- 80px height gap --------> */
                                AppGaps.hGap80,

                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .profileTransKey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.userProfileSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () async {
                                      await Get.toNamed(
                                          AppPageNames.profileScreen);
                                      controller.getUserDetails();
                                      // controller.update();
                                    }),
                                /* <-------- 22px height gap --------> */
                                AppGaps.hGap22,
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .documentTranskey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.userProfileSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () async {
                                      await Get.toNamed(
                                          AppPageNames.documentsScreen);
                                      controller.update();
                                      // controller.update();
                                    }),
                                /* <-------- 22px height gap --------> */
                                AppGaps.hGap22,
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .tripPermitTransKey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.earningSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () async {
                                      await Get.toNamed(
                                          AppPageNames.tripPermitScreen);
                                      controller.update();
                                      // controller.update();
                                    }),
                                AppGaps.hGap22,

                                /* <-------- Go to earning screen button --------> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .earningTransKey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.earningSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () async {
                                      await Get.toNamed(
                                          AppPageNames.earningScreen);
                                      // controller.getUserDetails();
                                      // controller.update();
                                    }),
                                /* <-------- 22px height gap --------> */
                                AppGaps.hGap22,
                                /* <-------- Go to my vehicle screen button --------> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .myVehicleTransKey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.myVehicleSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () async {
/*                                       if (controller.userDetails.vehicle.active
                                          .isNotEmpty) {
                                        await Get.toNamed(
                                            AppPageNames.myVehicleInfo);
                                      } else {
                                        await Get.toNamed(AppPageNames
                                            .vehicleRegistrationScreen);
                                      } */
                                      Get.toNamed(
                                          AppPageNames.myVehiclesScreen);

                                      // controller.getUserDetails();
                                      // controller.update();
                                    }),

                                /* <-------- 22px height gap --------> */
                                AppGaps.hGap22,
                                /* <-------- Go to car pooling screen button --------> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .carPoolingTranskey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.settingFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () async {
                                      await Get.toNamed(
                                          AppPageNames.rideShareScreen);
                                      // controller.getUserDetails();
                                      // controller.update();
                                    }),
                                /* <-------- 22px height gap --------> */
                                AppGaps.hGap22,
                                /* <-------- Go to car pooling history screen button --------> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .carPoolingHistoryTransKey
                                        .toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.myVehicleSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.carPoolingHistroyScreen);
                                      // controller.getUserDetails();
                                      // controller.update();
                                    }),
                                /* <-------- 22px height gap --------> */
                                AppGaps.hGap22,
                                /* <-------- Go to Schedule ride list screen button --------> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .scheduleRideListTransKey
                                        .toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.myVehicleSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.scheduleRideListScreen);
                                      // controller.getUserDetails();
                                      // controller.update();
                                    }),
                                /* <-------- 22px height gap --------> */
                                AppGaps.hGap22,
                                /* <-------- Go to about us screen button --------> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .aboutUsTransKey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.aboutUsSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () {
                                      Get.toNamed(AppPageNames.aboutUs);
                                      // controller.getUserDetails();
                                      // controller.update();
                                    }),

                                // AppGaps.hGap22,
                                /* DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .walletTransKey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.aboutUsSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () {
                                      Get.toNamed(AppPageNames.walletScreen);
                                      // controller.getUserDetails();
                                      // controller.update();
                                    }), */
                                /* <-------- 22px height gap --------> */
                                AppGaps.hGap22,
                                /* <-------- Go to help and support screen button --------> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .helpSupportTransKey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.helpSupportSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () {
                                      Get.toNamed(AppPageNames.helpsupport);
                                      // controller.getUserDetails();
                                      // controller.update();
                                    }),
                                /* <-------- 22px height gap --------> */
                                AppGaps.hGap22,
                                /* <-------- Go to settings screen button --------> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .settingTransKey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.settingFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () async {
                                      await Get.toNamed(
                                          AppPageNames.settingsScreen);
                                      // controller.getUserDetails();
                                      // controller.update();
                                    }),

                                /* <-------- 66px height gap --------> */
                                AppGaps.hGap66,
                                /* <-------- Go to logout button --------> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .logOutTransKey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.logoutSvgFillIcon,
                                    color: AppColors.primaryTextColor,
                                    onTap: controller.onLogOutButtonTap),
                                /* <-------- 22px height gap --------> */
                                AppGaps.hGap22,

                                // Bottom extra spaces
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ));
  }
}
