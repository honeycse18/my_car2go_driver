import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/screen_widget/transaction_widget.dart';
import 'package:flutter/material.dart';

class TransactionListWidget extends StatelessWidget {
  final String title;
  final String text1;
  final String text2;
  final String type;
  final DateTime dateTime;
  final void Function()? onTap;
  const TransactionListWidget({
    super.key,
    required this.title,
    required this.text1,
    required this.text2,
    required this.type,
    required this.dateTime,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      borderRadiusValue: 8,
      onTap: onTap,
      child: Container(
        height: 56,
        width: 392,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.bodyTextColor)),
        child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10),
            child: TransactionWidget(
              dateTime: dateTime,
              title: title,
              icon: type == 'add_money'
                  ? const SvgPictureAssetWidget(
                      AppAssetImages.arrowDownRightRedSVGLogoLine,
                      color: AppColors.successColor)
                  : const SvgPictureAssetWidget(
                      AppAssetImages.arrowUpRightSVGLogoLine,
                      color: AppColors.errorColor),
              backColor: type == 'add_money'
                  ? AppColors.walletAddMoneyColor
                  : AppColors.walletWithdrawMoneyColor,
              text1: text1,
              text2: text2,
            )),
      ),
    );
  }
}
