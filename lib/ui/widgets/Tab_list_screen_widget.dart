import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

/* <--------  Tab Status Widget  --------> */
class TabStatusWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final void Function()? onTap;

  const TabStatusWidget(
      {super.key, required this.text, required this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: RawButtonWidget(
        onTap: onTap,
        borderRadiusValue: 8,
        // backgroundColor:
        //     isSelected ? AppColors.primaryColor : AppColors.myRideTabColor,
        child: Container(
          height: 52,
          width: 117,
          alignment: Alignment.center,
          // margin: EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.unSelectVehicleColor),
              color: isSelected
                  ? AppColors.selectVehicleColor
                  : AppColors.unSelectVehicleColor),
          child: Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: isSelected ? AppColors.primaryColor : null),
          ),
        ),
      ),
    );
  }
}
