import 'package:car2godriver/models/fakeModel/intro_content_model.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

/// Single notification entry widget from notification group
class SingleNotificationWidget extends StatelessWidget {
  final FakeNotificationModel notification;
  final void Function()? onTap;

  const SingleNotificationWidget({
    Key? key,
    required this.notification,
    this.onTap,
  }) : super(key: key);

  TextStyle? _getTextStyle(FakeNotificationTextModel notificationText) {
    if (notificationText.isBoldText) {
      return const TextStyle(fontWeight: FontWeight.w600);
    } else if (notificationText.isHashText) {
      return const TextStyle(
          color: AppColors.primaryColor, fontWeight: FontWeight.w600);
    } else if (notificationText.isColoredText) {
      return const TextStyle(color: AppColors.primaryColor);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 10,
            width: 10,
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: notification.isRead
                    ? AppColors.bodyTextColor
                    : AppColors.primaryColor),
          ),
          AppGaps.wGap16,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: notification.isRead
                              ? AppColors.bodyTextColor
                              : AppColors.primaryTextColor,
                          height: 1.5),
                      children: notification.texts
                          .map((notificationText) => TextSpan(
                              text: notificationText.text,
                              style: _getTextStyle(notificationText)))
                          .toList()),
                ),
                AppGaps.hGap8,
                Text(notification.timeText,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.bodyTextColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Notification group widget from date wise
/* class NotificationDateGroupWidget extends StatelessWidget {
  const NotificationDateGroupWidget({
    Key? key,
    required this.notificationDateGroup,
    required this.outerIndex,
  }) : super(key: key);

  final FakeNotificationDateGroupModel notificationDateGroup;
  final int outerIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(notificationDateGroup.dateHumanReadableText,
            style: Theme.of(context).textTheme.labelLarge),
        AppGaps.hGap24,
        /* <---- Notification list under a date 
                 category ----> */
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          separatorBuilder: (context, index) => AppGaps.hGap24,
          itemCount: FakeData
              .fakeNotificationDateGroups[outerIndex].groupNotifications.length,
          itemBuilder: (context, index) {
            /// Single notification
            final notification = FakeData.fakeNotificationDateGroups[outerIndex]
                .groupNotifications[index];
            return SingleNotificationWidget(notification: notification);
          },
        ),
      ],
    );
  }
} */

/* <--------  Notification Widget --------> */
class NotificationWidget extends StatelessWidget {
  // final bool isRead;
  // final String notificationType;
  // final String description;
  // final String action;
  // final String img;
  // final String title;
  // final DateTime dateTime;
  // final bool isDateChanged;
  final void Function()? onTap;

  const NotificationWidget({
    Key? key,
    // this.isRead = true,
    // required this.notificationType,
    this.onTap,
    // required this.dateTime,
    // required this.img,
    // required this.action,
    // required this.isDateChanged,
    // this.description = '',
    // this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Today',
            style: AppTextStyles.notificationDateSection,
          ),
        ),
        AppGaps.hGap24,
        _NotificationWidget(
          img: AppAssetImages.tikImage,
          onTap: onTap,
          title: 'QR code online payment confirm',
          // action: action,
          // isRead: isRead,
          // notificationType: notificationType,
          // dateTime: dateTime,
          // description: description,

          // isDateChanged: isDateChanged,
          // onTap: onTap
        ),
        AppGaps.hGap16,
        _NotificationWidget(
          img: AppAssetImages.moneyImage,
          title: 'Money has been deposited',
          onTap: onTap,

          // action: action,
          // isRead: isRead,
          // notificationType: notificationType,
          // dateTime: dateTime,
          // description: description,

          // isDateChanged: isDateChanged,
          // onTap: onTap
        ),
        AppGaps.hGap16,
        _NotificationWidget(
          img: AppAssetImages.bellImage,
          title: 'QR code online payment confirm',
          // action: action,
          // isRead: isRead,
          // notificationType: notificationType,
          // dateTime: dateTime,
          // description: description,

          // isDateChanged: isDateChanged,
          // onTap: onTap
        ),
      ],
    );
  }

//   String get dayText {
//     if (Helper.isToday(dateTime)) {
//       return AppLanguageTranslation.todayTransKey.toCurrentLanguage;
//     }
//     if (Helper.wasYesterday(dateTime)) {
//       return AppLanguageTranslation.yesterdayTransKey.toCurrentLanguage;
//     }
//     if (Helper.isTomorrow(dateTime)) {
//       return AppLanguageTranslation.tomorrowTransKey.toCurrentLanguage;
//     }
//     return Helper.ddMMMyyyyFormattedDateTime(dateTime);
//   }
}

class _NotificationWidget extends StatelessWidget {
  // final bool isRead;
  // final String notificationType;
  // final String action;
  final String img;
  // final DateTime dateTime;
  // final bool isDateChanged;
  // final String description;
  final String title;
  final void Function()? onTap;
  const _NotificationWidget({
    Key? key,
    // this.isRead = true,
    // required this.notificationType,
    // required this.dateTime,
    required this.img,
    // required this.isDateChanged,
    this.onTap,
    // this.description = '',
    // required this.action,
    this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /* Container(
      height: 110,
      width: 360,
      decoration: const BoxDecoration(
        color: AppColors.appbarTittleColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            blurStyle: BlurStyle.normal,
            color: AppColors.yColor,
            offset: Offset.zero,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: 110,
          child: CustomRawListTileWidget(
              // colorCng: isRead ? false : true,
              // isShadow: isRead ? false : true,
              onTap: onTap,
              borderRadiusRadiusValue: AppComponents.defaultBorderRadius,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: AppColors.appbarTittleColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Stack(
                    children: [
                      Image.asset(img),
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
                AppGaps.wGap16,
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.bodyLargeSemiboldTextStyle
                              .copyWith(color: AppColors.primaryTextColor),
                        ),
                      ],
                    ),

                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text:
                                'Lorem ipsum dolor sit amet consectetur. Ultricies tincidunt eleifend vitae',
                            style: AppTextStyles.captionTextStyle),
                      ]),
                      // style: AppTextStyles.bodySmallTextStyle.copyWith(
                      //     color: isRead
                      //         ? AppColors.primaryTextColor.withOpacity(0.4)
                      //         : AppColors.primaryTextColor)
                    ),
                    AppGaps.hGap4,
                    Text(
                      '2 hours ago',
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
              ])),
        ),
      ),
    ) */
        SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomRawListTileWidget(
            // colorCng: isRead ? false : true,
            // isShadow: isRead ? false : true,
            onTap: onTap,
            borderRadiusRadiusValue: AppComponents.defaultBorderRadius,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: AppColors.appbarTittleColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Stack(
                  children: [
                    Image.asset(img),
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
              AppGaps.wGap16,
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.bodyLargeSemiboldTextStyle
                            .copyWith(color: AppColors.primaryTextColor),
                      ),
                    ],
                  ),

                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text:
                              'Lorem ipsum dolor sit amet consectetur. Ultricies tincidunt eleifend vitae',
                          style: AppTextStyles.captionTextStyle),
                    ]),
                    // style: AppTextStyles.bodySmallTextStyle.copyWith(
                    //     color: isRead
                    //         ? AppColors.primaryTextColor.withOpacity(0.4)
                    //         : AppColors.primaryTextColor)
                  ),
                  AppGaps.hGap4,
                  Text(
                    '2 hours ago',
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
            ])),
      ),
    );
  }
}
