import 'package:car2godriver/controller/trip_permit/trip_permit_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/double.dart';
import 'package:car2godriver/utils/extensions/int.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/screen_widget/trip_permit_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripPermitScreen extends StatelessWidget {
  const TripPermitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripPermitScreenController>(
        global: true,
        init: TripPermitScreenController(),
        builder: (controller) => CustomScaffold(
              extendBody: false,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleText: AppLanguageTranslation
                      .tripPermitTransKey.toCurrentLanguage,
                  actions: [
                    RawButtonWidget(
                      borderRadiusValue: 4,
                      onTap: () {
                        Get.toNamed(AppPageNames.tripPermitHistoryScreen,
                            arguments: controller.broughtSubscriptionList);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 21, vertical: 15),
                        height: 26,
                        width: 67,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: ShapeDecoration(
                          color: AppColors.zColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: const Center(
                          child: Text(
                            'My Plan',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: AppColors.appbarTittleColor,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                    //    if (controller.broughtSubscriptionList.isNotEmpty)
                    // RawButtonWidget(
                    //   borderRadiusValue: 4,
                    //   onTap: () {
                    //     Get.toNamed(AppPageNames.tripPermitHistoryScreen,
                    //         arguments: controller.broughtSubscriptionList);
                    //   },
                    //   child: Container(
                    //     margin: const EdgeInsets.symmetric(
                    //         horizontal: 8, vertical: 15),
                    //     height: 26,
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 8, vertical: 4),
                    //     decoration: ShapeDecoration(
                    //       color: Colors.white,
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(4)),
                    //     ),
                    //     child: const Center(
                    //       child: Text(
                    //         'History',
                    //         textAlign: TextAlign.right,
                    //         style: TextStyle(
                    //           color: AppColors.primaryColor,
                    //           fontSize: 12,
                    //           fontFamily: 'Poppins',
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ]),
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned.fill(
                      left: 0,
                      right: 0,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.55), BlendMode.darken),
                          child: Image.asset(
                            AppAssetImages.permitImage,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      )),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 350,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.5)
                                ])),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5)),
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Trip permit benefits',
                                  style: AppTextStyles
                                      .poppinsBodyMediumTextStyle
                                      .copyWith(
                                          color: Colors.white, fontSize: 24),
                                ),
                                const VerticalGap(16),
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxHeight: 110),
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      // shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final facility = controller
                                            .tripPermitListData
                                            .facilities[index];
                                        return TripPermitBenefitItemWidget(
                                          label: facility,
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const VerticalGap(12),
                                      itemCount: controller.tripPermitListData
                                          .facilities.length),
                                ),
                                // const Text('end', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                      bottom: 0,
                      left: -5,
                      right: -5,
                      child: Container(
                          // height: MediaQuery.of(context).size.height * 0.4,
                          height: 350,
                          decoration: const BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(40),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppGaps.screenPaddingValue),
                            child: RefreshIndicator(
                              onRefresh: () async =>
                                  controller.getPackageList(),
                              child: ListView.separated(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 30),
                                  itemBuilder: (context, index) {
                                    final pricingModel = controller
                                        .tripPermitListData
                                        .pricingModels[index];
                                    return TripPermitListWidget(
                                      title: 'Days',
                                      price: pricingModel.price,
                                      validityDays: pricingModel.durationInDay,
                                      isMyPlan: pricingModel.isSubscribed,
                                      isSelected:
                                          controller.selectedPricingModel.id ==
                                              pricingModel.id,
                                      onTap: () => controller
                                          .onPackageItemTap(pricingModel),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const VerticalGap(16),
                                  itemCount: controller
                                      .tripPermitListData.pricingModels.length),
                            ),
                          )))
                ],
              ),
              bottomNavigationBar: ScaffoldBottomBarWidget(
                backgroundColor: AppColors.backgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // CustomPoppinsStretchedTextButtonWidget(
                    //   isLoading: controller.isLoading,
                    //   onTap: controller.shouldEnableSubscribeNowButton
                    //       ? controller.onSubscribeNowButtonTap
                    //       : null,
                    //   buttonText: controller.subscribeNowButtonText,
                    //   textStyle: AppTextStyles.poppinsBodySemiboldTextStyle
                    //       .copyWith(fontSize: 16),
                    // ),
                    CustomPoppinsStretchedTextButtonWidget(
                      onTap: controller.shouldDisableSubscribeNowButton
                          ? null
                          : controller.onSubscribeNowButtonTap,
                      buttonText: controller.subscribeNowButtonText,
                      textStyle: AppTextStyles.poppinsBodySemiboldTextStyle
                          .copyWith(fontSize: 16),
                    )
                  ],
                ),
              ),
            ));
  }
}
