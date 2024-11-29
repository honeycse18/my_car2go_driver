import 'dart:developer';
import 'dart:io';

import 'package:car2godriver/controller/select_location_screen_controller.dart';
import 'package:car2godriver/utils/app_singleton.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class SelectLocationScreen extends StatelessWidget {
  const SelectLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<SelectLocationScreenController>(
        global: false,
        init: SelectLocationScreenController(),
        builder: (controller) => Scaffold(
              extendBodyBehindAppBar: false,
              extendBody: true,
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText:
                      AppLanguageTranslation.selectTransKey.toCurrentLanguage,
                  hasBackButton: true),
              /* <-------- Body Content --------> */
              body: Container(
                height: screenHeight,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: 0,
                      child: Container(
                        width: screenWidth,
                        height: screenHeight * 0.28,
                        decoration: const ShapeDecoration(
                          color: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 118),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: screenWidth,
                          // height: screenHeight * 0.85,
                          decoration: const ShapeDecoration(
                            color: AppColors.primaryButtonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            child: GoogleMap(
                              myLocationButtonEnabled: false,
                              mapType: MapType.normal,
                              mapToolbarEnabled: false,
                              zoomControlsEnabled: false,
                              initialCameraPosition:
                                  AppSingleton.instance.defaultCameraPosition,
                              markers: controller.googleMapMarkers,
                              onMapCreated: controller.onGoogleMapCreated,
                              onTap: controller.onGoogleMapTap,
                            ),
                          ),
                        ),
                      ),
                    )),
                    // if (controller.mapMarked)
                    if (controller.shouldShowConfirmLocation)
                      Positioned(
                          bottom: 10,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CustomStretchedButtonWidget(
                              onTap: controller.onConfirmLocationButtonTap,
                              child: Text(AppLanguageTranslation
                                  .confirmLocationTransKey.toCurrentLanguage),
                            ),
                          )),
                    if (controller.showCurrentLocation)
                      Positioned(
                        right: 30,
                        bottom: controller.mapMarked ? 150 : 30,
                        child: GestureDetector(
                          onTap: () => controller.getCurrentPosition(context),
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SvgPictureAssetWidget(
                                    AppAssetImages.currentLocationSVGLogoLine),
                              )),
                        ),
                      ),
                    ScaffoldBodyWidget(
                        child: Column(children: [
                      if (Platform.isIOS) AppGaps.hGap60,
                      if (Platform.isAndroid) AppGaps.hGap30,
/*                       Center(
                          child: TypeAheadField(
                        errorBuilder: (context, error) => Center(
                          child: Text(
                            AppLanguageTranslation
                                .confirmLocationTransKey.toCurrentLanguage,
                            style: TextStyle(color: AppColors.errorColor),
                          ),
                        ),
                        textFieldConfiguration: TextFieldConfiguration(
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                            hintText: controller.screenTitle,
                            prefix: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: SvgPictureAssetWidget(
                                  AppAssetImages.currentLocationSVGLogoLine),
                            ),
                          ),
                          onTap: () {
                            controller.keyBoardHidden =
                                !controller.keyBoardHidden;
                            if (controller.keyBoardHidden) {
                              Helper.hideKeyBoard();
                            }
                          },
                          focusNode: controller.focusSearchBox,
                          controller: controller.locationTextEditingController,
                          onTapOutside: (event) => Helper.hideKeyBoard(),
                        ),
                        itemBuilder: (context, Prediction suggestion) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(children: [
                              const Icon(
                                Icons.location_on,
                                color: AppColors.bodyTextColor,
                              ),
                              /* <-------- 10px width gap --------> */
                              AppGaps.wGap10,
                              Expanded(
                                child: Text(suggestion.description!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColors.bodyTextColor,
                                      fontSize: 15,
                                    )),
                              ),
                            ]),
                          );
                        },
                        itemSeparatorBuilder: (context, index) => Container(
                          height: 1,
                          color: AppColors.bodyTextColor,
                        ),
                        suggestionsCallback: (pattern) async {
                          return await controller.searchLocation(
                              context, pattern);
                        },
                        onSuggestionSelected: (Prediction suggestion) {
                          log('${AppLanguageTranslation.myLocationIsTransKey.toCurrentLanguage} ${suggestion.description!}');
                          controller.setLocation(
                              suggestion.placeId!,
                              suggestion.description!,
                              controller.googleMapController);
                        },
                      )), */
                      AppAutocompleteWidget<Prediction>(
                        focusNode: controller.focusSearchBox,
                        textEditingController:
                            controller.locationTextEditingController,
                        isLoading: controller.isLoading,
                        prefixIcon: const SvgPictureAssetWidget(
                            AppAssetImages.currentLocationSVGLogoLine),
                        hintText: controller.screenTitle,
                        optionsBuilder: (query) async {
                          controller.getSearchLocations(
                              query: query, context: context);
                          return await controller.searchOptions.future;
                        },
                        optionWidget: (option, isHighlighted) => Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.bodyTextColor,
                            ),
                            /* <-------- 10px width gap --------> */
                            AppGaps.wGap10,
                            Expanded(
                              child: Text(option.description!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColors.bodyTextColor,
                                    fontSize: 15,
                                  )),
                            ),
                          ]),
                        ),
                        onOptionSelected: (option) {
                          log('${AppLanguageTranslation.myLocationIsTransKey.toCurrentLanguage} ${option.description!}');
                          controller.setLocation(
                              option.placeId!,
                              option.description!,
                              controller.googleMapController);
                        },
                      ),
                    ]))
                  ],
                ),
              ),
            ));
  }
}
