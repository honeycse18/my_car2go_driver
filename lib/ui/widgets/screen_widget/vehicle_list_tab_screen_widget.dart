import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class ListTabStatusWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final void Function()? onTap;

  const ListTabStatusWidget(
      {super.key, required this.text, required this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      onTap: onTap,
      borderRadiusValue: 8,
      backgroundColor: isSelected ? AppColors.primaryColor : Colors.transparent,
      child: Container(
        height: 50,
        width: 111,
        alignment: Alignment.center,
        // margin: EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          // border: Border.all(color: AppColors.primaryColor),
        ),
        child: Text(text,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: isSelected
                ? AppTextStyles.bodyMediumTextStyle
                    .copyWith(color: AppColors.formInnerColor)
                : AppTextStyles.bodyMediumTextStyle
                    .copyWith(color: AppColors.formInnerColor)),
      ),
    );
  }
}
