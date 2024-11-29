import 'package:car2godriver/controller/car_polling/pulling_request_overview_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PoolingRequestOverviewScreen extends StatelessWidget {
  const PoolingRequestOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<PullingRequestOverviewController>(
        init: PullingRequestOverviewController(),
        global: false,
        builder: ((controller) => CustomScaffold(
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context, hasBackButton: true),
              body: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Stack(
                  children: [
                    Positioned.fill(
                      bottom: MediaQuery.of(context).size.height * 0.15,
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
                    SlidingUpPanel(
                        color: Colors.transparent,
                        boxShadow: null,
                        minHeight: 372,
                        maxHeight: 610,
                        panel: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 73.0),
                              child: Container(
                                margin: const EdgeInsets.only(right: 16),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                  color: AppColors.backgroundColor,
                                ),
                                child: Column(children: [
                                  AppGaps.hGap10,
                                  Container(
                                    width: 60,
                                    decoration: const ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 3,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: Color(0xFFA5A5A5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    /* <-------- Side padding for scaffold body contents  --------> */
                                    child: ScaffoldBodyWidget(
                                        child: CustomScrollView(
                                      slivers: [
                                        const SliverToBoxAdapter(
                                          /* <-------- 10px height gap --------> */
                                          child: AppGaps.hGap10,
                                        ),
                                        SliverToBoxAdapter(
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            height: 165,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14))),
                                            child: Column(children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
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
                                                            .bodyTextColor,
                                                      )),
                                                  Text(
                                                      Helper
                                                          .ddMMMyyyyhhmmaFormattedDateTime(
                                                              controller
                                                                  .requestDetails
                                                                  .date),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppTextStyles
                                                          .bodyLargeMediumTextStyle),
                                                ],
                                              ),
                                              /* <-------- 12px height gap --------> */
                                              AppGaps.hGap12,
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Column(
                                                    children: [
                                                      const SvgPictureAssetWidget(
                                                        AppAssetImages
                                                            .currentLocationSVGLogoLine,
                                                        height: 15,
                                                        width: 15,
                                                      ),
                                                      Container(
                                                        width: 3,
                                                        height: 17,
                                                        color: AppColors
                                                            .dividerColor,
                                                      )
                                                    ],
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
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                                              .requestDetails
                                                              .from
                                                              .address,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: AppTextStyles
                                                              .bodyLargeMediumTextStyle,
                                                        ),
                                                        /* <-------- 4px height gap --------> */
                                                        AppGaps.hGap4,
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 1,
                                                      color: AppColors
                                                          .formBorderColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 3,
                                                          height: 17,
                                                          color: AppColors
                                                              .dividerColor,
                                                        ),
                                                        const SvgPictureAssetWidget(
                                                          AppAssetImages
                                                              .DropLocationSVGLogoLine,
                                                          color: AppColors
                                                              .primaryColor,
                                                          height: 17,
                                                          width: 17,
                                                        ),
                                                      ]),
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
                                                              .dropLocationTranskey
                                                              .toCurrentLanguage,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                                              .requestDetails
                                                              .to
                                                              .address,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: AppTextStyles
                                                              .bodyLargeMediumTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]),
                                          ),
                                        ),
                                        const SliverToBoxAdapter(
                                          /* <-------- 24px height gap --------> */
                                          child: AppGaps.hGap24,
                                        ),
                                        SliverToBoxAdapter(
                                          child: Text(
                                            controller.requestDetails.type ==
                                                    AppLanguageTranslation
                                                        .vehicleTransKey
                                                        .toCurrentLanguage
                                                ? AppLanguageTranslation
                                                    .findDriverTranskey
                                                    .toCurrentLanguage
                                                : AppLanguageTranslation
                                                    .findPassengersTranskey
                                                    .toCurrentLanguage,
                                            style: AppTextStyles
                                                .notificationDateSection,
                                          ),
                                        ),
                                        const SliverToBoxAdapter(
                                          /* <-------- 12px height gap --------> */
                                          child: AppGaps.hGap12,
                                        ),
                                        SliverToBoxAdapter(
                                          child: Container(
                                            padding: const EdgeInsets.all(20),
                                            height: 90,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14))),
                                            child: Row(children: [
                                              SizedBox(
                                                height: 45,
                                                width: 45,
                                                /* <-------- Fetch user image from API --------> */
                                                child: CachedNetworkImageWidget(
                                                  imageURL: controller
                                                      .requestDetails
                                                      .user
                                                      .image,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                              ),
                                              /* <-------- 10px width gap --------> */
                                              AppGaps.wGap10,
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller.requestDetails
                                                          .user.name,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppTextStyles
                                                          .bodyLargeSemiboldTextStyle,
                                                    ),
                                                    /* <-------- 5px height gap --------> */
                                                    AppGaps.hGap5,
                                                    const Row(
                                                      children: [
                                                        /* <-------- Single Star wudget used for Rating --------> */
                                                        SingleStarWidget(
                                                            review: 4.9),
                                                        AppGaps.wGap4,
                                                        Text(
                                                          '(831 reviews)',
                                                          style: AppTextStyles
                                                              .smallestMediumTextStyle,
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        Helper.getCurrencyFormattedWithDecimalAmountText(
                                                            controller
                                                                .requestDetails
                                                                .rate
                                                                .toDouble()),
                                                        style: AppTextStyles
                                                            .bodyLargeSemiboldTextStyle,
                                                      ),
                                                      /* <-------- 4px width gap --------> */
                                                      AppGaps.wGap4,
                                                      Text(
                                                        '/${AppLanguageTranslation.perSeatTranskey.toCurrentLanguage}',
                                                        style: AppTextStyles
                                                            .bodyLargeSemiboldTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .bodyTextColor),
                                                      )
                                                    ],
                                                  ),
                                                  /* <-------- 4px height gap --------> */
                                                  AppGaps.hGap4,
                                                  Row(
                                                    children: [
                                                      const SvgPictureAssetWidget(
                                                          AppAssetImages.seat),
                                                      /* <-------- 5px width gap --------> */
                                                      AppGaps.wGap5,
                                                      Text(
                                                        '${controller.requestDetails.available}',
                                                        style: AppTextStyles
                                                            .bodySmallSemiboldTextStyle,
                                                      ),
                                                      /* <-------- 5px width gap --------> */
                                                      AppGaps.wGap5,
                                                      Text(
                                                        controller.requestDetails
                                                                    .type ==
                                                                AppLanguageTranslation
                                                                    .vehicleTransKey
                                                                    .toCurrentLanguage
                                                            ? AppLanguageTranslation
                                                                .seatAvailableTranskey
                                                                .toCurrentLanguage
                                                            : AppLanguageTranslation
                                                                .seatNeedTranskey
                                                                .toCurrentLanguage,
                                                        style: AppTextStyles
                                                            .bodySmallSemiboldTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .bodyTextColor),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ]),
                                          ),
                                        ),
                                        const SliverToBoxAdapter(
                                          /* <-------- 16px height gap --------> */
                                          child: AppGaps.hGap16,
                                        ),
                                        SliverToBoxAdapter(
                                          child: Row(
                                            children: [
                                              RawButtonWidget(
                                                child: Container(
                                                  height: 62,
                                                  width: 62,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                  child: const Center(
                                                    child: SvgPictureAssetWidget(
                                                        AppAssetImages
                                                            .callingSVGLogoSolid),
                                                  ),
                                                ),
                                                onTap: () {},
                                              ),
                                              /* <-------- 12px width gap --------> */
                                              AppGaps.wGap12,
                                              Expanded(
                                                  child:
                                                      /* <-------- Chat Input Field --------> */
                                                      CustomMessageTextFormField(
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppPageNames.chatScreen,
                                                      arguments: controller
                                                          .requestDetails
                                                          .user
                                                          .id);
                                                },
                                                isReadOnly: true,
                                                suffixIcon:
                                                    const SvgPictureAssetWidget(
                                                        AppAssetImages
                                                            .sendSVGLogoLine),
                                                boxHeight: 44,
                                                hintText: 'Type Message...',
                                              ))
                                            ],
                                          ),
                                        ),
                                        const SliverToBoxAdapter(
                                          /* <-------- 16px height gap --------> */
                                          child: AppGaps.hGap16,
                                        ),
                                        if (controller.requestDetails.type ==
                                            'vehicle')
                                          SliverToBoxAdapter(
                                            child: Text(
                                              AppLanguageTranslation
                                                  .coPassengersTranskey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .notificationDateSection,
                                            ),
                                          ),
                                        const SliverToBoxAdapter(
                                          /* <-------- 8px height gap --------> */
                                          child: AppGaps.hGap8,
                                        ),
                                        if (controller.requestDetails.type ==
                                            'vehicle')
                                          controller.requestDetails.requests
                                                  .isNotEmpty
                                              ? SliverGrid(
                                                  delegate:
                                                      SliverChildBuilderDelegate(
                                                    (BuildContext context,
                                                        int index) {
                                                      return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: const BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              height: 30,
                                                              width: 30,
                                                              child:
                                                                  /* <-------- Fetch user image from API --------> */
                                                                  CachedNetworkImageWidget(
                                                                imageURL: controller
                                                                    .requestDetails
                                                                    .user
                                                                    .image,
                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image: DecorationImage(
                                                                          image:
                                                                              imageProvider,
                                                                          fit: BoxFit
                                                                              .cover)),
                                                                ),
                                                              ),
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
                                                                    controller
                                                                        .requestDetails
                                                                        .user
                                                                        .name,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: AppTextStyles
                                                                        .bodyLargeSemiboldTextStyle,
                                                                  ),
                                                                  /* <-------- 5px height gap --------> */
                                                                  AppGaps.hGap5,
                                                                  const Row(
                                                                    children: [
                                                                      SingleStarWidget(
                                                                          review:
                                                                              4.9),
                                                                      AppGaps
                                                                          .wGap4,
                                                                      Text(
                                                                        '(831 reviews)',
                                                                        style: AppTextStyles
                                                                            .smallestMediumTextStyle,
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    childCount: controller
                                                        .requestDetails
                                                        .requests
                                                        .length,
                                                  ),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          childAspectRatio: 1,
                                                          crossAxisSpacing: 10,
                                                          mainAxisExtent: 70,
                                                          mainAxisSpacing: 10),
                                                )
                                              : SliverToBoxAdapter(
                                                  child: Center(
                                                  child: Text(
                                                    AppLanguageTranslation
                                                        .haveNoCoPassengerTranskey
                                                        .toCurrentLanguage,
                                                    style: AppTextStyles
                                                        .notificationDateSection
                                                        .copyWith(
                                                            color: AppColors
                                                                .bodyTextColor),
                                                  ),
                                                )),
                                        const SliverToBoxAdapter(
                                          /* <-------- 16px height gap --------> */
                                          child: AppGaps.hGap16,
                                        ),
                                        if (controller.requestDetails.type ==
                                            'vehicle')
                                          SliverToBoxAdapter(
                                            child: Text(
                                              AppLanguageTranslation
                                                  .vehicleInfoTranskey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .notificationDateSection,
                                            ),
                                          ),
                                        if (controller.requestDetails.type ==
                                            'vehicle')
                                          const SliverToBoxAdapter(
                                            child: AppGaps.hGap8,
                                          ),
                                        if (controller.requestDetails.type ==
                                            'vehicle')
                                          SliverToBoxAdapter(
                                              child: Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                height: 100,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                18))),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 80,
                                                      width: 80,
                                                      child:
                                                          CachedNetworkImageWidget(
                                                        imageURL: controller
                                                            .requestDetails
                                                            .category
                                                            .image,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          16)),
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                      ),
                                                    ),
                                                    /* <-------- 10px width gap --------> */
                                                    AppGaps.wGap10,
                                                    Expanded(
                                                        child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .requestDetails
                                                              .category
                                                              .name,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: AppTextStyles
                                                              .bodyLargeSemiboldTextStyle,
                                                        ),
                                                        Text(
                                                          controller
                                                              .requestDetails
                                                              .vehicleNumber,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: AppTextStyles
                                                              .bodyTextStyle
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .bodyTextColor),
                                                        ),
                                                      ],
                                                    ))
                                                  ],
                                                ),
                                              ))
                                            ],
                                          )),
                                        const SliverToBoxAdapter(
                                          /* <-------- 100px height gap --------> */
                                          child: AppGaps.hGap100,
                                        ),
                                      ],
                                    )),
                                  ))
                                ]),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              /* <-------- Bottom Navigation Bar --------> */
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  backgroundColor: AppColors.backgroundColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /* <-------- Request Ride Buton --------> */
                      CustomStretchedButtonWidget(
                        onTap: controller.onRequestRideButtonTap,
                        child: Text(AppLanguageTranslation
                            .requestRideTranskey.toCurrentLanguage),
                      ),
                    ],
                  )),
            )));
  }
}
