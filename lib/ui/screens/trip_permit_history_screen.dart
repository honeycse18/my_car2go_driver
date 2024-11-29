import 'package:car2godriver/controller/trip_permit/trip_permit_history_controller.dart';
import 'package:car2godriver/models/api_responses/my_trip_permit_details.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/datetime.dart';
import 'package:car2godriver/utils/extensions/double.dart';
import 'package:car2godriver/utils/extensions/string.dart';

import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/screen_widget/trip_permit_history_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TripPermitHistoryScreen extends StatelessWidget {
  const TripPermitHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripHistoryScreenController>(
      global: true,
      init: TripHistoryScreenController(),
      builder: (controller) => CustomScaffold(
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleText: 'Trip Permit',
          hasBackButton: true,
        ),
        body: ScaffoldBodyWidget(
            child: RefreshIndicator(
          onRefresh: () async {
            controller.myTransactionsPagingController.refresh();
            await controller.getMyTripPermitDetails();
          },
          child: CustomScrollView(slivers: [
            const SliverToBoxAdapter(child: AppGaps.hGap24),
            const SliverToBoxAdapter(
              child: Text(
                'My Trip Permit',
                style: TextStyle(
                  color: Color(0xFF0B204C),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: AppGaps.hGap16),
            SliverToBoxAdapter(
              child: TripPermitHistoryWidget(
                amount: controller
                    .myTripPermitDetails.subscribed.pricingModels.price,
                durationInDays: controller
                    .myTripPermitDetails.subscribed.pricingModels.durationInDay,
                expireDateTime:
                    controller.myTripPermitDetails.subscribed.expireDate,
                id: controller.myTripPermitDetails.subscribed.id,
                isAutoRenewActive:
                    controller.myTripPermitDetails.subscribed.autoRenewal,
                onViewDetailsTap: controller.onMyTripPermitViewDetailsTap,
              ),
            ),

            const SliverToBoxAdapter(child: AppGaps.hGap40),
            const SliverToBoxAdapter(
              child: Text(
                'Transaction history',
                style: TextStyle(
                  color: Color(0xFF0B204C),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: AppGaps.hGap16),

            PagedSliverList.separated(
              pagingController: controller.myTransactionsPagingController,
              builderDelegate:
                  PagedChildBuilderDelegate<MyTripPermitTransaction>(
                      noItemsFoundIndicatorBuilder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EmptyScreenWidget(
                        localImageAssetURL: AppAssetImages.confirmIconImage,
                        title: AppLanguageTranslation
                            .youHaveNoTransactionHistoryTransKey
                            .toCurrentLanguage,
                        shortTitle: '')
                  ],
                );
              }, itemBuilder: (context, item, index) {
                return Container(
                  height: 94,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: AppColors.formBorderColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${item.subscriptionOrder.pricingModels.durationInDay} Days',
                              style: TextStyle(
                                color: Color(0xFF0B204C),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Payment: ',
                                  style: TextStyle(
                                    color: AppColors.bodyTextColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'paid',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Payment Date: ',
                                  style: TextStyle(
                                    color: AppColors.bodyTextColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '${item.createdAt.formatted('dd MMM yyyy')}',
                                  style: TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        RawButtonWidget(
                          onTap: () =>
                              controller.onTransactionViewDetailsTap(item),
                          child: const Text(
                            'View Details',
                            style: TextStyle(
                              color: Color(0xFF1D272F),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              separatorBuilder: (context, index) => const VerticalGap(12),
            ),
            /*           SliverList.separated(
              itemBuilder: (context, index) {
                final item = index;
                return Container(
                  height: 94,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: AppColors.formBorderColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${controller.selectedPackage.duration}',
                              style: TextStyle(
                                color: Color(0xFF0B204C),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Payment: ',
                                  style: TextStyle(
                                    color: AppColors.bodyTextColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'paid',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Payment Date: ',
                                  style: TextStyle(
                                    color: AppColors.bodyTextColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '${DateTime.now().formatted('dd MMM yyyy')}',
                                  style: TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        RawButtonWidget(
                          onTap: () {
                            Get.toNamed(AppPageNames
                                .tripPermitTransactionHistoryDetailsScreen);
                          },
                          child: const Text(
                            'View Details',
                            style: TextStyle(
                              color: Color(0xFF1D272F),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const VerticalGap(12),
              itemCount: 3,
                        ), */
            const SliverToBoxAdapter(
              child: VerticalGap(30),
            ),
            // Expanded(
            //     child: ListView.separated(
            //         physics: const BouncingScrollPhysics(),
            //         itemBuilder: (context, index) {
            //           final item =
            //               controller.broughtSubscriptionList[index];
            //           return TripPermitHistoryWidget(item: item);
            //         },
            //         separatorBuilder: (context, index) =>
            //             AppGaps.hGap16,
            //         itemCount:
            //             controller.broughtSubscriptionList.length))
          ]),
        )),
      ),
    );
  }
}
