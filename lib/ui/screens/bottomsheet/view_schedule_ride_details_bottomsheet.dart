import 'package:car2godriver/controller/start_ride_bottomsheet_controller.dart';
import 'package:car2godriver/ui/screens/bottomsheet/submit_otp_screen_bottomsheet.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/screen_widget/location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class StartRideBottomSheetScreen extends StatelessWidget {
  const StartRideBottomSheetScreen({super.key});
//========same===========
  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<StartRideBottomSheetController>(
        global: false,
        init: StartRideBottomSheetController(),
        builder: (controller) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: const BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(children: [
                  /* <-------- 10px height gap --------> */
                  AppGaps.hGap12,
                  const BottomSheetTopNotch(),
                  AppGaps.hGap12,
                  Text(
                    'Start Time',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyLargeTextStyle
                        .copyWith(color: AppColors.bodyTextColor),
                  ),
                  const Text(
                    '24 Oct,2024, 05:40 AM',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyLargeMediumTextStyle,
                  ),

                  /* <-------- 24px height gap --------> */
                  AppGaps.hGap24,
                  Expanded(
                      child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),

                    /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
                    child: ScaffoldBodyWidget(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 14),
                                    height: 87,
                                    decoration: const BoxDecoration(
                                        color: AppColors.formInnerColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14))),
                                    child: Row(children: [
                                      SizedBox(
                                        height: 48,
                                        width: 48,
                                        /* <-------- Fetch user image from API --------> */
                                        child: CachedNetworkImageWidget(
                                          imageURL:
                                              controller.rideDetails.user.image,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      ),
                                      /* <-------- 16px width gap --------> */
                                      AppGaps.wGap16,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              controller.rideDetails.user.name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles
                                                  .bodyLargeSemiboldTextStyle,
                                            ),
                                            /* <-------- 7px height gap --------> */
                                            AppGaps.hGap7,
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: AppColors.primaryColor,
                                                ),
                                                AppGaps.wGap4,
                                                Expanded(
                                                  child: Text(
                                                    '${5} (520 reviews)',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyles
                                                        .bodySmallTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .bodyTextColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                Helper
                                                    .getCurrencyFormattedWithDecimalAmountText(
                                                        controller
                                                            .rideDetails.total),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyles
                                                    .bodySemiboldTextStyle,
                                              ),
                                              AppGaps.wGap4,
                                              SvgPicture.asset(
                                                AppAssetImages.infoSVGLogoLine,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${controller.rideDetails.distance.text}, ${controller.rideDetails.duration.text}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyles
                                                    .bodySmallTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .bodyTextColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      /* Row(
                                        children: [
                                          RawButtonWidget(
                                            borderRadiusValue: 12,
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColors
                                                          .primaryBorderColor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12))),
                                              child: const Center(
                                                  child: SvgPictureAssetWidget(
                                                      AppAssetImages
                                                          .messageFilSVGLogoSolid)),
                                            ),
                                            onTap: () {},
                                          ),
                                          AppGaps.wGap8,
                                          RawButtonWidget(
                                            borderRadiusValue: 12,
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColors
                                                          .primaryBorderColor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12))),
                                              child: const Center(
                                                  child: SvgPictureAssetWidget(
                                                      AppAssetImages
                                                          .callingSVGLogoSolid)),
                                            ),
                                            onTap: () {},
                                          )
                                        ],
                                      ) */
                                    ]),
                                  ),
                                )
                              ],
                            ),
                            /*  AppGaps.hGap16,
                            Row(
                              children: [
                                RawButtonWidget(
                                  borderRadiusValue: 12,
                                  child: Container(
                                    height: 44,
                                    width: 44,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        border: Border.all(
                                            color: AppColors.fromBorderColor)),
                                    child: const Center(
                                        child: Icon(Icons.call,
                                            color: AppColors.primaryColor,
                                            size: 20)),
                                  ),
                                  onTap: () {},
                                ),
                                AppGaps.wGap10,
                                Expanded(
                                  child: CustomMessageTextFormField(
                                    boxHeight: 44,
                                    isReadOnly: true,
                                    onTap: () {},
                                    hintText: 'Message Your Customer',
                                    suffixIcon: Icon(Icons.send,
                                        color: AppColors.primaryColor, size: 20),
                                  ),
                                )
                              ],
                            ), */
                            /* <-------- 16px height gap --------> */
                            AppGaps.hGap16,
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    height: 162,
                                    decoration: const BoxDecoration(
                                        color: AppColors.formInnerColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14))),
                                    child: Column(children: [
                                      LocationDetailsWidget(
                                        pickupLocation:
                                            controller.rideDetails.from.address,
                                        dropLocation:
                                            controller.rideDetails.to.address,
                                        distance: '1.1 Km',
                                      ),
                                      //
                                    ]),
                                  ),
                                )
                              ],
                            ),
                            AppGaps.hGap20,
                            Text('Payment method',
                                style: AppTextStyles.bodySmallTextStyle
                                    .copyWith(color: AppColors.bodyTextColor)),
                            AppGaps.hGap8,
                            Row(children: [
                              SvgPicture.asset(
                                AppAssetImages.grayWalletSVGLogoLine,
                              ),
                              AppGaps.wGap10,
                              Text('Wallet',
                                  style: AppTextStyles.bodyMediumTextStyle
                                      .copyWith(
                                          color: AppColors.primaryTextColor)),
                            ]),
                            AppGaps.hGap18,
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: AppTextStyles
                                        .bodyLargeMediumTextStyle
                                        .copyWith(
                                            color: AppColors.primaryTextColor),
                                  ),
                                  Row(
                                    children: [
                                      Text('\$10',
                                          style: AppTextStyles
                                              .bodyMediumTextStyle
                                              .copyWith(
                                                  color: AppColors
                                                      .primaryTextColor)),
                                      AppGaps.wGap4,
                                      SvgPicture.asset(
                                        AppAssetImages.infoSVGLogoLine,
                                      ),
                                    ],
                                  ),
                                ]),
                            /* <-------- 32px height gap --------> */
                            AppGaps.hGap12,
                            Row(
                              children: [
                                Expanded(
                                    /* <-------- Cancle Button--------> */
                                    child: RawButtonWidget(
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 56,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: AppColors.grayButtonColor),
                                          child: Text(
                                            'Cancel Trip',
                                            textAlign: TextAlign.center,
                                            style: AppTextStyles
                                                .bodyLargeMediumTextStyle
                                                .copyWith(
                                                    color:
                                                        AppColors.errorColor),
                                          ),
                                        ),
                                        onTap: () async {
                                          controller.onBottomButtonTap();
                                        })),
                                /* <-------- 16px width gap --------> */
                                AppGaps.wGap16,
                                Expanded(
                                    /* <-------- Submit Otp Start Ride Button--------> */
                                    child: StretchedTextButtonWidget(
                                  buttonText: 'Start Drive',
                                  onTap: () {
                                    Get.back(result: true);
                                    Get.bottomSheet(
                                        const SubmitOtpStartRideBottomSheet(),
                                        settings: RouteSettings(
                                            arguments: controller.rideDetails));
                                  },
                                ))
                              ],
                            ),
                            /* <-------- 30px height gap --------> */
                            AppGaps.hGap30,
                          ]),
                    ),
                  ))
                ]),
              ),
            ));
  }
}
