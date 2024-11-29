import 'package:car2godriver/controller/menu_screen_controller/vehicle_details_information_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class VehicleDetailsInformationScreen extends StatelessWidget {
  const VehicleDetailsInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<VehicleDetailsInfoScreenController>(
        init: VehicleDetailsInfoScreenController(),
        builder: (controller) => CustomScaffold(
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                  hasBackButton: true,
                  screenContext: context,
                  titleText: AppLanguageTranslation
                      .vehicleInformationTranskey.toCurrentLanguage),
              /* <-------- Body Content --------> */
              /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
              body: CustomScaffoldBodyWidget(
                  child: Padding(
                padding: const EdgeInsets.only(left: 2.0, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* <-------- 30px height gap --------> */
                    AppGaps.hGap30,
                    Text(
                      AppLanguageTranslation.documentTranskey.toCurrentLanguage,
                      style: AppTextStyles.bodyLargeBoldTextStyle,
                    ),
                    /* <-------- 10px height gap --------> */
                    AppGaps.hGap10,
                    SizedBox(
                      height: 180,
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Container(
                            height: 160,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Row(
                              children: [
                                Expanded(
                                  child: PageView.builder(
                                    controller: controller.imageController,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller
                                        .vehicleDetailsItem.documents.length,
                                    itemBuilder: (context, index) {
                                      final documents = controller
                                          .vehicleDetailsItem.documents[index];
                                      return RawButtonWidget(
                                        onTap: () => Get.toNamed(
                                            AppPageNames.imageZoomScreen,
                                            arguments: documents),
                                        /* <-------- Fetch user image from API --------> */
                                        child: CachedNetworkImageWidget(
                                          imageURL: documents,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius: AppComponents
                                                    .imageBorderRadius,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: SmoothPageIndicator(
                              controller: controller.imageController,
                              count: controller
                                      .vehicleDetailsItem.documents.isEmpty
                                  ? 1
                                  : controller
                                      .vehicleDetailsItem.documents.length,
                              axisDirection: Axis.horizontal,
                              effect: ExpandingDotsEffect(
                                  dotHeight: 8,
                                  dotWidth: 8,
                                  spacing: 2,
                                  expansionFactor: 3,
                                  activeDotColor: AppColors.primaryColor,
                                  dotColor:
                                      AppColors.primaryColor.withOpacity(0.3)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ));
  }
}
