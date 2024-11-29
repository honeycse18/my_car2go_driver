import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:flutter/material.dart';

class ProfileFieldWidget extends StatelessWidget {
  final String appBarTitle;
  final String subtitle;
  final Widget child;

  const ProfileFieldWidget(
      {required this.appBarTitle,
      required this.subtitle,
      required this.child,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appBarTitle,
          style: AppTextStyles.titlesemiSmallMediumTextStyle
              .copyWith(color: AppColors.primaryTextColor),
        ),
        const VerticalGap(4),
        Text(
          subtitle,
          style: AppTextStyles.bodyTextStyle
              .copyWith(color: AppColors.bodyTextColor),
        ),
        const VerticalGap(16),
        child,
      ],
    );
  }
}
