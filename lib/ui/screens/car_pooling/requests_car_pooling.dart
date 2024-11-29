import 'package:car2godriver/controller/car_polling/car_pulling_screen_controller.dart';
import 'package:car2godriver/models/api_responses/share_ride_history_response.dart';
import 'package:car2godriver/models/enums.dart';

import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/share_ride_list_item_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RequestCarPullingScreen extends StatelessWidget {
  const RequestCarPullingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<RequestCarPullingScreenController>(
        init: RequestCarPullingScreenController(),
        global: false,
        builder: ((controller) => ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  color: Colors.white,
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        controller.shareRideHistoryPagingController.refresh(),
                    /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
                    child: ScaffoldBodyWidget(
                      child: CustomScrollView(
                        slivers: [
                          const SliverToBoxAdapter(
                            /* <-------- 10px height gap --------> */
                            child: AppGaps.hGap10,
                          ),
                          SliverToBoxAdapter(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color:
                                      AppColors.bodyTextColor.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(18))),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SizedBox(
                                        height: 48,
                                        child: Obx(() =>
                                            /* <---- Car polling offering tab button ----> */
                                            CustomTabToggleButtonWidget(
                                                text: AppLanguageTranslation
                                                    .offeringTranskey
                                                    .toCurrentLanguage,
                                                isSelected: !controller
                                                    .isOfferRideTabSelected
                                                    .value,
                                                onTap: () {
                                                  controller
                                                      .isOfferRideTabSelected
                                                      .value = false;
                                                  controller.onShareRideTabTap(
                                                      ShareRideRequestsStatus
                                                          .offering);
                                                })),
                                      ),
                                    ),
                                  ),
                                  /* <-------- 5px width gap --------> */
                                  AppGaps.wGap5,
                                  /* <---- Car polling finding tab button ----> */

                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SizedBox(
                                        height: 48,
                                        child: Obx(() =>
                                            CustomTabToggleButtonWidget(
                                                text: AppLanguageTranslation
                                                    .findingTranskey
                                                    .toCurrentLanguage,
                                                isSelected: controller
                                                    .isOfferRideTabSelected
                                                    .value,
                                                onTap: () {
                                                  controller
                                                      .isOfferRideTabSelected
                                                      .value = true;
                                                  controller.onShareRideTabTap(
                                                      ShareRideRequestsStatus
                                                          .findRide);
                                                })),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            /* <-------- 18px height gap --------> */
                            child: AppGaps.hGap18,
                          ),
                          PagedSliverList.separated(
                              pagingController:
                                  controller.shareRideHistoryPagingController,
                              builderDelegate: PagedChildBuilderDelegate<
                                      ShareRideHistoryDoc>(
                                  itemBuilder: (context, item, index) {
                                ShareRideHistoryUser user = item.user;
                                ShareRideHistoryFrom from = item.from;
                                ShareRideHistoryTo to = item.to;
                                DateTime date = item.date;
                                String status =
                                    ShareRideAllStatus.toEnumValue(item.status)
                                        .stringValueForView;
                                String id = item.id;
                                int pending = item.pending;
                                String type = item.type;
                                if (item.offer.id.isNotEmpty) {
                                  // id = item.offer.id;
                                  user = item.offer.user;
                                  from = item.offer.from;
                                  to = item.offer.to;
                                  type = item.offer.type;
                                  date = item.offer.date;
                                }
                                return ShareRideListItemWidget(
                                    onTap: () => controller.onShareRideItemTap(
                                        id, item, type),
                                    onRequestButtonTap: controller
                                                    .selectedActionForRideShare
                                                    .value ==
                                                ShareRideActions.myOffer &&
                                            item.pending > 0
                                        ? () async {
                                            await controller
                                                .onRequestButtonTap(id);
                                            controller
                                                .shareRideHistoryPagingController
                                                .refresh();
                                          }
                                        : null,
                                    image: user.image,
                                    type: type,
                                    seats: item.seats,
                                    available: item.available,
                                    pickupLocation: from.address,
                                    dropLocation: to.address,
                                    time: date,
                                    date: date,
                                    status: status,
                                    showPending:
                                        controller.shareRideTypeTab.value ==
                                            ShareRideRequestsStatus.offering,
                                    pending: pending);
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16),
                          const SliverToBoxAdapter(
                            /* <-------- 100px height gap --------> */
                            child: AppGaps.hGap100,
                          ),
                        ],
                      ),
                    ),
                  )),
            )));
  }
}
