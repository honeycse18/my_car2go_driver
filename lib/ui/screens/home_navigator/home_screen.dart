import 'dart:developer';

import 'package:car2godriver/controller/home_screen_controller.dart';
import 'package:car2godriver/utils/app_singleton.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/screen_widget/down_arrow_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SampleItem? selectedMenu;
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<HomeScreenController>(
        global: false,
        init: HomeScreenController(),
        builder: (controller) => ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                /*  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40) */
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    bottom: 0,
                    child: Obx(() => GoogleMap(
                          mapType: MapType.normal,
                          mapToolbarEnabled: false,
                          zoomControlsEnabled: false,
                          myLocationEnabled: false,
                          myLocationButtonEnabled: true,
                          compassEnabled: true,
                          zoomGesturesEnabled: true,
                          initialCameraPosition:
                              AppSingleton.instance.defaultCameraPosition,
                          /* CameraPosition(
                          target: controller.currentLocation.value ??
                              const LatLng(22.8456, 89.5403),
                          zoom: 14.0,
                        ), */
                          markers: {
                            Marker(
                                markerId: const MarkerId('user_location'),
                                position: controller.userLocation.value,
                                icon: controller.myCarIcon ??
                                    BitmapDescriptor.defaultMarker),
                          },
                          polylines: controller.googleMapPolylines,
                          onMapCreated: controller.onGoogleMapCreated,
                          onTap: controller.onGoogleMapTap,
                        )),
                  ),
                  Positioned(
                      top: 24,
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        height: 55,
                        width: context.width - 45,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.formBorderColor),
                            color: const Color(0xFFDDE8E8),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.isOnlineOffline
                                  ? AppLanguageTranslation
                                      .onlineTranskey.toCurrentLanguage
                                  : AppLanguageTranslation
                                      .offlineTranskey.toCurrentLanguage,
                              style: AppTextStyles.notificationDateSection
                                  .copyWith(color: AppColors.primaryTextColor),
                            ),
                            SwitchWidget(
                                value: controller.isOnlineOffline,
                                onToggle: controller.onStatusUpdateToggle),
                          ],
                        ),
                      )),
                  Positioned(
                      top: 120,
                      right: 26,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: AppColors.backgroundColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: PopupMenuButton<SampleItem>(
                          icon: Image.asset(AppAssetImages.sosIconImage),
                          initialValue: selectedMenu,
                          onSelected: (SampleItem item) {
                            selectedMenu = item;
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<SampleItem>>[
                            PopupMenuItem<SampleItem>(
                              value: SampleItem.itemOne,
                              onTap: () async {
                                FlutterPhoneDirectCaller.callNumber(
                                    controller.policeData.helpline.police);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Police ',
                                      style: AppTextStyles.bodyMediumTextStyle
                                          .copyWith(
                                              color: AppColors.bodyTextColor)),
                                  Text(controller.policeData.helpline.police,
                                      style: AppTextStyles.bodyMediumTextStyle
                                          .copyWith(
                                              color:
                                                  AppColors.primaryTextColor)),
                                ],
                              ),
                            ),
                            PopupMenuItem<SampleItem>(
                              value: SampleItem.itemTwo,
                              onTap: () async {
                                FlutterPhoneDirectCaller.callNumber(
                                    controller.policeData.helpline.doctor);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Ambulance ',
                                      style: AppTextStyles.bodyMediumTextStyle
                                          .copyWith(
                                              color: AppColors.bodyTextColor)),
                                  Text(controller.policeData.helpline.doctor,
                                      style: AppTextStyles.bodyMediumTextStyle
                                          .copyWith(
                                              color:
                                                  AppColors.primaryTextColor)),
                                ],
                              ),
                            ),
                            PopupMenuItem<SampleItem>(
                              value: SampleItem.itemThree,
                              onTap: () async {
                                FlutterPhoneDirectCaller.callNumber(
                                    controller.policeData.helpline.support);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Support ',
                                      style: AppTextStyles.bodyMediumTextStyle
                                          .copyWith(
                                              color: AppColors.bodyTextColor)),
                                  Text(controller.policeData.helpline.support,
                                      style: AppTextStyles.bodyMediumTextStyle
                                          .copyWith(
                                              color:
                                                  AppColors.primaryTextColor)),
                                ],
                              ),
                            ),
                          ],
                        ), /* Center(
                          child: Image.asset(AppAssetImages.sosIconImage),
                        ), */
                      )),
                  Positioned(
                      bottom: 150,
                      right: 25,
                      width: context.width * 0.85,
                      /* <-------- Current Location --------> */
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: IconButtonWidget(
                              backgroundColor: Colors.white,
                              onTap: () {
                                controller.getCurrentLocation();
                                log('location tapped');
                              },
                              child: const SvgPictureAssetWidget(
                                  //=======location icon=======//
                                  AppAssetImages.currentLocationSVGLogoLine,
                                  color: AppColors.primaryColor),
                            ),
                          ),
                          /* <-------- 16px height gap --------> */
                          AppGaps.hGap16,
                          Obx(() => Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      height:
                                          controller.isTapped.value ? 110 : 208,
                                      decoration: const BoxDecoration(
                                          color: AppColors.formInnerColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 50,
                                                width: 50,
                                                /* <-------- Fetch user image from API --------> */
                                                child: CachedNetworkImageWidget(
                                                  imageURL: controller
                                                      .userDetailsData.image,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    15)),
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                              ),
                                              /* <-------- 12px width gap --------> */
                                              AppGaps.wGap12,
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        controller
                                                            .userDetailsData
                                                            .name,
                                                        maxLines: 1,
                                                        style: AppTextStyles
                                                            .bodyLargeSemiboldTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primaryTextColor)),
                                                    Text('★ 4.5 (120 reviews)',
                                                        maxLines: 1,
                                                        style: AppTextStyles
                                                            .bodyMediumTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primaryTextColor)),
                                                  ],
                                                ),
                                              ),
                                              /* <-------- 12px width gap --------> */
                                              AppGaps.wGap12,
                                              Column(
                                                children: [
                                                  Text(
                                                      AppLanguageTranslation
                                                          .balanaceTransKey
                                                          .toCurrentLanguage,
                                                      style: AppTextStyles
                                                          .bodySmallTextStyle
                                                          .copyWith(
                                                        color: AppColors
                                                            .bodyTextColor,
                                                      )),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          controller
                                                              .walletDetails
                                                              .currency
                                                              .symbol,
                                                          style: AppTextStyles
                                                              .bodyLargeSemiboldTextStyle
                                                              .copyWith(
                                                            color: AppColors
                                                                .primaryTextColor,
                                                          )),
                                                      /* <-------- 10px width gap --------> */
                                                      AppGaps.wGap10,
                                                      Text(
                                                          controller
                                                              .walletDetails
                                                              .balance
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: AppTextStyles
                                                              .bodyLargeSemiboldTextStyle
                                                              .copyWith(
                                                            color: AppColors
                                                                .primaryTextColor,
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          /* <-------- 5px height gap --------> */
                                          AppGaps.hGap5,
                                          RawButtonWidget(
                                            child: controller.isTapped.value
                                                ? const SizedBox(
                                                    height: 15,
                                                    width: 15,
                                                    child: SvgPictureAssetWidget(
                                                        AppAssetImages
                                                            .arrowDownSVGLogoLine),
                                                  )
                                                : const SizedBox(
                                                    height: 15,
                                                    width: 15,
                                                    child: SvgPictureAssetWidget(
                                                        AppAssetImages
                                                            .arrowUpSVGLogoLine),
                                                  ),
                                            onTap: () {
                                              controller.isTapped.value =
                                                  !controller.isTapped.value;
                                            },
                                          ),
                                          if (!controller.isTapped.value)
                                            /* <-------- 10px height gap --------> */
                                            AppGaps.hGap10,
                                          /* <-------- Driver trip details --------> */
                                          if (!controller.isTapped.value)
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              child: Row(
                                                children: [
                                                  DownArrowBox(
                                                      icon: Image.asset(
                                                        AppAssetImages
                                                            .distanceImage,
                                                        color: AppColors
                                                            .primaryColor,
                                                        height: 20,
                                                        width: 20,
                                                      ),
                                                      title:
                                                          '${controller.dashBoardData.distance / 1000} km',
                                                      text: AppLanguageTranslation
                                                          .totalDistanceTranskey
                                                          .toCurrentLanguage),
                                                  /* <-------- 15px width gap --------> */
                                                  AppGaps.wGap15,
                                                  DownArrowBox(
                                                      icon: Image.asset(
                                                        AppAssetImages
                                                            .tripsImage,
                                                        color: AppColors
                                                            .primaryColor,
                                                        height: 20,
                                                        width: 20,
                                                      ),
                                                      title: controller
                                                          .dashBoardData.rides
                                                          .toString(),
                                                      text: AppLanguageTranslation
                                                          .totalTripsTranskey
                                                          .toCurrentLanguage),
                                                  /* <-------- 15px width gap --------> */
                                                  AppGaps.wGap15,
                                                  DownArrowBox(
                                                      icon: Image.asset(
                                                        AppAssetImages
                                                            .expendImage,
                                                        color: AppColors
                                                            .primaryColor,
                                                        height: 20,
                                                        width: 20,
                                                      ),
                                                      title:
                                                          '${(controller.dashBoardData.duration / 36000).toStringAsFixed(2)} hr',
                                                      text: AppLanguageTranslation
                                                          .totalExpandTranskey
                                                          .toCurrentLanguage),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ))
                ],
              ),
            ));
  }
}
