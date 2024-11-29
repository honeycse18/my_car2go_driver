import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class DownArrowBox extends StatelessWidget {
  const DownArrowBox(
      {required this.icon, required this.title, required this.text, super.key});
  final Widget icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 98,
      height: 89,
      decoration: ShapeDecoration(
        color: const Color(0x19016A70),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        children: [
          /* <-------- 15px height gap --------> */
          AppGaps.hGap15,
          icon,
          Text(
            title,
            style: AppTextStyles.semiSmallXBoldTextStyle
                .copyWith(color: AppColors.primaryColor),
          ),
          Text(
            text,
            style: AppTextStyles.bodySmallMediumTextStyle
                .copyWith(color: AppColors.bodyTextColor),
          ),
        ],
      ),
    );
  }
}
