import 'package:car2godriver/controller/car_polling/ride_share_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RideShareScreen extends StatelessWidget {
  const RideShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<RideShareScreenController>(
        init: RideShareScreenController(),
        global: false,
        builder: ((controller) => CustomScaffold(
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleText: AppLanguageTranslation
                      .carPoolingTranskey.toCurrentLanguage),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    /* <-------- 24px height gap --------> */
                    AppGaps.hGap24,
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: AppColors.formBorderColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: controller.shareRideTabWidget(
                                      isSelected: controller.isFindSelected,
                                      title: AppLanguageTranslation
                                          .findPoolTranskey.toCurrentLanguage,
                                      onTap: () {
                                        if (!controller.isFindSelected) {
                                          controller.isFindSelected =
                                              !controller.isFindSelected;
                                          controller.update();
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: controller.shareRideTabWidget(
                                      isSelected: !controller.isFindSelected,
                                      title: AppLanguageTranslation
                                          .offerPoolTranskey.toCurrentLanguage,
                                      onTap: () {
                                        if (controller.isFindSelected) {
                                          controller.isFindSelected =
                                              !controller.isFindSelected;
                                          controller.update();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            /* <-------- 24px height gap --------> */
                            AppGaps.hGap24,
                            /* <-------- pick and drop users --------> */
                            PickupAndDropLocationPickerWidget(
                              pickUpText:
                                  controller.pickUpLocation?.address ?? '',
                              dropText: controller.dropLocation?.address ?? '',
                              onPickUpTap: controller.onPickUpTap,
                              onDropTap: controller.onDropTap,
                            ),
                            if (controller.isFindSelected) AppGaps.hGap24,
                            if (controller.isFindSelected)
                              /* <-------- Select Date Input Field --------> */
                              CustomTextFormField(
                                labelText: AppLanguageTranslation
                                    .selectDateTranskey.toCurrentLanguage,
                                hintText: 'Start Date',
                                isReadOnly: true,
                                controller: TextEditingController(
                                  text: DateFormat('yyyy-MM-dd').format(controller
                                      .selectedStartDate
                                      .value) /*      ${controller.selectedStartTime.value.hourOfPeriod} : ${controller.selectedStartTime.value.minute} ${controller.selectedStartTime.value.period.name} */,
                                ),
                                prefixIcon: const SvgPictureAssetWidget(
                                    AppAssetImages.calendar),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate:
                                        DateTime(DateTime.now().year + 100),
                                  );
                                  if (pickedDate != null) {
                                    controller
                                        .updateSelectedStartDate(pickedDate);
                                  }

                                  /* final TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (pickedTime != null) {
                                    controller.updateSelectedStartTime(pickedTime);
                                  } */

                                  controller.update();
                                },
                              ),
                            /* <-------- 24px height gap --------> */
                            AppGaps.hGap24,
                            if (controller.isFindSelected)
                              Text(
                                AppLanguageTranslation
                                    .selectSeatTranskey.toCurrentLanguage,
                                style: AppTextStyles.labelTextStyle,
                              ),
                            if (controller.isFindSelected) AppGaps.hGap8,
                            if (controller.isFindSelected)
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.formBorderColor,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    const SvgPictureAssetWidget(AppAssetImages
                                        .multiplePeopleSVGLogoLine),
                                    /* <-------- 10px width gap --------> */
                                    AppGaps.wGap16,
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (controller.seatSelected > 1) {
                                                controller.seatSelected -= 1;
                                                controller.update();
                                              }
                                            },
                                            child: Container(
                                              height: 32,
                                              width: 32,
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppColors.formBorderColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: const Center(
                                                child: Text("-",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .bodyTextColor)),
                                              ),
                                            ),
                                          ),
                                          Text(
                                              controller.seatSelected > 0
                                                  ? '${controller.seatSelected.toString()} ${AppLanguageTranslation.seatTranskey.toCurrentLanguage}${controller.seatSelected > 1 ? "s" : ""}'
                                                  : AppLanguageTranslation
                                                      .seatAvailableTranskey
                                                      .toCurrentLanguage,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      AppColors.bodyTextColor)),
                                          GestureDetector(
                                            onTap: () {
                                              if (controller.seatSelected <
                                                  15) {
                                                controller.seatSelected += 1;
                                                controller.update();
                                              }
                                            },
                                            child: Container(
                                              height: 32,
                                              width: 32,
                                              decoration: BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: const Center(
                                                child: Text("+",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /* <-------- Bottom Navigation Bar --------> */
              bottomNavigationBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 10.0),
                    child: controller.isFindSelected
                        ? Row(
                            children: [
                              Expanded(
                                  /* <-------- Find Ride Button --------> */
                                  child: CustomStretchedOutlinedButtonWidget(
                                onTap: controller.onFindRideButtonTap,
                                child: Text(
                                  AppLanguageTranslation
                                      .findRideTranskey.toCurrentLanguage,
                                  style: AppTextStyles
                                      .bodyLargeSemiboldTextStyle
                                      .copyWith(
                                          color: AppColors.primaryTextColor),
                                ),
                              )),
                              /* <-------- 16px width gap --------> */
                              AppGaps.wGap16,
                              Expanded(
                                  /* <-------- Find Passengers Button --------> */
                                  child: StretchedTextButtonWidget(
                                buttonText: AppLanguageTranslation
                                    .findPassengersTranskey.toCurrentLanguage,
                                onTap: controller.onFindPassengersButtonTap,
                              )),
                            ],
                          )
                        : StretchedTextButtonWidget(
                            buttonText: AppLanguageTranslation
                                .nextTranskey.toCurrentLanguage,
                            onTap: controller.onNextButtonTap,
                          ),
                  ),
                  /* <-------- 10px height gap --------> */
                  AppGaps.hGap10
                ],
              ),
            )));
  }
}
