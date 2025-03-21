import 'dart:developer';

import 'package:car2godriver/models/location_model.dart';
import 'package:car2godriver/models/screenParameters/offer_ride_bottomsheet_parameters.dart';
import 'package:car2godriver/models/screenParameters/select_screen_parameters.dart';
import 'package:car2godriver/models/screenParameters/share_ride_screen_parameter.dart';
import 'package:car2godriver/ui/screens/car_pooling/offer_ride_bottomsheet.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RideShareScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  bool isFindSelected = true;

  LocationModel? pickUpLocation;
  LocationModel? dropLocation;
  String testString = 'Ride Share Screen!';
  int seatSelected = 0;

  var selectedStartDate = DateTime.now().obs;
  var selectedStartTime = TimeOfDay.now().obs;
  var selectedEndDate = DateTime.now().obs;
  var selectedEndTime = TimeOfDay.now().obs;

  void updateSelectedStartDate(DateTime newDate) {
    selectedStartDate.value = newDate;
  }

  void updateSelectedStartTime(TimeOfDay newTime) {
    selectedStartTime.value = newTime;
  }

  void updateSelectedEndDate(DateTime endDate) {
    selectedEndDate.value = endDate;
  }

  void updateSelectedEndTime(TimeOfDay endTime) {
    selectedEndTime.value = endTime;
  }

  void onPickUpTap() async {
    dynamic result = await Get.toNamed(AppPageNames.selectLocationScreen,
        arguments: SelectLocationScreenParameters(
            locationModel: pickUpLocation, showCurrentLocationButton: true));
    if (result is LocationModel) {
      pickUpLocation = result;
      update();
    }
  }

  void onDropTap() async {
    dynamic result = await Get.toNamed(AppPageNames.selectLocationScreen,
        arguments: SelectLocationScreenParameters(
            locationModel: dropLocation, showCurrentLocationButton: false));
    if (result is LocationModel) {
      dropLocation = result;
      update();
    }
  }

  void onFindPassengersButtonTap() {
    log('Find Passengers Button got tapped!');
    // DateTime combinedDateTime = DateTime.now();
    if (pickUpLocation != null && seatSelected != 0) {
      /* final Map<String, dynamic> parameters = {
        'lat': pickUpLocation!.latitude,
        'lng': pickUpLocation!.longitude,
        'seats': seatSelected,
        'date': Helper.yyyyMMddFormattedDateTime(combinedDateTime)
      }; */
      Get.toNamed(AppPageNames.chooseYouNeedScreen,
          arguments: ShareRideScreenParameter(
              pickUpLocation: pickUpLocation!,
              dropLocation: dropLocation ?? LocationModel.empty(),
              date: selectedStartDate.value,
              type: 'passenger',
              totalSeat: seatSelected));
    } else {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .youMustFillOutPickUpLocationAndNumofSeatsTransKey
              .toCurrentLanguage);
    }
  }

  void onFindRideButtonTap() {
    log('Find Car Button got tapped!');
    if (pickUpLocation != null && seatSelected != 0) {
      /* final Map<String, dynamic> parameters = {
        'lat': pickUpLocation!.latitude,
        'lng': pickUpLocation!.longitude,
        'seats': seatSelected,
        'date': Helper.yyyyMMddFormattedDateTime(combinedDateTime)
      }; */
      Get.toNamed(AppPageNames.chooseYouNeedScreen,
          arguments: ShareRideScreenParameter(
              pickUpLocation: pickUpLocation!,
              dropLocation: dropLocation ?? LocationModel.empty(),
              date: selectedStartDate.value,
              type: 'vehicle',
              totalSeat: seatSelected));
    } else {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .youMustFillOutPickUpLocationAndNumofSeatsTransKey
              .toCurrentLanguage);
      return;
    }
  }

  /* <---- Next button tap ----> */
  void onNextButtonTap() {
    Get.bottomSheet(shareRideNextBottomSheet());
  }

  /* <---- Create ride button tap ----> */
  void onCreateRideButtonTap() {
    Get.bottomSheet(const OfferRideBottomSheet(),
        settings: RouteSettings(
            arguments: OfferRideBottomSheetParameters(
                pickUpLocation: pickUpLocation ?? LocationModel.empty(),
                dropLocation: dropLocation ?? LocationModel.empty(),
                isCreateOffer: true)));
  }

  /* <---- Offer ride button tap ----> */
  void onOfferRideButtonTap() {
    Get.bottomSheet(const OfferRideBottomSheet(),
        settings: RouteSettings(
            arguments: OfferRideBottomSheetParameters(
                pickUpLocation: pickUpLocation ?? LocationModel.empty(),
                dropLocation: dropLocation ?? LocationModel.empty(),
                isCreateOffer: false)));
  }

  /*<-----------Share ride tab widget ----------->*/
  Widget shareRideTabWidget(
      {String title = 'Title', bool isSelected = false, Function()? onTap}) {
    // final String title;
    // final bool isSelected;
    // final Function()? onTap;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget shareRideNextBottomSheet() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: AppColors.backgroundColor,
        ),
        height: 270,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: AppColors.backgroundColor,
              elevation: 0,
              centerTitle: true,
              title: Text('Offer Pool',
                  style: AppTextStyles.titleBoldTextStyle
                      .copyWith(color: AppColors.primaryTextColor)),
              leading: IconButton(
                icon: SvgPicture.asset(AppAssetImages.backButtonSVGLogoLine,
                    color: AppColors.primaryTextColor, height: 18, width: 18),
                onPressed: () => Get.back(),
              ),
            ),
            AppGaps.hGap24,
            Text(AppLanguageTranslation.whatDoYouWantTransKey.toCurrentLanguage,
                style: AppTextStyles.bodyLargeMediumTextStyle.copyWith(
                  color: AppColors.primaryTextColor,
                )),
            AppGaps.hGap16,
            Row(
              children: [
                Expanded(
                  child: CustomStretchedOutlinedButtonWidget(
                    onTap: onCreateRideButtonTap,
                    child: Text(
                      AppLanguageTranslation
                          .createARideTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodyLargeSemiboldTextStyle
                          .copyWith(color: AppColors.primaryTextColor),
                    ),
                  ),
                ),
                AppGaps.wGap16,
                Expanded(
                  child: StretchedTextButtonWidget(
                    onTap: onOfferRideButtonTap,
                    buttonText: AppLanguageTranslation
                        .offerARideTransKey.toCurrentLanguage,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
