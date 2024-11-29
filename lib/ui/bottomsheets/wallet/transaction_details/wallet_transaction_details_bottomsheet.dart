import 'package:car2godriver/ui/screens/bottomsheet/base_bottom_sheet.dart';
import 'package:car2godriver/ui/bottomsheets/wallet/transaction_details/wallet_transaction_details_bottomsheet_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/datetime.dart';
import 'package:car2godriver/utils/extensions/double.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletTransactionDetailsBottomSheet extends StatelessWidget {
  const WalletTransactionDetailsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletTransactionBottomSheetController>(
        init: WalletTransactionBottomSheetController(),
        global: false,
        builder: (controller) {
          return BaseBottomSheet(
              showCloseButton: true,
              onCloseButtonTap: () => Get.back(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalGap(16),
                  Text(
                    'Transaction details',
                    style: AppTextStyles.bodyLargeSemiboldTextStyle
                        .copyWith(fontSize: 20),
                  ),
                  const VerticalGap(18),
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: switch (controller.transactionDetails.mode) {
                        _ => [
                            TransactionDetailsItemRow(
                                title: 'Amount',
                                valueText: controller.transactionDetails.amount
                                    .getCurrencyFormattedText()),
                            const VerticalGap(8),
                            TransactionDetailsItemRow(
                                title: 'Transaction ID',
                                valueText: controller
                                    .transactionDetails.transactionId),
                            const VerticalGap(8),
                            TransactionDetailsItemRow(
                                title: 'Type',
                                valueText: controller.transactionDetails.from),
                            const VerticalGap(8),
                            TransactionDetailsItemRow(
                                title: 'Payment date',
                                valueText: controller
                                    .transactionDetails.createdAt
                                    .formatted('dd/MM/yy \'at\' hh:mm a')),
                            const VerticalGap(8),
                            TransactionDetailsItemRow(
                                title: 'Payment method',
                                valueText: controller
                                    .transactionDetails.payment.paymentMethod),
                            const VerticalGap(8),
                            TransactionDetailsItemRow(
                              title: 'Payment status',
                              valueText:
                                  controller.transactionDetails.payment.status,
                              valueTextStyle: const TextStyle(
                                  color: AppColors.warningColor),
                            ),
                          ],
                      }),
                  const VerticalGap(30),
                ],
              ));
        });
  }
}

class TransactionDetailsItemRow extends StatelessWidget {
  final String title;
  final String valueText;
  final TextStyle? valueTextStyle;
  const TransactionDetailsItemRow(
      {super.key,
      required this.title,
      required this.valueText,
      this.valueTextStyle});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(title, style: AppTextStyles.bodyTextStyle),
      Expanded(
          child: Text(
        valueText,
        textAlign: TextAlign.end,
        style: AppTextStyles.bodySemiboldTextStyle.merge(valueTextStyle),
      ))
    ]);
  }
}
