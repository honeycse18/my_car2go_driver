import 'package:car2godriver/controller/add_vehicle_screen_controller.dart';
import 'package:car2godriver/models/enums.dart';
import 'package:car2godriver/models/local/profile_dynamic_field_widget_paramter.dart';
import 'package:car2godriver/ui/bottomsheets/vehicle_dynamic_field/vehicle_dynamic_field_bottomsheet.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/add_vehicle_tab_widget.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/screen_widget/document_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVehicleScreen extends StatelessWidget {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<AddVehicleScreenController>(
        global: true,
        init: AddVehicleScreenController(),
        builder: (controller) => CustomScaffold(
            /* <-------- AppBar --------> */
            appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                // hasBackButton: controller.back ? true : false,
                hasBackButton: controller.isVehicleRegisterForSignup == false,
                titleText: AppLanguageTranslation
                    .vehicleInformationTranskey.toCurrentLanguage),
            /* <-------- Body Content --------> */
            /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
            body: ScaffoldBodyWidget(
                child: Form(
              child: Column(children: [
                /* <-------- 16px height gap --------> */
                AppGaps.hGap16,
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                      child: GestureDetector(
                    child: AddVehicleTabWidget(
                      isLine: true,
                      // isSelected: controller.isFirstTabSelected,
                      tabIndex: 1,
                      tabName: 'Vehicle',
                      currentTab: AddVehicleTabState.vehicle,
                      selectedTab: controller.currentVehicleState,
                    ),
                    onTap: () {
                      // controller.addVehicleState.value =
                      //     AddVehicleTabState.vehicle;
                      controller.onTabTap(AddVehicleTabState.vehicle);
                    },
                  )),
                  AppGaps.wGap6,
                  Expanded(
                      child: GestureDetector(
                    onTap: controller.shouldNotGoToInformationStep
                        ? null
                        : () {
                            // controller.addVehicleState.value =
                            //     AddVehicleTabState.information;
                            controller.onTabTap(AddVehicleTabState.information);
                          },
                    child: AddVehicleTabWidget(
                      isLine: true,
                      // isSelected: controller.isSecondTabSelected,
                      tabIndex: 2,
                      tabName: 'Information',
                      currentTab: AddVehicleTabState.information,
                      selectedTab: controller.currentVehicleState,
                    ),
                  )),
                  if (controller.isVehicleRegisterForSignup) AppGaps.wGap6,
                  if (controller.isVehicleRegisterForSignup)
                    Expanded(
                        child: GestureDetector(
                      onTap: controller.shouldNotGoToDocumentsStep
                          ? null
                          : () {
                              // controller.addVehicleState.value =AddVehicleTabState.documents;
                              controller.onTabTap(AddVehicleTabState.documents);
                            },
                      child: AddVehicleTabWidget(
                        // isSelected: controller.isThirdTabSelected,
                        tabIndex: 3,
                        tabName: 'Documents',
                        currentTab: AddVehicleTabState.documents,
                        selectedTab: controller.currentVehicleState,
                      ),
                    )),
                ]),
                Expanded(
                    child: CustomScrollView(
                  slivers: [
                    /* <-------- 16px height gap --------> */
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap16,
                    ),
                    SliverToBoxAdapter(
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
                    const SliverToBoxAdapter(child: AppGaps.hGap16),
                    switch (controller.currentVehicleState) {
                      AddVehicleTabState.vehicle => SliverGrid.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: AppGaps.screenPaddingValue,
                                  mainAxisSpacing: AppGaps.screenPaddingValue,
                                  mainAxisExtent: 172,
                                  crossAxisCount: 2,
                                  childAspectRatio: 1),
                          itemCount: controller.vehicleCategories.length,
                          itemBuilder: (context, index) {
                            /// Per product data
                            final category = controller.vehicleCategories[
                                index]; /* <---- Wishlist item widget ----> */
                            return SelectVehicleCategory(
                                onTap: () => controller
                                    .onVehicleCategorySelected(category),
                                isSelected:
                                    controller.selectedVehicleCategory.id ==
                                        category.id,
                                vehicleCategoryName:
                                    '${category.name.capitalizeFirst}',
                                vehicleCategoryImage: category.image);
                          }),
                      AddVehicleTabState.information =>
                        const SliverToBoxAdapter(),
                      AddVehicleTabState.documents => SliverToBoxAdapter(
                          child: Column(
                            children: [
                              controller.selectedVehicleImageURLs.isEmpty
                                  ? MultiImageUploadSectionWidget(
                                      label: AppLanguageTranslation
                                          .vehicleImageTransKey
                                          .toCurrentLanguage,
                                      isRequired: true,
                                      imageURLs: controller.galleryImageURLs,
                                      onImageUploadTap:
                                          controller.onUploadAddVehicleImageTap,
                                    )
                                  : SelectedLocalImageWidget(
                                      label: AppLanguageTranslation
                                          .vehicleImageTransKey
                                          .toCurrentLanguage,
                                      isRequired: true,
                                      imageURLs: controller.galleryImageURLs,
                                      onImageUploadTap:
                                          controller.onUploadAddVehicleImageTap,
                                      imagesBytes:
                                          controller.selectedVehicleImageURLs,
                                      onImageDeleteTap: controller
                                          .onUploadDeleteVehicleImageTap,
                                    ),
                              /* <-------- 24px height gap --------> */
                              AppGaps.hGap24,
                              controller.selectedDocumentsImageURLs.isEmpty
                                  ? MultiImageUploadSectionWidget(
                                      label: AppLanguageTranslation
                                          .vehicleRegistrationDocumentsTransKey
                                          .toCurrentLanguage,
                                      isRequired: true,
                                      imageURLs: controller.galleryImageURLs,
                                      onImageUploadTap: () =>
                                          controller.onUploadAddVehicleImageTap(
                                              forVehicle: false),
                                    )
                                  : SelectedLocalImageWidget(
                                      label: AppLanguageTranslation
                                          .vehicleRegistrationDocumentsTransKey
                                          .toCurrentLanguage,
                                      isRequired: true,
                                      imageURLs: controller.galleryImageURLs,
                                      onImageUploadTap: () =>
                                          controller.onUploadAddVehicleImageTap(
                                              forVehicle: false),
                                      imagesBytes:
                                          controller.selectedDocumentsImageURLs,
                                      onImageDeleteTap: controller
                                          .onUploadDeleteDocumentImageTap,
                                    ),
                            ],
                          ),
                        ),
                    },
                    if (controller.currentVehicleState ==
                        AddVehicleTabState.information) ...[
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
                          labelText: AppLanguageTranslation
                              .modelTransKey.toCurrentLanguage,
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
                          controller:
                              controller.numberPlateTextEditingController,
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
                            onImageUploadTap:
                                controller.onUploadVehicleImagesTap,
                            onImageTap: controller.onVehicleImageTap,
                            onImageEditTap: controller.onEditVehicleImagesTap,
                            onImageDeleteTap:
                                controller.onDeleteVehicleImageTap),
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
                              title: dynamicFieldValue
                                  .vehicleFieldInfo.placeholder,
                              isRequired:
                                  dynamicFieldValue.vehicleFieldInfo.isRequired,
                              type: dynamicFieldValue
                                  .vehicleFieldInfo.typeAsSealedClass,
                              values: dynamicFieldValue.values,
                              onTap: () async {
                                final result = await Get.bottomSheet(
                                    isScrollControlled: true,
                                    const EditVehicleDynamicFieldBottomSheet(),
                                    settings: RouteSettings(
                                        arguments:
                                            ProfileDynamicFieldWidgetParameter(
                                                fieldDetails: dynamicFieldValue
                                                    .driverFieldInfo,
                                                valueDetails:
                                                    dynamicFieldValue)));

                                controller.update();
                                if (result is List<String>) {
                                  controller.dynamicFieldValues[index].values =
                                      result;
                                  controller.update();
                                }
                              });
                        },
                        separatorBuilder: (context, index) =>
                            const VerticalGap(24),
                        itemCount:
                            controller.dynamicFields.vehicleFields.length,
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
                    ]
                    // ...controller.currentOrderDetailsTabContentWidgets(controller.currentVehicleState),
                  ],
                ))
              ]),
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
                    child: switch (controller.currentVehicleState) {
                      AddVehicleTabState.vehicle =>
                        controller.isSubmitAddVehicleLoading.value
                            ? const EnrollPaymentButtonLoadingWidget()
                            : StretchedTextButtonWidget(
                                buttonText: AppLanguageTranslation
                                    .nextTranskey.toCurrentLanguage,
                                onTap: controller.shouldNotGoToInformationStep
                                    ? null
                                    : () async {
                                        // await submitOrderCreate();
                                        controller.onTabTap(
                                            AddVehicleTabState.information);
                                      }),
                      AddVehicleTabState.information =>
                        controller.isAddVehicleDetailsLoading.value
                            ? const EnrollPaymentButtonLoadingWidget()
                            : controller.isVehicleRegisterForSignup
                                ? StretchedTextButtonWidget(
                                    buttonText: AppLanguageTranslation
                                        .nextTranskey.toCurrentLanguage,
                                    onTap: controller.shouldNotGoToDocumentsStep
                                        ? null
                                        : () async {
                                            controller.currentVehicleState =
                                                AddVehicleTabState.documents;
                                            controller.onTabTap(
                                                AddVehicleTabState.documents);
                                          })
                                : StretchedTextButtonWidget(
                                    buttonText: AppLanguageTranslation
                                        .registerTransKey.toCurrentLanguage,
                                    onTap: controller.shouldNotRegisterVehicle
                                        ? null
                                        : controller.onRegisterVehicleTap),
                      AddVehicleTabState.documents =>
                        controller.isAddVehicleDetailsLoading.value
                            ? const EnrollPaymentButtonLoadingWidget()
                            : controller.carId.isNotEmpty
                                ? StretchedTextButtonWidget(
                                    buttonText: AppLanguageTranslation
                                        .updateInformationTranskey
                                        .toCurrentLanguage,
                                    onTap: controller.onUpdateButtonTap)
                                : StretchedTextButtonWidget(
                                    buttonText: AppLanguageTranslation
                                        .submitTranskey.toCurrentLanguage,
                                    isLoading: controller.isLoading,
                                    onTap: controller.shouldNotSubmit
                                        ? null
                                        : controller.onSubmitButtonTap),
                    },
                  ),
                ],
              ),
            )));
  }
}

class SelectVehicleCategory extends StatelessWidget {
  final bool isSelected;
  final String vehicleCategoryName;
  final String vehicleCategoryImage;
  final void Function()? onTap;

  const SelectVehicleCategory({
    super.key,
    this.onTap,
    required this.isSelected,
    required this.vehicleCategoryName,
    required this.vehicleCategoryImage,
  });

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      borderRadiusValue: 8,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.unSelectVehicleBorderColor),
            color: isSelected
                ? AppColors.selectVehicleColor
                : AppColors.unSelectVehicleColor),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 74,
              width: 74,
              /* <-------- Fetch user image from API --------> */
              child: CachedNetworkImageWidget(
                imageURL: vehicleCategoryImage,
                imageBuilder: (context, imageProvider) => Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.contain)),
                ),
              ),
            ),
            /* <-------- 10px height gap --------> */
            AppGaps.hGap10,
            Text(
              vehicleCategoryName,
              style: AppTextStyles.bodyLargeBoldTextStyle,
            ),
          ],
        )),
      ),
    );
  }
}
