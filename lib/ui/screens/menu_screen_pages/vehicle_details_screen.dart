import 'package:car2godriver/controller/menu_screen_controller/vehicle_details_info_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<DetailsVehicleScreenController>(
        global: false,
        init: DetailsVehicleScreenController(),
        builder: (controller) => CustomScaffold(
            /* <-------- AppBar --------> */
            appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: true,
                titleText: AppLanguageTranslation
                    .vehicleInformationTranskey.toCurrentLanguage),
            /* <-------- Body Content --------> */
            /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
            body: ScaffoldBodyWidget(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        /* <-------- 10px height gap --------> */
                        AppGaps.hGap10,
                        /* <-------- Category input field --------> */
                        CustomTextFormField(
                          isReadOnly: true,
                          labelText: AppLanguageTranslation
                              .categoryTransKey.toCurrentLanguage,
                          hintText: controller.vehicleDetailsItem.category.name,
                        ),
                        /* <-------- 16px height gap --------> */
                        AppGaps.hGap16,
                        /* <-------- Language input field --------> */
                        CustomTextFormField(
                          isReadOnly: true,
                          labelText: AppLanguageTranslation
                              .modelTransKey.toCurrentLanguage,
                          hintText: controller.vehicleDetailsItem.model,
                        ),
                        /* <-------- 16px height gap --------> */
                        AppGaps.hGap16,
                        /* <-------- Car model input field --------> */
                        CustomTextFormField(
                          isReadOnly: true,
                          labelText: AppLanguageTranslation
                              .modelYearTransKey.toCurrentLanguage,
                          hintText: controller.vehicleDetailsItem.year,
                        ),
                        /* <-------- 16px height gap --------> */
                        AppGaps.hGap16,
                        /* <-------- Total Seat input field --------> */
                        CustomTextFormField(
                          isReadOnly: true,
                          labelText: AppLanguageTranslation
                              .seatsTranskey.toCurrentLanguage,
                          hintText:
                              controller.vehicleDetailsItem.capacity.toString(),
                        ),
                        /* <-------- 16px height gap --------> */
                        AppGaps.hGap16,
                        /* <-------- Car number plate input field --------> */
                        CustomTextFormField(
                          isReadOnly: true,
                          labelText: AppLanguageTranslation
                              .numberPlateTransKey.toCurrentLanguage,
                          hintText: controller.vehicleDetailsItem.vehicleNumber,
                        ),
                        /* <-------- 16px height gap --------> */
                        AppGaps.hGap16,
                        /* <-------- Car color input field --------> */
                        CustomTextFormField(
                          isReadOnly: true,
                          labelText: AppLanguageTranslation
                              .colorTransKey.toCurrentLanguage,
                          hintText:
                              controller.vehicleDetailsItem.color.toUpperCase(),
                        ),
                        /* <-------- 16px height gap --------> */
                        AppGaps.hGap16,
                        /* <-------- Car maxpower input field --------> */
                        CustomTextFormField(
                          isReadOnly: true,
                          labelText: AppLanguageTranslation
                              .maxPowerTransKey.toCurrentLanguage,
                          hintText: controller.vehicleDetailsItem.maxPower,
                        ),
                        /* <-------- 16px height gap --------> */
                        AppGaps.hGap16,
                        /* <-------- Car max Speed input field --------> */
                        CustomTextFormField(
                          isReadOnly: true,
                          labelText: AppLanguageTranslation
                              .maxSpeedTransKey.toCurrentLanguage,
                          hintText: controller.vehicleDetailsItem.maxSpeed,
                        ),
                        /* <-------- 16px height gap --------> */
                        AppGaps.hGap16,
                        /* <-------- Milage input field --------> */
                        CustomTextFormField(
                          isReadOnly: true,
                          labelText: AppLanguageTranslation
                              .milageTransKey.toCurrentLanguage,
                          hintText:
                              '${controller.vehicleDetailsItem.mileage} km/L',
                        ),
                        /* <-------- 16px height gap --------> */
                        AppGaps.hGap16,
                        /* <-------- Fuel type input field --------> */
                        CustomTextFormField(
                          isReadOnly: true,
                          labelText: AppLanguageTranslation
                              .fuelTypeTransKey.toCurrentLanguage,
                          hintText: controller.vehicleDetailsItem.fuelType,
                        ),
                        /* <-------- 16px height gap --------> */
                        AppGaps.hGap16,
                        /* <-------- Confirm air condition input field --------> */
                        CustomTextFormField(
                          isReadOnly: true,
                          labelText: AppLanguageTranslation
                              .airConditionTranskey.toCurrentLanguage,
                          hintText:
                              controller.vehicleDetailsItem.ac ? 'Yes' : 'No',
                        ),
                        /* <-------- 16px height gap --------> */
                        AppGaps.hGap16,
                      ],
                    ),
                  ),
                )),
              ],
            ))));
  }
}
