import 'package:car2godriver/controller/schedule_ride_list_screen_controller.dart';
import 'package:car2godriver/models/api_responses/share_ride_history_response.dart';
import 'package:car2godriver/models/enums.dart';
import 'package:car2godriver/ui/screens/bottomsheet/view_schedule_ride_details_bottomsheet.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/double.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/screen_widget/location_widget.dart';
import 'package:car2godriver/ui/widgets/share_ride_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ScheduleRideListScreen extends StatelessWidget {
  const ScheduleRideListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<ScheduleRideListScreenController>(
        global: false,
        init: ScheduleRideListScreenController(),
        builder: (controller) => CustomScaffold(
            /* <-------- AppBar --------> */
            appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: true,
                titleText: AppLanguageTranslation
                    .scheduleRideListTransKey.toCurrentLanguage),
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
                      child: Row(
                        children: [
                          Expanded(
                              child: CustomTextFormField(
                                  hintText: 'Select city',
                                  prefixSpaceSize: 14,
                                  suffixSpaceSize: 0,
                                  suffixIcon: IconButtonWidget(
                                    onTap:
                                        controller.onSelectCityClearButtonTap,
                                    child: const Icon(Icons.close),
                                  ),
                                  prefixIcon: const SvgPictureAssetWidget(
                                      AppAssetImages.gpsSVGLogoLine),
                                  controller: controller.cityController,
                                  onTap: controller.onSelectCityTextFieldTap)),
                          const HorizontalGap(12),
                          Expanded(
                              child: CustomTextFormField(
                            isReadOnly: true,
                            hintText: 'Select date',
                            prefixIcon: const SvgPictureAssetWidget(
                                AppAssetImages.calendar),
                            controller: controller.dateController,
                            prefixSpaceSize: 10,
                            suffixSpaceSize: 0,
                            suffixIcon: IconButtonWidget(
                              onTap: controller.onSelectDateClearButtonTap,
                              child: const Icon(Icons.close),
                            ),
                            onTap: () =>
                                controller.onSelectDateTextFieldTap(context),
                          )),
                        ],
                      ),
                    ),
                    /* <-------- 15px height gap --------> */
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap24,
                    ),
                    if (controller.listLabel.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Text(
                          controller.listLabel,
                          style: AppTextStyles.bodyLargeMediumTextStyle
                              .copyWith(fontSize: 18),
                        ),
                      ),
                    SliverToBoxAdapter(
                        child: Text('Showing by location and date',
                            style: AppTextStyles.notificationSemiBoldDateSection
                                .copyWith(color: AppColors.primaryTextColor))),
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap12,
                    ),
                    SliverToBoxAdapter(
                      child: RawButtonWidget(
                        onTap: () {},
                        borderRadiusValue: 12,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppColors.gray200, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text.rich(
                                            style: AppTextStyles.bodyTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .primaryTextColor),
                                            const TextSpan(children: [
                                              TextSpan(text: '24 Apr 2024'),
                                              WidgetSpan(
                                                  child: HorizontalGap(5)),
                                              TextSpan(
                                                  text: 'At',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .bodyTextColor)),
                                              WidgetSpan(
                                                  child: HorizontalGap(5)),
                                              TextSpan(text: '10:30 am'),
                                            ]))),
                                    const HorizontalGap(5),
                                    Text(255.0.getCurrencyFormattedText(),
                                        style: AppTextStyles
                                            .bodySemiboldTextStyle
                                            .copyWith(
                                                color: AppColors.primaryColor)),
                                  ],
                                ),
                                const VerticalGap(12),
                                const Divider(color: AppColors.formBorderColor),
                                const VerticalGap(12),
                                LocationDetailsWidget(
                                  pickupLocation:
                                      controller.rideDetails.from.address,
                                  dropLocation:
                                      controller.rideDetails.to.address,
                                  distance: '1.1 Km',
                                ),
                                const VerticalGap(20),
                                Row(
                                  children: [
                                    Expanded(
                                        child:
                                            StretchedOutlinedTextButtonWidget(
                                      text: 'View Details',
                                      onTap: () {
                                        Get.bottomSheet(
                                            const StartRideBottomSheetScreen());
                                      },
                                    )),
                                    const HorizontalGap(12),
                                    Expanded(
                                        child: StretchedTextButtonWidget(
                                      buttonText: 'Accept',
                                      onTap: () {
                                        //Get.toNamed(AppPageNames.chatScreen);
                                      },
                                    )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
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
