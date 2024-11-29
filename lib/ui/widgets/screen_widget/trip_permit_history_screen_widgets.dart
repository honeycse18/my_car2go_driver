import 'package:car2godriver/models/api_responses/user_details_response.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/datetime.dart';
import 'package:car2godriver/utils/extensions/double.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TripPermitHistoryWidget extends StatelessWidget {
  final double amount;
  final int durationInDays;
  final DateTime expireDateTime;
  final bool isAutoRenewActive;
  final String id;
  final void Function()? onViewDetailsTap;

  const TripPermitHistoryWidget({
    super.key,
    required this.amount,
    required this.durationInDays,
    required this.expireDateTime,
    required this.isAutoRenewActive,
    required this.id,
    this.onViewDetailsTap,
  });

  // final Subscription item;
  // final String item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: ShapeDecoration(
        color: const Color(0xFFF6F5F2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$durationInDays Days',
                style: AppTextStyles.bodySemiboldTextStyle.copyWith(
                  fontSize: 18,
                ),
              ),
              // Text(
              //   '${item.package.duration} Days',
              //   style: const TextStyle(
              //     color: AppColors.primaryTextColor,
              //     fontSize: 18,
              //     fontFamily: 'Poppins',
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              // Text(
              //   Helper.getCurrencyFormattedWithDecimalAmountText(
              //       item.package.price),
              //   style: const TextStyle(
              //     color: Color(0xFF016A70),
              //     fontSize: 20,
              //     fontFamily: 'Poppins',
              //     fontWeight: FontWeight.w600,
              //   ),
              // )
              const Spacer(),
              Text(amount.getCurrencyFormattedText(),
                  style: AppTextStyles.bodySemiboldTextStyle.copyWith(
                    fontSize: 20,
                    color: AppColors.primaryColor,
                  )),
            ],
          ),
          AppGaps.hGap12,
          Row(
            children: [
              Expanded(
                child: Container(
                  width: 328,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          AppGaps.hGap12,
          Row(
            children: [
              Text(
                'Expire Date : ${expireDateTime.formatted('MMM dd, yyyy')}',
                style: const TextStyle(
                  color: AppColors.bodyTextColor,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              // Text(
              //    DateTime.now().isBefore(item.end)
              //       ? ' Active'
              //       : ' Upcoming',
              //   style: TextStyle(
              //     color: DateTime.now().isAfter(item.start) &&
              //             DateTime.now().isBefore(item.end)
              //         ? AppColors.successColor
              //         : AppColors.notificationIconColor,
              //     fontSize: 16,
              //     fontFamily: 'Poppins',
              //     fontWeight: FontWeight.w400,
              //   ),
              // )
            ],
          ),
          AppGaps.hGap4,
          Row(
            children: [
              Row(
                children: [
                  LocalAssetSVGIcon(
                    AppAssetImages.syncSVG,
                    height: 24,
                    width: 24,
                    color: isAutoRenewActive
                        ? AppColors.warningColor
                        : AppColors.primaryColor,
                  ),
                  Text(
                    isAutoRenewActive
                        ? 'Auto - renewal on'
                        : 'Auto - renewal off',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: isAutoRenewActive
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color:
                            isAutoRenewActive ? AppColors.warningColor : null),
                  ),
                ],
              ),
            ],
          ),
          AppGaps.hGap4,
          Row(
            children: [
              const Text(
                'Id: ',
                style: TextStyle(
                  color: AppColors.bodyTextColor,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(id),
            ],
          ),
          AppGaps.hGap16,
          Align(
            alignment: Alignment.bottomCenter,
            child: RawButtonWidget(
                onTap: onViewDetailsTap,
                child: const Text(
                  'View Details',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                )),
          ),
          // if (DateTime.now().isBefore(item.start)) AppGaps.hGap4,
          // if (DateTime.now().isBefore(item.start))
          //   Text(
          //     'Starts on ${Helper.MMMddyyyyFormattedDateTime(item.start)}',
          //     style: const TextStyle(
          //       color: AppColors.primaryTextColor,
          //       fontSize: 16,
          //       fontFamily: 'Poppins',
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          // AppGaps.hGap4,
          // Text(
          //   'Expires on ${Helper.MMMddyyyyFormattedDateTime(item.end)}',
          //   style: const TextStyle(
          //     color: AppColors.errorColor,
          //     fontSize: 16,
          //     fontFamily: 'Poppins',
          //     fontWeight: FontWeight.w400,
          //   ),
          // )
        ],
      ),
    );
  }
}

class TripPermitTransactionHistoryWidget extends StatelessWidget {
  final String amount;
  final int duration;
  const TripPermitTransactionHistoryWidget({
    required this.amount,
    required this.duration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
              const Row(
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
                    'AHADADDGG',
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
                    '$duration',
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
                    '${DateTime.now().formatted('dd MMM yyyy')}',
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
              const Row(
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
                    'PayPal',
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
              const Row(
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
                    'Paid',
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
                            strokeAlign: BorderSide.strokeAlignCenter,
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
                    amount,
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
        ))
      ],
    );
  }
}

class TripPermitViewDetailsWidget extends StatelessWidget {
  final int amount;
  final int duration;
  const TripPermitViewDetailsWidget({
    required this.amount,
    required this.duration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
              const Row(
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
                    'AHADADDGG',
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
                    '$duration',
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
                    'Purchase Date ',
                    style: TextStyle(
                      color: AppColors.primaryTextColor,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    ' ${DateTime.now().formatted('dd MMM yyyy')}',
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
                    'Expire Date ',
                    style: TextStyle(
                      color: AppColors.primaryTextColor,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '${DateTime.now().add(const Duration(days: 365)).formatted('dd MMM yyyy')}',
                    style: const TextStyle(
                      color: AppColors.errorColor,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              AppGaps.hGap16,
              const Row(
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
                    'PayPal',
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
              const Row(
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
                    'Paid',
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
                            strokeAlign: BorderSide.strokeAlignCenter,
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
                    '$amount',
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
        ))
      ],
    );
  }
}
