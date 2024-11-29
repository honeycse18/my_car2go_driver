import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WithdrawMethodBottomSheetWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final bool isSelected;
  final void Function(bool?) onChanged;

  const WithdrawMethodBottomSheetWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.fromBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                image,
                height: 32,
                width: 32,
                fit: BoxFit.cover,
              ),
              AppGaps.wGap12,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: AppTextStyles.bodyLargeMediumTextStyle.copyWith(
                        color: AppColors.primaryTextColor,
                      )),
                  Text(subtitle,
                      style: AppTextStyles.bodySmallTextStyle.copyWith(
                        color: AppColors.bodyTextColor,
                      )),
                ],
              ),
            ],
          ),
          GestureDetector(
              onTap: () => onChanged(!isSelected),
              child: isSelected
                  ? SvgPicture.asset(
                      AppAssetImages.selectCheckBoxSVGLogoLine,
                      width: 24,
                      height: 24,
                    )
                  : SvgPicture.asset(
                      AppAssetImages.unselectCheckBoxSVGLogoLine,
                      width: 24,
                      height: 24,
                    )),
        ],
      ),
    );
  }
}
