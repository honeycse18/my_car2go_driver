import 'package:car2godriver/controller/accepted_request_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/accepted_ride_screen_widget.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AcceptedRideRequestScreen extends StatelessWidget {
  const AcceptedRideRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<AcceptedRequestScreenController>(
        init: AcceptedRequestScreenController(),
        global: false,
        builder: ((controller) => WillPopScope(
              onWillPop: () async {
                controller.dispose();
                return await Future.value(true);
              },
              child: CustomScaffold(
                // key: controller.bottomSheetFormKey,
                extendBodyBehindAppBar: true,
                extendBody: true,
                /* <-------- AppBar --------> */
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    titleText: AppLanguageTranslation
                        .rideDetailsTransKey.toCurrentLanguage,
                    hasBackButton: true),
                /* <-------- Body Content --------> */
                body: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      /* <-------- Loding map --------> */
                      Positioned.fill(
                        bottom: MediaQuery.of(context).size.height * 0.32,
                        child: GoogleMap(
                          myLocationButtonEnabled: false,
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
                                      (controller.cameraPosition.latitude) -
                                          7.7,
                                      controller.cameraPosition.longitude),
                                  zoom: controller.zoomLevel),
                          markers: controller.googleMapMarkers,
                          polylines: controller.googleMapPolyLines,
                          onMapCreated: controller.onGoogleMapCreated,
                          // onTap: controller.onGoogleMapTap,
                        ),
                      ),
                      /* Obx(
                        () => controller.rideAccepted.value
                            ?  */
                      SlidingUpPanel(
                          color: Colors.transparent,
                          boxShadow: null,
                          minHeight: screenHeight * 0.45,
                          maxHeight: controller.rideDetails.status != 'accepted'
                              ? screenHeight * 0.7
                              : screenHeight * 0.55,
                          panel: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 73.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40),
                                    ),
                                    color: AppColors.backgroundColor,
                                  ),
                                  child: Column(children: [
                                    /* <-------- 10px height gap --------> */
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
                                      child: ScaffoldBodyWidget(
                                          child: CustomScrollView(
                                        slivers: [
                                          controller.rideDetails.status ==
                                                  'accepted'
                                              ? SliverToBoxAdapter(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        '${AppLanguageTranslation.yourDriverIsComingInTranskey.toCurrentLanguage} ${controller.rideDetails.duration.text}',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .primaryTextColor),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : const SliverToBoxAdapter(
                                                  child: AppGaps.emptyGap),
                                          /* <-------- 12px height gap --------> */
                                          const SliverToBoxAdapter(
                                            child: AppGaps.hGap12,
                                          ),
                                          /* <-------- User message section --------> */
                                          SliverToBoxAdapter(
                                            child: AcceptedRideScreenWidget(
                                              onSendTap: () {
                                                Get.toNamed(
                                                    AppPageNames.chatScreen,
                                                    arguments: controller
                                                        .rideDetails.driver.id);
                                              },
                                              amount:
                                                  controller.rideDetails.total,
                                              distance: controller
                                                  .rideDetails.distance.text,
                                              duration: controller
                                                  .rideDetails.duration.text,
                                              dropLocation: controller
                                                  .rideDetails.to.address,
                                              pickLocation: controller
                                                  .rideDetails.from.address,
                                              rating: 4.5,
                                              userName: controller
                                                  .rideDetails.driver.name,
                                              userImage: controller
                                                  .rideDetails.driver.image,
                                              isRideNow: false,
                                            ),
                                          ),
                                          if ((controller.rideDetails.status !=
                                              'completed'))
                                            const SliverToBoxAdapter(
                                              child: Divider(),
                                            ),
                                          const SliverToBoxAdapter(
                                            child: AppGaps.hGap10,
                                          ),
                                          if ((controller.rideDetails.status !=
                                              'completed'))
                                            SliverToBoxAdapter(
                                              child: RawButtonWidget(
                                                borderRadiusValue: 8,
                                                onTap: controller
                                                    .onSelectPaymentmethod,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      PaymentMethodSelectWidget(
                                                        methodImage: controller
                                                            .getValues
                                                            .paymentImage,
                                                        methodName: controller
                                                            .getValues
                                                            .viewAbleName,
                                                      ),
                                                      Text(
                                                        AppLanguageTranslation
                                                            .selectPaymentMethodTranskey
                                                            .toCurrentLanguage,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .bodyTextColor),
                                                      ),
                                                      const SvgPictureAssetWidget(
                                                          AppAssetImages
                                                              .arrowUpRightSVGLogoLine)
                                                    ]),
                                              ),
                                            )
                                        ],
                                      )),
                                    ))
                                  ]),
                                ),
                              ),
                              /* <-------- User OTP section --------> */
                              Positioned(
                                  top: 0,
                                  left: 27,
                                  child: Container(
                                    width: 80,
                                    height: 64,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            controller.otp,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    AppColors.primaryTextColor),
                                          ),
                                          Text(
                                            AppLanguageTranslation
                                                .startOtpTransKey
                                                .toCurrentLanguage,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.bodyTextColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          ))
                    ],
                  ),
                ),
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                    backgroundColor: AppColors.backgroundColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomStretchedButtonWidget(
                          onTap: controller.rideDetails.status == 'started'
                              ? controller.onPaymentTap
                              : controller.rideDetails.status == 'completed'
                                  ? controller.submitReview
                                  : controller.onBottomButtonTap,
                          child: Text(controller.rideDetails.status == 'started'
                              ? AppLanguageTranslation
                                  .makePaymentTranskey.toCurrentLanguage
                              : controller.rideDetails.status == 'completed'
                                  ? AppLanguageTranslation
                                      .submitReviewTransKey.toCurrentLanguage
                                  : AppLanguageTranslation
                                      .cancelRideTranskey.toCurrentLanguage),
                        ),
                        /* AppGaps.hGap3,
                    CustomStretchedOnlyTextButtonWidget(
                      buttonText: 'Ride Now',
                      onTap: () {},
                    ), */
                      ],
                    )),
              ),
            )));
  }
}

class PaymentMethodSelectWidget extends StatelessWidget {
  final String methodName;
  final String methodImage;
  const PaymentMethodSelectWidget({
    super.key,
    required this.methodName,
    required this.methodImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 40,
          width: 40,
          /* <-------- Fetch user image from API --------> */
          child: CachedNetworkImageWidget(
            imageURL: methodImage,
            imageBuilder: (context, imageProvider) => Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: AppComponents.imageBorderRadius,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
          ),
        ),
        /* <-------- 8px height gap --------> */
        AppGaps.wGap8,
        Text(
          methodName,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryTextColor),
        ),
      ],
    );
  }
}
