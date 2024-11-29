import 'package:car2godriver/controller/history_screen_controller.dart';
import 'package:car2godriver/models/api_responses/ride_history_response.dart';
import 'package:car2godriver/models/enums.dart';
import 'package:car2godriver/ui/screens/bottomsheet/recieve_ride_bottomsheet.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/Tab_list_screen_widget.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/history_screen_widgets.dart';
import 'package:car2godriver/ui/widgets/ride_history_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RideHistoryScreen extends StatelessWidget {
  const RideHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<RideHistoryListScreenController>(
        global: false,
        init: RideHistoryListScreenController(),
        builder: (controller) => ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: ScaffoldBodyWidget(
              child: RefreshIndicator(
                onRefresh: () async => controller.selectedStatus.value ==
                        RideHistoryStatusEnum.pending
                    ? controller.getPendingRideRequestResponse()
                    : controller.rideHistoryPagingController.refresh(),
                /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
                child: CustomScrollView(
                  slivers: [
                    /* <-------- 28px height gap --------> */
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap28,
                    ),
                    SliverToBoxAdapter(
                        child: DecoratedBox(
                      decoration: const BoxDecoration(
                          color: AppColors.myRideTabColor,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // TabStatusWidget(
                            //   text: RideHistoryStatusEnum
                            //       .pending.stringValueForView,
                            //   isSelected: controller.selectedStatus.value ==
                            //       RideHistoryStatusEnum.pending,
                            //   onTap: () {
                            //     controller.onPendingRideTabTap(
                            //         RideHistoryStatusEnum.pending);
                            //   },
                            // ),
                            TabStatusWidget(
                              text: RideHistoryStatusEnum
                                  .upcoming.stringValueForView,
                              isSelected: controller.selectedStatus.value ==
                                  RideHistoryStatusEnum.upcoming,
                              onTap: () {
                                controller.onRideTabTap(
                                    RideHistoryStatusEnum.upcoming);
                              },
                            ),
                            /* <-------- 10px width gap --------> */
                            // AppGaps.wGap10,
                            // TabStatusWidget(
                            //   text: RideHistoryStatusEnum
                            //       .started.stringValueForView,
                            //   isSelected: controller.selectedStatus.value ==
                            //       RideHistoryStatusEnum.started,
                            //   onTap: () {
                            //     controller.onRideTabTap(
                            //         RideHistoryStatusEnum.started);
                            //   },
                            // ),
                            /* <-------- 10px width gap --------> */
                            AppGaps.wGap10,
                            TabStatusWidget(
                              text: RideHistoryStatusEnum
                                  .complete.stringValueForView,
                              isSelected: controller.selectedStatus.value ==
                                  RideHistoryStatusEnum.complete,
                              onTap: () {
                                controller.onRideTabTap(
                                    RideHistoryStatusEnum.complete);
                              },
                            ),
                            /* <-------- 10px width gap --------> */
                            AppGaps.wGap10,
                            TabStatusWidget(
                              text: RideHistoryStatusEnum
                                  .cancelled.stringValueForView,
                              isSelected: controller.selectedStatus.value ==
                                  RideHistoryStatusEnum.cancelled,
                              onTap: () {
                                controller.onRideTabTap(
                                    RideHistoryStatusEnum.cancelled);
                              },
                            ),
                          ],
                        ),
                      ),
                    )),
                    const SliverToBoxAdapter(child: AppGaps.hGap28),
                    Obx(() {
                      switch (controller.selectedStatus.value) {
                        //pending ride list view
                        case RideHistoryStatusEnum.pending:
                          return controller.pendingRideList.isEmpty
                              ? SliverToBoxAdapter(
                                  child: Center(
                                    child: EmptyScreenWidget(
                                        localImageAssetURL:
                                            AppAssetImages.dropMarkerPngIcon,
                                        title: AppLanguageTranslation
                                            .youHaveNoPendingRequestsTranskey
                                            .toCurrentLanguage,
                                        shortTitle: ''),
                                  ),
                                )
                              : SliverList.separated(
                                  itemBuilder: (context, index) {
                                    final rentListHistory =
                                        controller.pendingRideList[index];
                                    return HistoryListScreenWidget(
                                      onAcceptTap: () {
                                        controller.acceptRejectRideRequest(
                                            rentListHistory.id,
                                            RideStatus.accepted);
                                      },
                                      onRejectTap: () =>
                                          controller.acceptRejectRideRequest(
                                              rentListHistory.id,
                                              RideStatus.rejected),
                                      onTap: () {
                                        Get.bottomSheet(
                                            const ReceiveRideBottomSheetScreen(),
                                            settings: RouteSettings(
                                                arguments: rentListHistory),
                                            isScrollControlled: true);
                                      },
                                      amount: rentListHistory.total,
                                      userImage: rentListHistory.user.image,
                                      userName: rentListHistory.user.name,
                                      dropLocation: rentListHistory.to.address,
                                      pickLocation:
                                          rentListHistory.from.address,
                                      rating: 3,
                                      distance: rentListHistory.distance.text,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      AppGaps.hGap16,
                                  itemCount: controller.pendingRideList.length,
                                );

                        case RideHistoryStatusEnum.upcoming:
                          return PagedSliverList.separated(
                            pagingController:
                                controller.rideHistoryPagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<RideHistoryDoc>(
                                    noItemsFoundIndicatorBuilder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  EmptyScreenWidget(
                                    height: 110,
                                    isSVGImage: true,
                                    localImageAssetURL:
                                        AppAssetImages.dropMarkerPngIcon,
                                    title: AppLanguageTranslation
                                        .youHaveNoUpcomingRequestsTranskey
                                        .toCurrentLanguage,
                                  ),
                                ],
                              );
                            }, itemBuilder: (context, item, index) {
                              final RideHistoryDoc rideHistory = item;
                              final previousDate =
                                  controller.previousDate(index, item);
                              final bool isDateChanges =
                                  controller.isDateChanges(item, previousDate);
                              //Ride History List view widget
                              return RideHistoryListItemWidget(
                                distance: rideHistory.distance.text,
                                rate: rideHistory.total,
                                currency: rideHistory.currency.symbol,
                                carName: rideHistory.ride.name,
                                carModel: rideHistory.ride.model,
                                isDateChanged: isDateChanges,
                                userName: rideHistory.driver.name,
                                showCallChat: rideHistory.status ==
                                    RideHistoryStatusEnum.upcoming.stringValue,
                                onSendTap: () {
                                  Get.toNamed(AppPageNames.chatScreen,
                                      arguments: rideHistory.driver.id);
                                },
                                pickupLocation: rideHistory.from.address,
                                dropLocation: rideHistory.to.address,
                                onTap: () => controller.onRideWidgetTap(item),
                                date: rideHistory.date,
                                driverImage: rideHistory.driver.image,
                                time: rideHistory.date,
                                /* dateTime: rideHistoryListItem.date,
                                dropLocation: rideHistoryListItem.to.address,
                                pickupLocation:
                                    rideHistoryListItem.from.address,
                                userImage: rideHistoryListItem.user.image,
                                userName: rideHistoryListItem.user.name,
                                onTap: () {
                                  Get.toNamed(
                                      AppPageNames.startRideRequestScreen,
                                      arguments: rideHistoryListItem);
                                },
                                onSendTap: () {
                                  Get.toNamed(AppPageNames.chatScreen,
                                              arguments:
                                                  rideHistoryListItem.user.id);
                                }, */
                              );
                            }),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                          );

                        case RideHistoryStatusEnum.started:
                          return PagedSliverList.separated(
                            pagingController:
                                controller.rideHistoryPagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<RideHistoryDoc>(
                                    noItemsFoundIndicatorBuilder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  EmptyScreenWidget(
                                    height: 110,
                                    isSVGImage: true,
                                    localImageAssetURL:
                                        AppAssetImages.dropMarkerPngIcon,
                                    title: AppLanguageTranslation
                                        .youHaveNoUpcomingRequestsTranskey
                                        .toCurrentLanguage,
                                  ),
                                ],
                              );
                            }, itemBuilder: (context, item, index) {
                              final RideHistoryDoc rideHistory = item;
                              final previousDate =
                                  controller.previousDate(index, item);
                              final bool isDateChanges =
                                  controller.isDateChanges(item, previousDate);

                              return RideHistoryListItemWidget(
                                distance: rideHistory.distance.text,
                                rate: rideHistory.total,
                                currency: rideHistory.currency.symbol,
                                carName: rideHistory.ride.name,
                                carModel: rideHistory.ride.model,
                                isDateChanged: isDateChanges,
                                userName: rideHistory.driver.name,
                                showCallChat: rideHistory.status ==
                                    RideHistoryStatusEnum.upcoming.stringValue,
                                onSendTap: () {
                                  Get.toNamed(AppPageNames.chatScreen,
                                      arguments: rideHistory.driver.id);
                                },
                                pickupLocation: rideHistory.from.address,
                                dropLocation: rideHistory.to.address,
                                onTap: () => controller.onRideWidgetTap(item),
                                date: rideHistory.date,
                                driverImage: rideHistory.driver.image,
                                time: rideHistory.date,
                                /* dateTime: rideHistoryListItem.date,
                                dropLocation: rideHistoryListItem.to.address,
                                pickupLocation:
                                    rideHistoryListItem.from.address,
                                userImage: rideHistoryListItem.user.image,
                                userName: rideHistoryListItem.user.name,
                                onTap: () {
                                  Get.toNamed(
                                      AppPageNames.startRideRequestScreen,
                                      arguments: rideHistoryListItem);
                                },
                                onSendTap: () {
                                  /* Get.toNamed(AppPageNames.chatScreen,
                                              arguments:
                                                  rideHistoryListItem.user.id); */
                                }, */
                              );
                            }),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                          );

                        case RideHistoryStatusEnum.complete:
                          return PagedSliverList.separated(
                            pagingController:
                                controller.rideHistoryPagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<RideHistoryDoc>(
                                    noItemsFoundIndicatorBuilder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  EmptyScreenWidget(
                                    height: 110,
                                    isSVGImage: true,
                                    localImageAssetURL:
                                        AppAssetImages.dropMarkerPngIcon,
                                    title: AppLanguageTranslation
                                        .youHaveNoUpcomingRequestsTranskey
                                        .toCurrentLanguage,
                                  ),
                                ],
                              );
                            }, itemBuilder: (context, item, index) {
                              final RideHistoryDoc rideHistory = item;
                              final previousDate =
                                  controller.previousDate(index, item);
                              final bool isDateChanges =
                                  controller.isDateChanges(item, previousDate);

                              return RideHistoryListItemWidget(
                                distance: rideHistory.distance.text,
                                rate: rideHistory.total,
                                currency: rideHistory.currency.symbol,
                                carName: rideHistory.ride.name,
                                carModel: rideHistory.ride.model,
                                isDateChanged: isDateChanges,
                                userName: rideHistory.user.name,
                                showCallChat: rideHistory.status ==
                                    RideHistoryStatusEnum.upcoming.stringValue,
                                onSendTap: () {
                                  Get.toNamed(AppPageNames.chatScreen,
                                      arguments: rideHistory.driver.id);
                                },
                                pickupLocation: rideHistory.from.address,
                                dropLocation: rideHistory.to.address,
                                onTap: () => controller.onRideWidgetTap(item),
                                date: rideHistory.date,
                                driverImage: rideHistory.user.image,
                                time: rideHistory.date,
                                /* dateTime: rideHistoryListItem.date,
                                dropLocation: rideHistoryListItem.to.address,
                                pickupLocation:
                                    rideHistoryListItem.from.address,
                                userImage: rideHistoryListItem.user.image,
                                userName: rideHistoryListItem.user.name,
                                onTap: () {
                                  Get.toNamed(
                                      AppPageNames.startRideRequestScreen,
                                      arguments: rideHistoryListItem);
                                },
                                onSendTap: () {
                                  /* Get.toNamed(AppPageNames.chatScreen,
                                              arguments:
                                                  rideHistoryListItem.user.id); */
                                }, */
                              );
                            }),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                          );
                        case RideHistoryStatusEnum.cancelled:
                          return PagedSliverList.separated(
                            pagingController:
                                controller.rideHistoryPagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<RideHistoryDoc>(
                                    noItemsFoundIndicatorBuilder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  EmptyScreenWidget(
                                    height: 110,
                                    isSVGImage: true,
                                    localImageAssetURL:
                                        AppAssetImages.dropMarkerPngIcon,
                                    title: AppLanguageTranslation
                                        .youHaveNoUpcomingRequestsTranskey
                                        .toCurrentLanguage,
                                  ),
                                ],
                              );
                            }, itemBuilder: (context, item, index) {
                              final RideHistoryDoc rideHistory = item;
                              final previousDate =
                                  controller.previousDate(index, item);
                              final bool isDateChanges =
                                  controller.isDateChanges(item, previousDate);

                              return RideHistoryListItemWidget(
                                distance: rideHistory.distance.text,
                                rate: rideHistory.total,
                                currency: rideHistory.currency.symbol,
                                carName: rideHistory.ride.name,
                                carModel: rideHistory.ride.model,
                                isDateChanged: isDateChanges,
                                userName: rideHistory.driver.name,
                                showCallChat: rideHistory.status ==
                                    RideHistoryStatusEnum.upcoming.stringValue,
                                onSendTap: () {
                                  Get.toNamed(AppPageNames.chatScreen,
                                      arguments: rideHistory.driver.id);
                                },
                                pickupLocation: rideHistory.from.address,
                                dropLocation: rideHistory.to.address,
                                onTap: () => controller.onRideWidgetTap(item),
                                date: rideHistory.date,
                                driverImage: rideHistory.driver.image,
                                time: rideHistory.date,
                                /* dateTime: rideHistoryListItem.date,
                                dropLocation: rideHistoryListItem.to.address,
                                pickupLocation:
                                    rideHistoryListItem.from.address,
                                userImage: rideHistoryListItem.user.image,
                                userName: rideHistoryListItem.user.name,
                                onTap: () {
                                  Get.toNamed(
                                      AppPageNames.startRideRequestScreen,
                                      arguments: rideHistoryListItem);
                                },
                                onSendTap: () {
                                  /* Get.toNamed(AppPageNames.chatScreen,
                                              arguments:
                                                  rideHistoryListItem.user.id); */
                                }, */
                              );
                            }),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                          );
                      }
                    }),
                    /* <-------- 100px height gap --------> */
                    const SliverToBoxAdapter(child: AppGaps.hGap100),
                  ],
                ),
              ),
            )));
  }
}
