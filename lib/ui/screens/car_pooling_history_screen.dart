import 'package:car2godriver/controller/my_trip_screen_controller.dart';
import 'package:car2godriver/models/api_responses/share_ride_history_response.dart';
import 'package:car2godriver/models/enums.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/Tab_list_screen_widget.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/share_ride_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CarPollingHistoryScreen extends StatelessWidget {
  const CarPollingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<MyTripScreenController>(
        global: false,
        init: MyTripScreenController(),
        builder: (controller) => CustomScaffold(
            /* <-------- AppBar --------> */
            appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: true,
                titleText: AppLanguageTranslation
                    .carPoolingHistoryTransKey.toCurrentLanguage),
            /* <-------- Body Content --------> */
            body: RefreshIndicator(
              onRefresh: () async =>
                  controller.shareRideHistoryPagingController.refresh(),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                child: CustomScrollView(
                  slivers: [
                    /* <-------- 15px height gap --------> */
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap15,
                    ),
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            /* <-------- 10px width gap --------> */
                            AppGaps.wGap10,
                            TabStatusWidget(
                              text: ShareRideHistoryStatus
                                  .accepted.stringValueForView,
                              isSelected: controller.shareRideTypeTab.value ==
                                  ShareRideHistoryStatus.accepted,
                              onTap: () {
                                controller.onShareRideTabTap(
                                    ShareRideHistoryStatus.accepted);
                              },
                            ),
                            /* <-------- 10px width gap --------> */
                            AppGaps.wGap10,
                            TabStatusWidget(
                              text: ShareRideHistoryStatus
                                  .started.stringValueForView,
                              isSelected: controller.shareRideTypeTab.value ==
                                  ShareRideHistoryStatus.started,
                              onTap: () {
                                controller.onShareRideTabTap(
                                    ShareRideHistoryStatus.started);
                              },
                            ),
                            /* <-------- 10px width gap --------> */
                            AppGaps.wGap10,
                            TabStatusWidget(
                              text: ShareRideHistoryStatus
                                  .completed.stringValueForView,
                              isSelected: controller.shareRideTypeTab.value ==
                                  ShareRideHistoryStatus.completed,
                              onTap: () {
                                controller.onShareRideTabTap(
                                    ShareRideHistoryStatus.completed);
                              },
                            ),
                            /* <-------- 10px width gap --------> */
                            AppGaps.wGap10,
                            TabStatusWidget(
                              text: ShareRideHistoryStatus
                                  .cancelled.stringValueForView,
                              isSelected: controller.shareRideTypeTab.value ==
                                  ShareRideHistoryStatus.cancelled,
                              onTap: () {
                                controller.onShareRideTabTap(
                                    ShareRideHistoryStatus.cancelled);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    /* <-------- 15px height gap --------> */
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap15,
                    ),
                    PagedSliverList.separated(
                        pagingController:
                            controller.shareRideHistoryPagingController,
                        builderDelegate:
                            PagedChildBuilderDelegate<ShareRideHistoryDoc>(
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
                          /* <-------- Share ride item list --------> */
                          return ShareRideListItemWidget(
                              onTap: () =>
                                  controller.onShareRideItemTap(id, item, type),
                              onRequestButtonTap: controller
                                              .selectedActionForRideShare
                                              .value ==
                                          ShareRideActions.myOffer &&
                                      item.pending > 0
                                  ? () async {
                                      await controller.onRequestButtonTap(id);
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
                              showPending: controller.shareRideTypeTab.value ==
                                  ShareRideHistoryStatus.accepted,
                              pending: pending);
                        }),
                        separatorBuilder: (context, index) => AppGaps.hGap16),
                  ],
                ),
              ),
            )));
  }
}
