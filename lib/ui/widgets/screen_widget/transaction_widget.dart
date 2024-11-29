import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/datetime.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';

//transaction widget
class TransactionWidget extends StatelessWidget {
  final String text1;
  final String text2;

  //final Color iconColor;
  final Widget icon;
  final Color backColor;
  final String title;
  final DateTime dateTime;

  const TransactionWidget(
      {Key? key,
      required this.title,
      //  required this.iconColor,
      required this.text1,
      required this.text2,
      required this.icon,
      required this.backColor,
      required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        CircleAvatar(
            maxRadius: 16,
            // backgroundColor: Color.fromARGB(255, 179, 236, 255),
            backgroundColor: backColor,
            child: icon),
        AppGaps.wGap10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 12, 1, 59))),
            Text(
              dayText,
              style: AppTextStyles.captionTextStyle,
            ),
          ],
        ),
      ]),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text2,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color.fromARGB(255, 12, 1, 59))),
          Text(text1,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey)),
        ],
      ),
    ]);
  }

  String get dayText {
    if (Helper.isToday(dateTime)) {
      return 'Today at ${dateTime.formatted('hh:mm a')}';
    }
    if (Helper.wasYesterday(dateTime)) {
      return 'Yesterday at ${dateTime.formatted('hh:mm a')}';
    }
    if (Helper.isTomorrow(dateTime)) {
      return 'Tomorrow at ${dateTime.formatted('hh:mm a')}';
    }
    // return Helper.ddMMMyyyyFormattedDateTime(dateTime);
    return dateTime.formatted('dd/MM/yy \'at\' hh:mm a');
  }
}

//transactionMethod widget
class TransactionMethodWidget extends StatelessWidget {
  final String text1;
  final String text2;

  final Widget iconWidget;
  final String title;

  const TransactionMethodWidget(
      {Key? key,
      required this.title,
      //  required this.iconColor,
      required this.text1,
      required this.text2,
      required this.iconWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        iconWidget,
        AppGaps.wGap10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 12, 1, 59))),
            Text(text1,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey)),
          ],
        ),
      ]),
      Text(text2,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color.fromARGB(255, 12, 1, 59))),
    ]);
  }
}
