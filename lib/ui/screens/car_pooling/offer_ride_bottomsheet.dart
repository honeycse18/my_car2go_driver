import 'package:car2godriver/controller/car_polling/offer-ride-bottom-sheet-controller.dart';
import 'package:car2godriver/models/api_responses/carpolling/all_categories_response.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OfferRideBottomSheet extends StatelessWidget {
  const OfferRideBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<OfferRideBottomSheetController>(
        init: OfferRideBottomSheetController(),
        builder: (controller) => ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: Container(
                height: controller.offerRideBottomSheetParameters.isCreateOffer
                    ? 760
                    : 590,
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
                decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TightIconButtonWidget(
                            onTap: () {
                              Get.back();
                            },
                            icon: const SizedBox(
                              height: 40,
                              width: 40,
                              child: Center(
                                  child: SvgPictureAssetWidget(
                                AppAssetImages.backButtonSVGLogoLine,
                                color: AppColors.primaryTextColor,
                              )),
                            ),
                          ),
                          Expanded(
                            child: Center(
                                child: Text(
                              controller.offerRideBottomSheetParameters
                                      .isCreateOffer
                                  ? AppLanguageTranslation
                                      .createARideTransKey.toCurrentLanguage
                                  : AppLanguageTranslation
                                      .offerARideTransKey.toCurrentLanguage,
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryTextColor),
                            )),
                          )
                        ],
                      ),
                      /* <-------- 24px height gap --------> */
                      AppGaps.hGap24,
                      /* <-------- For Picking up and drop location --------> */
                      PickupAndDropLocationPickerWidget(
                          pickUpText: controller.offerRideBottomSheetParameters
                              .pickUpLocation.address,
                          dropText: controller.offerRideBottomSheetParameters
                              .dropLocation.address),
                      /* <-------- 16px height gap --------> */
                      AppGaps.hGap16,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 24),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            const SvgPictureAssetWidget(
                                AppAssetImages.multiplePeopleSVGLogoLine),
                            /* <-------- 16px width gap --------> */
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
                                          color: AppColors.formBorderColor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Center(
                                        child: Text("-",
                                            style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.bodyTextColor)),
                                      ),
                                    ),
                                  ),
                                  Text(
                                      controller.seatSelected > 0
                                          ? '${controller.seatSelected.toString()} ${AppLanguageTranslation.seatTranskey.toCurrentLanguage}${controller.seatSelected > 1 ? "s" : ""}'
                                          : controller
                                                  .offerRideBottomSheetParameters
                                                  .isCreateOffer
                                              ? AppLanguageTranslation
                                                  .seatAvailableTranskey
                                                  .toCurrentLanguage
                                              : AppLanguageTranslation
                                                  .seatNeedTranskey
                                                  .toCurrentLanguage,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.bodyTextColor)),
                                  GestureDetector(
                                    onTap: () {
                                      if (controller.seatSelected < 15) {
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
                                                fontWeight: FontWeight.bold,
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
                      /* <-------- 16px height gap --------> */
                      AppGaps.hGap16,
                      /* <-------- Seat Price Input Field--------> */
                      CustomTextFormField(
                        labelText: controller
                                .offerRideBottomSheetParameters.isCreateOffer
                            ? AppLanguageTranslation
                                .perSeatPriceTranskey.toCurrentLanguage
                            : AppLanguageTranslation
                                .budgetPerSeatTranskey.toCurrentLanguage,
                        hintText: controller
                                .offerRideBottomSheetParameters.isCreateOffer
                            ? AppLanguageTranslation
                                .perSeatPriceTranskey.toCurrentLanguage
                            : AppLanguageTranslation
                                .budgetPerSeatTranskey.toCurrentLanguage,
                        textInputType: TextInputType.number,
                        controller: controller.seatPriceController,
                        prefixIcon: const SvgPictureAssetWidget(
                            AppAssetImages.calendar),
                      ),
                      /* <-------- 16px height gap --------> */
                      AppGaps.hGap16,
                      /* <-------- Start Date Input Field--------> */
                      CustomTextFormField(
                        labelText: AppLanguageTranslation
                            .selectDateTimeTranskey.toCurrentLanguage,
                        hintText: 'Start Date',
                        isReadOnly: true,
                        controller: TextEditingController(
                          text:
                              '${DateFormat('yyyy-MM-dd').format(controller.selectedDate.value)}      ${controller.selectedTime.value.hourOfPeriod} : ${controller.selectedTime.value.minute} ${controller.selectedTime.value.period.name}',
                        ),
                        prefixIcon: const SvgPictureAssetWidget(
                            AppAssetImages.calendar),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 100),
                          );
                          if (pickedDate != null) {
                            controller.updateSelectedStartDate(pickedDate);
                          }

                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            controller.updateSelectedStartTime(pickedTime);
                          }

                          controller.update();
                        },
                      ),
                      if (controller
                          .offerRideBottomSheetParameters.isCreateOffer)
                        /* <-------- 16px height gap --------> */
                        AppGaps.hGap16,
                      if (controller
                          .offerRideBottomSheetParameters.isCreateOffer)
                        /* <-------- Use Drop Down Widget For Seleting Category--------> */
                        DropdownButtonFormFieldWidget<AllCategoriesDoc>(
                            hintText: 'Select Category',
                            items: controller.categories,
                            getItemText: (p0) {
                              return p0.name;
                            },
                            onChanged: (value) {
                              controller.selectedCategory = value;
                              controller.update();
                            }),
                      if (controller
                          .offerRideBottomSheetParameters.isCreateOffer)
                        /* <-------- 16px height gap --------> */
                        AppGaps.hGap16,
                      if (controller
                          .offerRideBottomSheetParameters.isCreateOffer)
                        /* <-------- Vehicle Number Input Field--------> */
                        CustomTextFormField(
                          controller: controller.vehicleNumberController,
                          hintText: 'Vehicle Number',
                        ),
                      /* <-------- 21px height gap --------> */
                      AppGaps.hGap21,
                      /* <-------- Submit Button --------> */
                      StretchedTextButtonWidget(
                          onTap: controller.onSubmitButtonTap,
                          buttonText: AppLanguageTranslation
                              .submitTranskey.toCurrentLanguage)
                    ],
                  ),
                ),
              ),
            ));
  }
}
