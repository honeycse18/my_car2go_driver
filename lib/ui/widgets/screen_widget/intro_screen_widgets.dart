import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

/// Per intro page content widget
class IntroContentWidget extends StatelessWidget {
  final Size screenSize;
  final String localImageLocation;
  final String slogan;
  final String subtitle;
  const IntroContentWidget({
    Key? key,
    required this.localImageLocation,
    required this.slogan,
    required this.subtitle,
    required this.screenSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /* <-------- 60px height gap --------> */
        AppGaps.hGap60,
        Expanded(child: Image.asset(localImageLocation)),
        /* <-------- 40px height gap --------> */
        AppGaps.hGap40,
        Expanded(
            child: HighlightAndDetailTextWidget(
                slogan: slogan, subtitle: subtitle)),
        /* <-------- 40px height gap --------> */
        AppGaps.hGap40,
      ],
    );
  }
}
