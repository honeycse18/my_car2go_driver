import 'package:car2godriver/controller/MyVehicleInformationScreenController.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/screen_widget/settings_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//Vehicle Main Screen
//##################################################################

class MyVehicleInformationScreen extends StatelessWidget {
  const MyVehicleInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<MyVehicleInformationScreenController>(
        init: MyVehicleInformationScreenController(),
        global: false,
        builder: (controller) => CustomScaffold(
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText: controller.vehicleDetailsItem.vehicleNumber,
                  actions: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.formInnerColor,
                      ),
                      child: TextButton(
                          onPressed: controller.onEditButtonTap,
                          child: Text(
                            AppLanguageTranslation
                                .editTranskey.toCurrentLanguage,
                            style: AppTextStyles.bodySmallSemiboldTextStyle
                                .copyWith(decoration: TextDecoration.underline),
                          )),
                    )
                  ],
                  hasBackButton: true),
              /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
              body: ScaffoldBodyWidget(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* <-------- 30px height gap --------> */
                  AppGaps.hGap30,
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /* <-------- 15px height gap --------> */
                          AppGaps.hGap15,
                          Text(
                            controller.vehicleDetailsItem.name,
                            style: AppTextStyles.titleSemiSmallBoldTextStyle
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            controller.vehicleDetailsItem.category.name,
                            style: AppTextStyles.bodyLargeMediumTextStyle
                                .copyWith(color: AppColors.bodyTextColor),
                          ),
                          /* <-------- 18px height gap --------> */
                          AppGaps.hGap18,
                          SizedBox(
                            height: 180,
                            child: Stack(
                              alignment: AlignmentDirectional.topCenter,
                              children: [
                                Container(
                                  height: 160,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: PageView.builder(
                                          controller:
                                              controller.imageController,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: controller
                                              .vehicleDetailsItem.images.length,
                                          itemBuilder: (context, index) {
                                            final images = controller
                                                .vehicleDetailsItem
                                                .images[index];
                                            return CachedNetworkImageWidget(
                                              imageURL: images,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius: AppComponents
                                                        .imageBorderRadius,
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover)),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: SmoothPageIndicator(
                                    controller: controller.imageController,
                                    count: controller
                                            .vehicleDetailsItem.images.isEmpty
                                        ? 1
                                        : controller
                                            .vehicleDetailsItem.images.length,
                                    axisDirection: Axis.horizontal,
                                    effect: ExpandingDotsEffect(
                                        dotHeight: 8,
                                        dotWidth: 8,
                                        spacing: 2,
                                        expansionFactor: 3,
                                        activeDotColor: AppColors.primaryColor,
                                        dotColor: AppColors.primaryColor
                                            .withOpacity(0.3)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          /* <-------- 32px height gap --------> */
                          AppGaps.hGap32,
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonListTileWidget(
                                titleText: '',
                                onTap: () {
                                  Get.toNamed(
                                      AppPageNames
                                          .vehicleDetailsInformationScreen,
                                      arguments: controller.vehicleDetailsItem);
                                },
                                settingsValueTextWidget: Text(
                                  AppLanguageTranslation
                                      .documentTranskey.toCurrentLanguage,
                                  style: AppTextStyles.bodyLargeTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              /* <-------- 24px height gap --------> */
                              AppGaps.hGap24,
                              CommonListTileWidget(
                                showRightArrow: false,
                                titleText: '',
                                onTap: () {
                                  Get.toNamed(AppPageNames.vehicleDetailsScreen,
                                      arguments: controller.vehicleDetailsItem);
                                },
                                settingsValueTextWidget: Text(
                                  AppLanguageTranslation
                                      .informationTranskey.toCurrentLanguage,
                                  style: AppTextStyles.bodyLargeTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              /* <-------- 16px height gap --------> */
                              AppGaps.hGap16,
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  AppLanguageTranslation
                                      .removeThisVehicleTransKey
                                      .toCurrentLanguage,
                                  style: AppTextStyles
                                      .bodyLargeSemiboldTextStyle
                                      .copyWith(color: AppColors.errorColor),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ));
  }
}

// class MyVehicleInformationScreen extends StatelessWidget {
//   const MyVehicleInformationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<MyVehicleInformationScreenController>(
//         init: MyVehicleInformationScreenController(),
//         global: false,
//         builder: (controller) => CustomScaffold(
//             appBar: CoreWidgets.appBarWidget(
//                 screenContext: context,
//                 titleText:
//                     AppLanguageTranslation.myVehicleTransKey.toCurrentLanguage,
//                 hasBackButton: true),
//             body: ScaffoldBodyWidget(
//                 child: Padding(
//               padding: const EdgeInsets.only(left: 5, top: 25),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                         child: SingleChildScrollView(
//                             child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                           Text(
//                             AppLanguageTranslation
//                                 .mustangShelbyGtTranskey.toCurrentLanguage,
//                             style: AppTextStyles.titleSemiSmallBoldTextStyle,
//                           ),
//                           Text(
//                             AppLanguageTranslation
//                                 .airConditionCarTranskey.toCurrentLanguage,
//                             style: AppTextStyles.bodyLargeMediumTextStyle
//                                 .copyWith(color: AppColors.bodyTextColor),
//                           ),
//                           Center(
//                             child: Image.asset(AppAssetImages.carImage,
//                                 height: 154, width: 287),
//                           ),
//                           SettingsListTileWidget(
//                             titleText: AppLanguageTranslation
//                                 .documentTranskey.toCurrentLanguage,
//                             onTap: () {
//                               Get.toNamed(
//                                   AppPageNames.changePasswordPromptScreen);
//                             },
//                             settingsValueTextWidget: Text(''),
//                           ),
//                           AppGaps.hGap20,
//                           SettingsListTileWidget(
//                             titleText: AppLanguageTranslation
//                                 .informationTranskey.toCurrentLanguage,
//                             onTap: () {
//                               Get.toNamed(
//                                   AppPageNames.changePasswordPromptScreen);
//                             },
//                             settingsValueTextWidget: Text(''),
//                           ),
//                           AppGaps.hGap20,
//                           InkWell(
//                             onTap: () {},
//                             child: Text(
//                               AppLanguageTranslation
//                                   .removeThisVehicleTransKey.toCurrentLanguage,
//                               style: AppTextStyles.bodyBoldTextStyle
//                                   .copyWith(color: Colors.red),
//                             ),
//                           )
//                         ])))
//                   ]),
//             ))));
//   }
// }
