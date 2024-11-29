import 'dart:developer';

import 'package:car2godriver/controller/trip_permit/trip_permit_history_controller.dart';
import 'package:car2godriver/controller/trip_permit/trip_permit_view_details_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/datetime.dart';
import 'package:car2godriver/utils/extensions/double.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/screen_widget/trip_permit_history_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class TripPermitViewDetails extends StatelessWidget {
  const TripPermitViewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripPermitViewDetailsScreenController>(
      global: true,
      init: TripPermitViewDetailsScreenController(),
      builder: (controller) => CustomScaffold(
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleText: 'Details',
          hasBackButton: true,
        ),
        body: ScaffoldBodyWidget(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AppGaps.hGap24,
            Container(
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
                        controller.myTripPermitDetails.subscribed.id,
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
                        '${controller.myTripPermitDetails.subscribed.pricingModels.durationInDay} Days',
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
                        controller.myTripPermitDetails.subscribed.startDate
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
                        controller.myTripPermitDetails.subscribed.expireDate
                            .formatted('dd MMM yyyy'),
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
                        controller.myTripPermitDetails.subscribed.payment.type,
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
                        controller
                            .myTripPermitDetails.subscribed.payment.status,
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
                        controller
                            .myTripPermitDetails.subscribed.pricingModels.price
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
            AppGaps.hGap30,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Auto Renew',
                  style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                ),
                Row(
                  children: [
/*                     FlutterSwitch(
                      toggleSize: 24,
                      height: 24,
                      width: 51,
                      valueFontSize: 12,
                      padding: 2,
                      value:
                          controller.myTripPermitDetails.subscribed.autoRenewal,
                      onToggle: (value) {
                        log(value.toString());
                      },
                      showOnOff: true,
                    ), */
                    GestureDetector(
                      onTap: controller.toggleAutoRenew,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 24,
                        width: 51,
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: controller
                                  .myTripPermitDetails.subscribed.autoRenewal
                              ? AppColors.primaryColor
                              : Colors.grey,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (controller.myTripPermitDetails.subscribed
                                .autoRenewal) ...[
                              Text(
                                "  On",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            ] else ...[
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Off  ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Text(
              'Auto renew apply only Wallet balance',
              style: AppTextStyles.bodyTextStyle,
            ),
          ]),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22),
          child: StretchedOutlinedTextButtonWidget(
            text: 'Renew now',
            onTap: controller.onRenewNowButtonTap,
          ) /* Container(
            height: 56,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor, width: 2),
                borderRadius: BorderRadius.circular(8.0)),
            child: RawButtonWidget(
              onTap: controller.onRenewNowButtonTap,
              child: Center(
                  child: Text(
                'Renew Now',
                style: AppTextStyles.bodyLargeSemiboldTextStyle
                    .copyWith(color: AppColors.primaryColor),
              )),
            ),
          ) */
          ,
        ),
      ),
    );
  }
}
