import 'package:car2godriver/controller/trip_permit/trip_permit_history_controller.dart';
import 'package:car2godriver/controller/trip_permit/trip_permit_transaction_permit_history_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/extensions/datetime.dart';
import 'package:car2godriver/utils/extensions/double.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/screen_widget/trip_permit_history_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripPermitTransactionHistoryDetails extends StatelessWidget {
  const TripPermitTransactionHistoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripPermitTransactionHistoryScreenController>(
        global: false,
        init: TripPermitTransactionHistoryScreenController(),
        builder: (controller) => CustomScaffold(
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleText: 'Transaction History',
                hasBackButton: true,
              ),
              body: ScaffoldBodyWidget(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGaps.hGap24,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        decoration: BoxDecoration(
                          color: AppColors.appbarTittleColor,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            const BoxShadow(
                              blurRadius: 20,
                              blurStyle: BlurStyle.normal,
                              color: AppColors.yColor,
                              offset: Offset.zero,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Id ',
                                  style: TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  controller.transactionDetails.id,
                                  style: TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.hGap16,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Subscription Plan ',
                                  style: TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '${controller.transactionDetails.subscriptionOrder.pricingModels.durationInDay} Days',
                                  style: const TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.hGap16,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Payment Date ',
                                  style: TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  controller.transactionDetails.createdAt
                                      .formatted('dd MMM yyyy'),
                                  style: const TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.hGap16,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Payment Method ',
                                  style: TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  controller.transactionDetails
                                      .subscriptionOrder.payment.type,
                                  style: TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.hGap16,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Payment Status ',
                                  style: TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  controller.transactionDetails
                                      .subscriptionOrder.payment.status,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.hGap36,
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 328,
                                    decoration: const ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: AppColors.formBorderColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.hGap10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Payment ',
                                  style: TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  controller.transactionDetails.amount
                                      .getCurrencyFormattedText(),
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      AppGaps.hGap40,
                    ]),
              ),
            ));
  }
}
