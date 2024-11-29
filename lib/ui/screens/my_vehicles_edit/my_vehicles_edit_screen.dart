import 'package:car2godriver/models/local/profile_dynamic_field_widget_paramter.dart';
import 'package:car2godriver/ui/screens/my_vehicles_edit/my_vehicles_edit_screen_controller.dart';
import 'package:car2godriver/ui/bottomsheets/vehicle_dynamic_field/vehicle_dynamic_field_bottomsheet.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/screen_widget/document_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyVehicleEditScreen extends StatelessWidget {
  const MyVehicleEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyVehicleEditScreenController>(
      init: MyVehicleEditScreenController(),
      builder: (controller) => CustomScaffold(
          /* <-------- AppBar --------> */
          appBar: CoreWidgets.appBarWidget(
              screenContext: context,
              // hasBackButton: controller.back ? true : false,
              hasBackButton: controller.isVehicleRegisterForSignup == false,
              titleText: 'Edit vehicle'),
          /* <-------- Body Content --------> */
          /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
          body: ScaffoldBodyWidget(
              child: CustomScrollView(
            slivers: [
              /* <-------- 16px height gap --------> */
              const SliverToBoxAdapter(child: VerticalGap(30)),
              // const SliverToBoxAdapter( child: AppGaps.hGap16,),
/*               SliverToBoxAdapter(
                child: switch (controller.currentVehicleState) {
                  AddVehicleTabState.vehicle => Text(
                      AppLanguageTranslation
                          .selectYourVehicleTransKey.toCurrentLanguage,
                      style: AppTextStyles.titleSemiboldTextStyle,
                    ),
                  AddVehicleTabState.information => Text(
                      AppLanguageTranslation
                          .vehicleInformationTranskey.toCurrentLanguage,
                      style: AppTextStyles.titleSemiboldTextStyle),
                  _ => AppGaps.emptyGap
                },
              ),
              /* <-------- 16px height gap --------> */
              const SliverToBoxAdapter(child: AppGaps.hGap16), */
              SliverToBoxAdapter(
                child: DropdownButtonFormFieldWidget(
                  labelText: AppLanguageTranslation
                      .brandNameTransKey.toCurrentLanguage,
                  isLoading: controller.isBrandLoading,
                  hintText: 'Select brand',
                  value: controller.selectedVehicleBrand,
                  items: controller.vehicleBrands,
                  getItemText: (item) => item.name,
                  onChanged: controller.onVehicleBrandSelected,
                ),
              ),
              const SliverToBoxAdapter(child: VerticalGap(20)),
              SliverToBoxAdapter(
                child: DropdownButtonFormFieldWidget(
                  labelText:
                      AppLanguageTranslation.modelTransKey.toCurrentLanguage,
                  hintText: 'Select model',
                  isLoading: controller.isModelLoading,
                  value: controller.selectedVehicleModel,
                  items: controller.vehicleModels,
                  getItemText: (item) => item.name,
                  onChanged: controller.onVehicleModelSelected,
                ),
              ),
              const SliverToBoxAdapter(child: VerticalGap(20)),
              SliverToBoxAdapter(
                child: DropdownButtonFormFieldWidget(
                  labelText: AppLanguageTranslation
                      .seatCapacityTransKey.toCurrentLanguage,
                  hintText: 'Select seat',
                  menuMaxHeight: 275,
                  value: controller.selectedSeatCount,
                  items: List.generate(
                    20,
                    (index) => index + 1,
                  ).toList(),
                  getItemText: (item) => item.toString(),
                  onChanged: controller.onVehicleSeatSelected,
                ),
              ),
              const SliverToBoxAdapter(child: VerticalGap(20)),
              SliverToBoxAdapter(
                child: CustomTextFormField(
                  isRequired: true,
                  isReadOnly: true,
                  controller: controller.yearController,
                  labelText: AppLanguageTranslation
                      .modelYearTransKey.toCurrentLanguage,
                  hintText: 'Select year',
                  onTap: () => controller.onYearTap(context),
                ),
              ),
              const SliverToBoxAdapter(child: VerticalGap(20)),
              /* <-------- car number plate input field --------> */
              SliverToBoxAdapter(
                child: CustomTextFormField(
                  isRequired: true,
                  textInputType: TextInputType.text,
                  controller: controller.numberPlateTextEditingController,
                  labelText: AppLanguageTranslation
                      .numberPlateTransKey.toCurrentLanguage,
                  hintText: 'e.g. 2AMDFS43',
                ),
              ),
              const SliverToBoxAdapter(child: VerticalGap(20)),

              SliverToBoxAdapter(
                child: MultiImageUploadSectionWidget(
                    label: 'Images',
                    imageURLs: controller.vehicleImages,
                    isRequired: true,
                    onImageUploadTap: controller.onUploadVehicleImagesTap,
                    onImageTap: controller.onVehicleImageTap,
                    onImageEditTap: controller.onEditVehicleImagesTap,
                    onImageDeleteTap: controller.onDeleteVehicleImageTap),
              ),
              const SliverToBoxAdapter(child: VerticalGap(20)),

              SliverToBoxAdapter(
                  child: Text(
                'Other fields',
                style: AppTextStyles.bodyLargeMediumTextStyle
                    .copyWith(fontSize: 18),
              )),
              const SliverToBoxAdapter(child: VerticalGap(20)),
              // Dynamic fields
              SliverList.separated(
                itemBuilder: (context, index) {
                  final dynamicFieldValue =
                      controller.dynamicFieldValues[index];
                  return ProfileDocumentsDynamicItem(
                      title: dynamicFieldValue.vehicleFieldInfo.placeholder,
                      isRequired: dynamicFieldValue.vehicleFieldInfo.isRequired,
                      type:
                          dynamicFieldValue.vehicleFieldInfo.typeAsSealedClass,
                      values: dynamicFieldValue.values,
                      onTap: () async {
                        final result = await Get.bottomSheet(
                            isScrollControlled: true,
                            const EditVehicleDynamicFieldBottomSheet(),
                            settings: RouteSettings(
                                arguments: ProfileDynamicFieldWidgetParameter(
                                    fieldDetails:
                                        dynamicFieldValue.driverFieldInfo,
                                    valueDetails: dynamicFieldValue)));

                        controller.update();
                        if (result is List<String>) {
                          controller.dynamicFieldValues[index].values = result;
                          controller.update();
                        }
                      });
                },
                separatorBuilder: (context, index) => const VerticalGap(24),
                itemCount: controller.dynamicFields.vehicleFields.length,
              ),

              /* <-------- car brand name input field --------> */

              /* CustomTextFormField(
                                  isRequired: true,
                                  controller: controller
                                      .vehicleNameTextEditingController,
                                  labelText: AppLanguageTranslation
                                      .brandNameTransKey.toCurrentLanguage,
                                  hintText: 'e.g. Tata',
                                ),
                                controller.selectedVehicleCategory.subcategories
                                        .isNotEmpty
                                    ? AppGaps.hGap16
                                    : AppGaps.emptyGap,
                                controller.selectedVehicleCategory.subcategories
                                        .isNotEmpty
                                    ? DropdownButtonFormFieldWidget<
                                        Subcategory>(
                                        hintText: controller
                                                .selectedVehicleCategory
                                                .subcategories
                                                .firstOrNull
                                                ?.name ??
                                            '',
                                        value: controller.selectedSubcategory,
                                        labelText:
                                            '${AppLanguageTranslation.selectTransKey.toCurrentLanguage} ${controller.selectedVehicleCategory.name} ${AppLanguageTranslation.categoriesTransKey.toCurrentLanguage}',
                                        items: controller
                                            .selectedVehicleCategory
                                            .subcategories,
                                        getItemText: (p0) => p0.name,
                                        onChanged: (selectedItem) {
                                          controller.selectedSubcategory =
                                              selectedItem;
                                          controller.update();
                                        },
                                      )
                                    : AppGaps.emptyGap, */
              /* <-------- 16px height gap --------> */
/*                                 AppGaps.hGap16,
                                /* <-------- Vahicle model input field --------> */
                                CustomTextFormField(
                                  isRequired: true,
                                  controller: controller
                                      .vehicleModelTextEditingController,
                                  labelText: AppLanguageTranslation
                                      .modelTransKey.toCurrentLanguage,
                                  hintText: 'e.g. Tata',
                                ),
                                /* <-------- 16x height gap --------> */
                                AppGaps.hGap16,
                                /* <-------- car model year input field --------> */
                                CustomTextFormField(
                                  isRequired: true,
                                  controller:
                                      controller.modelYearTextEditingController,
                                  labelText: AppLanguageTranslation
                                      .modelYearTransKey.toCurrentLanguage,
                                  hintText: 'eg: 2019',
                                ),
                                /* <-------- 16px height gap --------> */
                                AppGaps.hGap16,
                                /* <-------- 16px height gap --------> */
                                AppGaps.hGap16,
                                /* <-------- car color field --------> */
                                CustomTextFormField(
                                  isRequired: true,
                                  textInputType: TextInputType.text,
                                  controller: controller
                                      .vehicleColorTextEditingController,
                                  labelText: AppLanguageTranslation
                                      .vehicleColorTransKey.toCurrentLanguage,
                                  hintText: 'e.g. Red',
                                ),
                                /* DropdownButtonFormFieldWidget(
                                    hintText: 'e.g. Red',
                                    labelText: AppLanguageTranslation
                                        .vehicleColorTransKey.toCurrentLanguage,
                                    value: controller.selectedColor.isNotEmpty
                                        ? controller.selectedColor
                                        : '',
                                    items: const [
                                      'red',
                                      'green',
                                      'black',
                                      'blue'
                                    ],
                                    getItemText: (p0) =>
                                        '${p0.capitalizeFirst}',
                                    onChanged: (selectedItem) {
                                      controller.selectedColor =
                                          selectedItem ?? '';
                                    },
                                  ), */
                                /* <-------- 16px height gap --------> */
                                AppGaps.hGap16,
                                /* <-------- car max Power input field --------> */
                                /* CustomTextFormField(
                                    isRequired: true,
                                    textInputType: TextInputType.number,
                                    controller: controller
                                        .maxPowerTextEditingController,
                                    labelText: AppLanguageTranslation
                                        .maxPowerTransKey.toCurrentLanguage,
                                    hintText: 'e.g. 255 hp',
                                  ),
                                  /* <-------- 16px height gap --------> */
                                  AppGaps.hGap16, */
                                /* <-------- car max speed input field --------> */
                                /* CustomTextFormField(
                                    isRequired: true,
                                    textInputType: TextInputType.number,
                                    controller: controller
                                        .maxSpeedTextEditingController,
                                    labelText: AppLanguageTranslation
                                        .maxSpeedTransKey.toCurrentLanguage,
                                    hintText: 'e.g. 1000 km/h',
                                  ),
                                  /* <-------- 16px height gap --------> */
                                  AppGaps.hGap16, */
                                /* <-------- Seat capacity input field --------> */
                                CustomTextFormField(
                                  isRequired: true,
                                  textInputType: TextInputType.number,
                                  controller: controller
                                      .seatCapacityTextEditingController,
                                  labelText: AppLanguageTranslation
                                      .capacityTransKey.toCurrentLanguage,
                                  hintText: 'e.g. 4 seats',
                                ),
                                /* <-------- 16px height gap --------> */
                                /* AppGaps.hGap16,
                                  /* <-------- Fuel type field --------> */
                                  DropdownButtonFormFieldWidget(
                                    hintText: 'e.g. water',
                                    labelText: AppLanguageTranslation
                                        .fuelTypeTransKey.toCurrentLanguage,
                                    value:
                                        controller.selectedFuelType.isNotEmpty
                                            ? controller.selectedFuelType
                                            : null,
                                    items: const [
                                      'Octane',
                                      'Petrol',
                                      'Diesel',
                                      'Water',
                                      'Gas',
                                    ],
                                    getItemText: (p0) =>
                                        '${p0.capitalizeFirst}',
                                    onChanged: (selectedItem) {
                                      controller.selectedFuelType =
                                          selectedItem ?? '';
                                    },
                                  ), */
                                /* <-------- 16px height gap --------> */
                                /*    AppGaps.hGap16,
                                  /* <-------- milage input field --------> */
                                  CustomTextFormField(
                                    isRequired: true,
                                    textInputType: TextInputType.number,
                                    controller:
                                        controller.milageTextEditingController,
                                    labelText: AppLanguageTranslation
                                        .milageTransKey.toCurrentLanguage,
                                    hintText: 'e.g. 10',
                                  ), */
                                /* <-------- 16px height gap --------> */
                                AppGaps.hGap16,
                                /* <-------- Gear Type input field --------> */
                                DropdownButtonFormFieldWidget(
                                  labelText: AppLanguageTranslation
                                      .gearTypeTransKey.toCurrentLanguage,
                                  hintText: 'e.g. Manual',
                                  value: controller.selectedGearType.isNotEmpty
                                      ? controller.selectedGearType
                                      : '',
                                  items: controller.gearTypes,
                                  getItemText: (p0) => '${p0.capitalizeFirst}',
                                  onChanged: (selectedItem) {
                                    controller.selectedGearType =
                                        selectedItem ?? '';
                                  },
                                ),
                                /* <-------- 16px height gap --------> */
                                AppGaps.hGap16,
                                /* <-------- Ac eg input field --------> */
                                DropdownButtonFormFieldWidget(
                                  labelText: AppLanguageTranslation
                                      .acTransKey.toCurrentLanguage,
                                  hintText: 'e.g. yes',
                                  value: controller.hasAC ? 'Yes' : 'No',
                                  items: controller.hasAcs,
                                  getItemText: (p0) => '${p0.capitalizeFirst}',
                                  onChanged: (selectedItem) {
                                    controller.hasAC = selectedItem == 'Yes';
                                  },
                                ), */
              /* <-------- 100px height gap --------> */
              const SliverToBoxAdapter(child: VerticalGap(100)),

              // ...controller.currentOrderDetailsTabContentWidgets(controller.currentVehicleState),
            ],
          )),
          /* <-------- Bottom bar button --------> */
          bottomNavigationBar: CustomScaffoldBodyWidget(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    margin: const EdgeInsets.all(10),
                    child: StretchedTextButtonWidget(
                        isLoading: controller.isLoading,
                        buttonText: AppLanguageTranslation
                            .updateTransKey.toCurrentLanguage,
                        onTap: controller.shouldNotRegisterVehicle
                            ? null
                            : controller.onUpdateVehicleTap)),
              ],
            ),
          )),
    );
  }
}
