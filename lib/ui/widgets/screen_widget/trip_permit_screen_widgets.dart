import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/double.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class TripPermitListWidget extends StatelessWidget {
  final bool isMyPlan;
  final int validityDays;
  final String title;
  final double price;
  final bool isSelected;
  final void Function()? onTap;

  const TripPermitListWidget({
    this.isMyPlan = false,
    super.key,
    required this.validityDays,
    required this.title,
    required this.price,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      // paddingValue: const EdgeInsets.symmetric(horizontal: 16),
      backgroundColor:
          isSelected ? const Color(0xFFE2ECED) : const Color(0xFFF6F5F2),
      borderRadiusValue: 12,
      onTap: onTap,
      child: Container(
        height: isMyPlan ? 78 : 60,
        decoration: ShapeDecoration(
          // color: const Color(0xFFF6F5F2),
          shape: RoundedRectangleBorder(
            side: isSelected
                ? const BorderSide(color: AppColors.primaryColor)
                : const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Stack(children: [
          if (isMyPlan)
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                // width: 99,
                height: 30,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: const ShapeDecoration(
                  color: Color(0x19016A70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'My plan',
                      style: TextStyle(
                        color: Color(0xFF016A70),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$validityDays Days',
                  style: const TextStyle(
                    color: Color(0xFF0B204C),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  price.getCurrencyFormattedText(),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFF016A70),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class TripPermitBenefitItemWidget extends StatelessWidget {
  final String label;
  const TripPermitBenefitItemWidget({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check_circle, size: 16, color: AppColors.primaryColor),
        AppGaps.wGap8,
        Text(label,
            textAlign: TextAlign.center,
            style: AppTextStyles.poppinsBodyTextStyle
                .copyWith(color: Colors.white))
      ],
    );
  }
}
