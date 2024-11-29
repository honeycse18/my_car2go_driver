import 'package:car2godriver/models/enums/profile_status.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:flutter/material.dart';

class ProfileStatusWidget extends StatelessWidget {
  final ProfileStatus status;
  const ProfileStatusWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration:
          ShapeDecoration(shape: const StadiumBorder(), color: _fillColor),
      child: Text(
        status.viewableTextTransKey.toCurrentLanguage,
        style: AppTextStyles.bodyMediumTextStyle
            .copyWith(fontSize: 14, color: _textColor),
      ),
    );
  }

  Color get _fillColor => switch (status) {
        ProfileStatus.pending => Color.alphaBlend(
            AppColors.warningColor.withOpacity(0.1), Colors.white),
        ProfileStatus.approved => Color.alphaBlend(
            AppColors.successColor.withOpacity(0.1), Colors.white),
        ProfileStatus.cancelled =>
          Color.alphaBlend(AppColors.errorColor.withOpacity(0.1), Colors.white),
        ProfileStatus.suspended =>
          Color.alphaBlend(AppColors.errorColor.withOpacity(0.1), Colors.white),
        _ => Color.alphaBlend(
            AppColors.warningColor.withOpacity(0.1), Colors.white),
      };

  Color get _textColor => switch (status) {
        ProfileStatus.pending => AppColors.warningColor,
        ProfileStatus.approved => AppColors.successColor,
        ProfileStatus.cancelled => AppColors.errorColor,
        ProfileStatus.suspended => AppColors.errorColor,
        _ => AppColors.warningColor,
      };
}
