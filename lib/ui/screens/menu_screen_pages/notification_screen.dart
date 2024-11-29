import 'package:car2godriver/controller/notification_screen_controllar.dart';
import 'package:car2godriver/models/api_responses/notification_list_response.dart';
import 'package:car2godriver/models/enums/notification_type.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/notifications_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<NotificationScreenController>(
      init: NotificationScreenController(),
      global: false,
      builder: (controller) => CustomScaffold(
        /* <-------- AppBar --------> */
        backgroundColor: AppColors.backgroundColor,
        appBar: CoreWidgets.appBarWidget(
            screenContext: context,
            titleText:
                AppLanguageTranslation.notificationTransKey.toCurrentLanguage,
            hasBackButton: true,
            actions: [
              Column(
                children: [
                  AppGaps.hGap10,
                  GestureDetector(
                    onTap: () {
                      controller.toggleSwitch();
                      controller.update();
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: 24,
                      width: 39,
                      padding: EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: controller.isEnabled.value
                            ? Colors.white
                            : Colors.grey,
                      ),
                      child: Align(
                        alignment: controller.isEnabled.value
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.isEnabled.value
                                ? AppColors.primaryColor
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AppGaps.wGap10,
            ]),

        /* <-------- Body Content --------> */
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 24,
            ),
            child: RefreshIndicator(
                onRefresh: () async =>
                    controller.userNotificationPagingController.refresh(),
                /* <-------- Notification List view --------> */

                child: /* SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    NotificationWidget(
                      onTap: () {},
                      // action: notification.action,
                      // tittle: notification.title,
                      // description: notification.message,
                      // dateTime: notification.createdAt,
                      // isDateChanged: isNotificationDateChanges,
                      // notificationType: notification.action,
                      // isRead: notification.read,
                      // onTap: () {
                      //   controller.readNotification(notification.id);
                      //   controller.userNotificationPagingController.refresh();
                      // },
                    ),
                    AppGaps.hGap10,
                    NotificationWidget(
                      onTap: () {},

                      // action: notification.action,
                      // tittle: notification.title,
                      // description: notification.message,
                      // dateTime: notification.createdAt,
                      // isDateChanged: isNotificationDateChanges,
                      // notificationType: notification.action,
                      // isRead: notification.read,
                      // onTap: () {
                      //   controller.readNotification(notification.id);
                      //   controller.userNotificationPagingController.refresh();
                      // },
                    ),
                  ],
                ),
              ), */
                    CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(child: VerticalGap(10)),
                    SliverToBoxAdapter(
                      child: Text(
                        'Today',
                        style: AppTextStyles.notificationDateSection,
                      ),
                    ),
                    const SliverToBoxAdapter(child: VerticalGap(12)),
                    SliverList.separated(
                      itemBuilder: (context, index) {
                        final item = index;
                        return NotificationItemWidget(
                          durationText: '2 hours ago',
                          title: 'QR code online payment confirm',
                          subtitle: 'Lorem ipsum',
                          notificationType: NotificationType.confirmed,
                          onTap: () {},
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const VerticalGap(16),
                      itemCount: 3,
                    ),
                    const SliverToBoxAdapter(child: VerticalGap(40)),
                    SliverToBoxAdapter(
                      child: Text(
                        'Today',
                        style: AppTextStyles.notificationDateSection,
                      ),
                    ),
                    const SliverToBoxAdapter(child: VerticalGap(12)),
                    SliverList.separated(
                      itemBuilder: (context, index) {
                        final item = index;
                        return NotificationItemWidget(
                          durationText: '2 hours ago',
                          title: 'QR code online payment confirm',
                          subtitle: 'Lorem ipsum',
                          notificationType: NotificationType.confirmed,
                          onTap: () {},
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const VerticalGap(16),
                      itemCount: 3,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class NotificationItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String durationText;

  final void Function()? onTap;
  final NotificationType notificationType;
  const NotificationItemWidget(
      {super.key,
      this.onTap,
      required this.notificationType,
      required this.title,
      required this.subtitle,
      required this.durationText});

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
        // colorCng: isRead ? false : true,
        // isShadow: isRead ? false : true,
        onTap: onTap,
        borderRadiusValue: 12,
        elevation: 12,
        shadowColor: Colors.black.withOpacity(0.2),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              // height: 40,
              // width: 40,
              decoration: BoxDecoration(
                  color: AppColors.appbarTittleColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Stack(
                children: [
                  SizedBox.square(dimension: 36, child: imageWidget),
                  // Positioned(
                  //   right: 0,
                  //   top: -5,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(top: 5),
                  //     child: NotificationDotWidget(
                  //       isRead: isRead),
                  //   ),
                  // )
                ],
              )),
            ),
            const HorizontalGap(8),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      titleText,
                      style: AppTextStyles.bodyLargeSemiboldTextStyle
                          .copyWith(color: AppColors.primaryTextColor),
                    ),
                  ],
                ),

                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: subtitle, style: AppTextStyles.captionTextStyle),
                  ]),
                  // style: AppTextStyles.bodySmallTextStyle.copyWith(
                  //     color: isRead
                  //         ? AppColors.primaryTextColor.withOpacity(0.4)
                  //         : AppColors.primaryTextColor)
                ),
                AppGaps.hGap4,
                Text(
                  durationText,
                  style: AppTextStyles.bodyMediumTextStyle
                      .copyWith(color: AppColors.bodyTextColor),
                ),
                // Text(
                //   Helper.getRelativeDateTimeText(dateTime),
                //   style: const TextStyle(
                //     color: AppColors.bodyTextColor,
                //     fontSize: 14,
                //     fontWeight: FontWeight.w400,
                //   ),
                // )
              ],
            ))
          ]),
        ));
  }

  Widget get imageWidget => switch (notificationType) {
        NotificationType.confirmed => Image.asset('confirmed'),
        NotificationType.wallet => Image.asset('confirmed'),
        NotificationType.notification => Image.asset('confirmed'),
        _ => Image.asset('name')
      };
  String get titleText =>
      switch (notificationType) { NotificationType.confirmed => '1', _ => '' };
}
