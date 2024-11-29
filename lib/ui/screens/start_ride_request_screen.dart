import 'package:car2godriver/controller/start_ride_request_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StartRideRequestScreen extends StatelessWidget {
  const StartRideRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<StartRequestScreenController>(
        init: StartRequestScreenController(),
        global: false,
        builder: ((controller) => CustomScaffold(
              // key: controller.bottomSheetFormKey,
              extendBodyBehindAppBar: true,
              extendBody: true,
              backgroundColor: AppColors.backgroundColor,
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: true,
                titleText: AppLanguageTranslation
                    .rideDetailsTransKey.toCurrentLanguage,
              ),
              /* <-------- Body Content --------> */
              body: Stack(
                children: [
                  Positioned.fill(
                    bottom: MediaQuery.of(context).size.height * 0.1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: GoogleMap(
                        mapType: MapType.normal,
                        mapToolbarEnabled: false,
                        zoomControlsEnabled: false,
                        myLocationEnabled: false,
                        compassEnabled: true,
                        zoomGesturesEnabled: true,
                        initialCameraPosition:
                            // AppSingleton.instance.defaultCameraPosition,
                            CameraPosition(
                                target: LatLng(
                                    (controller.cameraPosition.latitude) - 7.7,
                                    controller.cameraPosition.longitude),
                                zoom: controller.zoomLevel),
                        markers: controller.googleMapMarkers,
                        polylines: controller.googleMapPolyLines,
                        onMapCreated: controller.onGoogleMapCreated,
                        // onTap: controller.onGoogleMapTap,
                      ),
                    ),
                  ),
                  SlidingUpPanel(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Colors.transparent,
                    boxShadow: null,
                    minHeight: MediaQuery.of(context).size.height * 0.26,
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                    footer: Container(
                      width: context.width * 0.95,
                      margin: const EdgeInsets.only(right: 20),
                      child: ScaffoldBodyWidget(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() {
                            return controller.status.value == 'accepted'
                                ? Row(
                                    children: [
                                      Expanded(
                                        child:
                                            CustomStretchedOutlinedButtonWidget(
                                          onTap:
                                              controller.onCancelTripButtonTap,
                                          child: Text(AppLanguageTranslation
                                              .cancelTranskey
                                              .toCurrentLanguage),
                                        ),
                                      ),
                                      /* <-------- 15px width gap --------> */
                                      AppGaps.wGap15,
                                      /* <-------- Start trip button --------> */
                                      Expanded(
                                        child: CustomStretchedTextButtonWidget(
                                          buttonText: AppLanguageTranslation
                                              .startTripTranskey
                                              .toCurrentLanguage,
                                          onTap:
                                              controller.onStartTripButtonTap,
                                        ),
                                      )
                                    ],
                                  )
                                : controller.status.value == 'started'
                                    ? CustomStretchedTextButtonWidget(
                                        buttonText: AppLanguageTranslation
                                            .completeTripTranskey
                                            .toCurrentLanguage,
                                        onTap:
                                            controller.paymentId.isNotEmpty ||
                                                    controller
                                                            .ridePrimaryDetails
                                                            .payment
                                                            .method ==
                                                        'cash'
                                                ? controller.completeTrip
                                                : null,
                                      )
                                    : controller.status.value == 'completed'
                                        ? CustomStretchedTextButtonWidget(
                                            buttonText: AppLanguageTranslation
                                                .submitReviewTransKey
                                                .toCurrentLanguage,
                                            onTap: () {},
                                          )
                                        : controller.status.value == 'cancelled'
                                            ? Text(
                                                controller.cancelReason,
                                                style: AppTextStyles
                                                    .semiSmallXBoldTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .errorColor),
                                              )
                                            : AppGaps.emptyGap;
                          }),
                          /* <-------- 20px height gap --------> */
                          AppGaps.hGap10
                        ],
                      )),
                    ),
                    panel: Container(
                      margin: const EdgeInsets.only(right: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: AppColors.backgroundColor,
                      ),
                      child: Column(children: [
                        /* <-------- 12px height gap --------> */
                        AppGaps.hGap12,
                        Container(
                          height: 2,
                          width: 60,
                          color: Colors.grey,
                        ),
                        /* <-------- 24px height gap --------> */
                        AppGaps.hGap24,
                        Expanded(
                            child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
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
                                              child: CachedNetworkImageWidget(
                                                imageURL: controller
                                                        .ridePrimaryDetails
                                                        .user
                                                        .image
                                                        .isEmpty
                                                    ? controller.rideHistoryData
                                                        .user.image
                                                    : controller
                                                        .ridePrimaryDetails
                                                        .user
                                                        .image,
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
                                            AppGaps.wGap16,
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    controller
                                                            .ridePrimaryDetails
                                                            .user
                                                            .name
                                                            .isEmpty
                                                        ? controller
                                                            .rideHistoryData
                                                            .user
                                                            .name
                                                        : controller
                                                            .ridePrimaryDetails
                                                            .user
                                                            .name,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyles
                                                        .bodyLargeSemiboldTextStyle,
                                                  ),
                                                  AppGaps.hGap7,
                                                  Row(
                                                    children: [
                                                      const SvgPictureAssetWidget(
                                                        AppAssetImages
                                                            .starSVGLogoSolid,
                                                        height: 10,
                                                        width: 10,
                                                        color: AppColors
                                                            .primaryButtonColor,
                                                      ),
                                                      AppGaps.wGap4,
                                                      Expanded(
                                                        child: Text(
                                                          '${5} (520 reviews)',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                                      Helper.getCurrencyFormattedWithDecimalAmountText(
                                                          controller.ridePrimaryDetails
                                                                      .total ==
                                                                  0
                                                              ? controller
                                                                  .rideHistoryData
                                                                  .total
                                                              : controller
                                                                  .ridePrimaryDetails
                                                                  .total),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppTextStyles
                                                          .bodySemiboldTextStyle,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${controller.ridePrimaryDetails.distance.text.isEmpty ? controller.rideHistoryData.distance.text : controller.ridePrimaryDetails.distance.text}, ${controller.ridePrimaryDetails.duration.text.isEmpty ? controller.rideHistoryData.duration.text : controller.ridePrimaryDetails.duration.text}',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                          ]),
                                        ),
                                      )
                                    ],
                                  ),
                                  /* <-------- 16px height gap --------> */
                                  AppGaps.hGap16,
                                  /* Row(
                                        children: [
                                          RawButtonWidget(
                                            borderRadiusValue: 12,
                                            child: Container(
                                              height: 44,
                                              width: 44,
                                              decoration: BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12)),
                                                  border: Border.all(
                                                      color: AppColors
                                                          .fromBorderColor)),
                                              child: const Center(
                                                  child: SvgPictureAssetWidget(
                                                AppAssetImages
                                                    .callingSVGLogoLine,
                                                height: 15,
                                                width: 15,
                                              )),
                                            ),
                                            onTap: () {},
                                          ),
                                          AppGaps.wGap10,
                                          Expanded(
                                            child: CustomMessageTextFormField(
                                              boxHeight: 44,
                                              isReadOnly: true,
                                              onTap: () {
                                                Get.toNamed(
                                                    AppPageNames.chatScreen,
                                                    arguments: controller
                                                        .rideDetails.user.id);
                                              },
                                              hintText: AppLanguageTranslation
                                                  .messageYourDriverTransKey
                                                  .toCurrentLanguage,
                                              suffixIcon:
                                                  const SvgPictureAssetWidget(
                                                AppAssetImages.sendSVGLogoLine,
                                                height: 18,
                                                width: 18,
                                              ),
                                            ),
                                          )
                                        ],
                                      ), */
                                  AppGaps.hGap6,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      RawButtonWidget(
                                        child:
                                            const Icon(Icons.restore_outlined),
                                        onTap: () {
                                          controller.getRideDetails();
                                          controller.update();
                                        },
                                      ),
                                    ],
                                  ),
                                  /* <-------- 6px height gap --------> */
                                  AppGaps.hGap6,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          height: 195,
                                          decoration: const BoxDecoration(
                                              color: AppColors.formInnerColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(14))),
                                          child: Column(children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    AppLanguageTranslation
                                                        .startDateTimeTranskey
                                                        .toCurrentLanguage,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyles
                                                        .bodyLargeTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .bodyTextColor),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    Helper.ddMMMyyyyhhmmaFormattedDateTime(
                                                        controller
                                                            .ridePrimaryDetails
                                                            .updatedAt),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyles
                                                        .bodyLargeMediumTextStyle,
                                                  ),
                                                )
                                              ],
                                            ),
                                            /* <-------- 12px height gap --------> */
                                            AppGaps.hGap12,
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SvgPictureAssetWidget(
                                                  AppAssetImages
                                                      .currentLocationSVGLogoLine,
                                                  height: 16,
                                                  width: 16,
                                                  color:
                                                      AppColors.bodyTextColor,
                                                ),
                                                /* <-------- 8px width gap --------> */
                                                AppGaps.wGap8,
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppLanguageTranslation
                                                            .pickUpLocationTranskey
                                                            .toCurrentLanguage,
                                                        style: AppTextStyles
                                                            .bodySmallTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .bodyTextColor),
                                                      ),
                                                      /* <-------- 6px height gap --------> */
                                                      AppGaps.hGap6,
                                                      Text(
                                                        controller
                                                                .ridePrimaryDetails
                                                                .from
                                                                .address
                                                                .isEmpty
                                                            ? controller
                                                                .rideHistoryData
                                                                .from
                                                                .address
                                                            : controller
                                                                .ridePrimaryDetails
                                                                .from
                                                                .address,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppTextStyles
                                                            .bodyLargeMediumTextStyle,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            /* <-------- 5px height gap --------> */
                                            AppGaps.hGap5,
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 1,
                                                    color: AppColors
                                                        .formBorderColor,
                                                  ),
                                                ),
                                                Container(
                                                  width: 65,
                                                  height: 28,
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  decoration: ShapeDecoration(
                                                    color:
                                                        const Color(0xFF919BB3),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    controller
                                                        .ridePrimaryDetails
                                                        .distance
                                                        .text,
                                                    style: AppTextStyles
                                                        .bodySmallMediumTextStyle
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  )),
                                                ),
                                              ],
                                            ),
                                            /* <-------- 5px height gap --------> */
                                            AppGaps.hGap5,
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SvgPictureAssetWidget(
                                                  AppAssetImages
                                                      .pickLocationSVGLogoLine,
                                                  height: 16,
                                                  width: 16,
                                                  color:
                                                      AppColors.bodyTextColor,
                                                ),
                                                /* <-------- 6px width gap --------> */
                                                AppGaps.wGap6,
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppLanguageTranslation
                                                            .dropLocationTranskey
                                                            .toCurrentLanguage,
                                                        style: AppTextStyles
                                                            .bodySmallTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .bodyTextColor),
                                                      ),
                                                      /* <-------- 4px height gap --------> */
                                                      AppGaps.hGap4,
                                                      Text(
                                                        controller
                                                                .ridePrimaryDetails
                                                                .to
                                                                .address
                                                                .isEmpty
                                                            ? controller
                                                                .rideHistoryData
                                                                .to
                                                                .address
                                                            : controller
                                                                .ridePrimaryDetails
                                                                .to
                                                                .address,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppTextStyles
                                                            .bodyLargeMediumTextStyle,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ]),
                                        ),
                                      )
                                    ],
                                  ),
                                  /* <-------- 24px height gap --------> */
                                  AppGaps.hGap24,
                                  if (controller.paymentId.isNotEmpty ||
                                      controller.ridePrimaryDetails.payment
                                              .method ==
                                          'cash')
                                    Text(
                                      AppLanguageTranslation
                                          .paymentMethodTranskey
                                          .toCurrentLanguage,
                                      style: AppTextStyles
                                          .bodyLargeMediumTextStyle,
                                    ),
                                  /* <-------- 8px height gap --------> */
                                  AppGaps.hGap8,
                                  if (controller.paymentId.isNotEmpty ||
                                      controller.ridePrimaryDetails.payment
                                              .method ==
                                          'cash')
                                    RawButtonWidget(
                                      borderRadiusValue: 8,
                                      child: Container(
                                        height: 50,
                                        width: 105,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Center(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              controller.ridePrimaryDetails
                                                          .payment.method ==
                                                      'wallet'
                                                  ? const Icon(
                                                      Icons.attach_money,
                                                      size: 24,
                                                    )
                                                  : controller.ridePrimaryDetails
                                                              .payment.method ==
                                                          'paypal'
                                                      ? const Icon(
                                                          Icons.paypal,
                                                          size: 24,
                                                        )
                                                      : const Icon(
                                                          Icons.money,
                                                          size: 24,
                                                        ),
                                              /* SvgPictureAssetWidget(
                                                    AppAssetImages
                                                        .dollarSVGLogoSolid), */
                                              /* <-------- 6px width gap --------> */
                                              AppGaps.wGap6,
                                              Text(
                                                controller.ridePrimaryDetails
                                                    .payment.method
                                                    .toUpperCase(),
                                                style: AppTextStyles
                                                    .bodyLargeMediumTextStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  if (controller.paymentId.isNotEmpty ||
                                      controller.ridePrimaryDetails.payment
                                              .method ==
                                          'cash')
                                    AppGaps.hGap18,
                                  if (controller.paymentId.isNotEmpty ||
                                      controller.ridePrimaryDetails.payment
                                              .method ==
                                          'cash')
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          padding: const EdgeInsets.all(16),
                                          height: 205,
                                          decoration: const BoxDecoration(
                                            color: AppColors.formInnerColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AppLanguageTranslation
                                                    .fareDetailsTranskey
                                                    .toCurrentLanguage,
                                                style: AppTextStyles
                                                    .bodyLargeBoldTextStyle,
                                              ),
                                              AppGaps.hGap8,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      AppLanguageTranslation
                                                          .fareTranskey
                                                          .toCurrentLanguage,
                                                      style: AppTextStyles
                                                          .bodyTextStyle,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        controller
                                                            .userDetailsData
                                                            .currency
                                                            .symbol,
                                                        style: AppTextStyles
                                                            .bodyTextStyle,
                                                      ),
                                                      /* <-------- 2px width gap --------> */
                                                      AppGaps.wGap2,
                                                      Text(
                                                        controller
                                                            .ridePrimaryDetails
                                                            .total
                                                            .toStringAsFixed(2),
                                                        style: AppTextStyles
                                                            .bodyTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              /* <-------- 8px height gap --------> */
                                              AppGaps.hGap8,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Expanded(
                                                    child: Text(
                                                      'Vat (5 % ) ',
                                                      style: AppTextStyles
                                                          .bodyTextStyle,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        controller
                                                            .userDetailsData
                                                            .currency
                                                            .symbol,
                                                        style: AppTextStyles
                                                            .bodyTextStyle,
                                                      ),
                                                      /* <-------- 2px height gap --------> */
                                                      AppGaps.wGap2,
                                                      Text(
                                                        0.toStringAsFixed(2),
                                                        style: AppTextStyles
                                                            .bodyTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              /* <-------- 8px height gap --------> */
                                              AppGaps.hGap8,
                                              const Row(
                                                children: [
                                                  Expanded(
                                                      child:
                                                          DottedHorizontalLine(
                                                    dashLength: 12,
                                                    dashGapLength: 4,
                                                    dashColor: AppColors
                                                        .formBorderColor,
                                                  )),
                                                ],
                                              ),
                                              /* <-------- 8px height gap --------> */
                                              AppGaps.hGap8,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      AppLanguageTranslation
                                                          .totalFareTranskey
                                                          .toCurrentLanguage,
                                                      style: AppTextStyles
                                                          .bodyLargeSemiboldTextStyle,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        controller
                                                            .userDetailsData
                                                            .currency
                                                            .symbol,
                                                        style: AppTextStyles
                                                            .bodyLargeSemiboldTextStyle,
                                                      ),
                                                      /* <-------- 2px width gap --------> */
                                                      AppGaps.wGap2,
                                                      Text(
                                                        controller
                                                            .ridePrimaryDetails
                                                            .total
                                                            .toStringAsFixed(2),
                                                        style: AppTextStyles
                                                            .bodyLargeSemiboldTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              if (controller.ridePrimaryDetails
                                                      .payment.method !=
                                                  'cash')
                                                /* <-------- 8px height gap --------> */
                                                AppGaps.hGap8,
                                              if (controller.ridePrimaryDetails
                                                      .payment.method !=
                                                  'cash')
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        AppLanguageTranslation
                                                            .paidTranskey
                                                            .toCurrentLanguage,
                                                        style: AppTextStyles
                                                            .bodySemiboldTextStyle,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          controller
                                                              .userDetailsData
                                                              .currency
                                                              .symbol,
                                                          style: AppTextStyles
                                                              .bodySemiboldTextStyle,
                                                        ),
                                                        /* <-------- 2px width gap --------> */
                                                        AppGaps.wGap2,
                                                        Text(
                                                          controller
                                                              .ridePrimaryDetails
                                                              .payment
                                                              .amount
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: AppTextStyles
                                                              .bodySemiboldTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              if (controller.ridePrimaryDetails
                                                      .payment.method !=
                                                  'cash')
                                                AppGaps.hGap8,
                                              if (controller.ridePrimaryDetails
                                                      .payment.method !=
                                                  'cash')
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        AppLanguageTranslation
                                                            .dueTranskey
                                                            .toCurrentLanguage,
                                                        style: AppTextStyles
                                                            .bodySemiboldTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .errorColor),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          controller
                                                              .userDetailsData
                                                              .currency
                                                              .symbol,
                                                          style: AppTextStyles
                                                              .bodySemiboldTextStyle
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .errorColor),
                                                        ),
                                                        /* <-------- 2px width gap --------> */
                                                        AppGaps.wGap2,
                                                        Text(
                                                          (controller.ridePrimaryDetails
                                                                      .total -
                                                                  controller
                                                                      .ridePrimaryDetails
                                                                      .payment
                                                                      .amount)
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: AppTextStyles
                                                              .bodySemiboldTextStyle
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .errorColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  /* <-------- 100px height gap --------> */
                                  AppGaps.hGap100,
                                ]),
                          ),
                        ))
                      ]),
                    ),
                  )
                ],
              ),
            )));
  }
}
