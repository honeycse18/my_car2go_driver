import 'package:car2godriver/controller/menu_screen_controller/about_us_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:stroke_text/stroke_text.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<AboutusScreenController>(
        init: AboutusScreenController(),
        builder: (controller) => CustomScaffold(
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleText:
                      AppLanguageTranslation.aboutUsTransKey.toCurrentLanguage),
              /* <-------- Body Content --------> */

              body: Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ScaffoldBodyWidget(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 179,
                                      /* <-------- Fetch user image from API --------> */
                                      child: CachedNetworkImageWidget(
                                        imageURL:
                                            'https://github.com/surjo976/Doremon/assets/82593116/27d9872c-154e-4c38-90b2-e1e5f43c02a4',
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              /* <-------- 24px height gap --------> */
                              AppGaps.hGap24,
                              Text(
                                AppLanguageTranslation
                                    .ourHistoryTransKey.toCurrentLanguage,
                                style: AppTextStyles.titleSemiboldTextStyle,
                              ),
                              /* <-------- 12px height gap --------> */
                              /*  AppGaps.hGap12,
                              Text(
                                controller
                                    .aboutUsTextItem.content.ourHistory.heading,
                                style: AppTextStyles.semiSmallXBoldTextStyle,
                              ), */
                              /* <-------- 10px height gap --------> */
                              AppGaps.hGap10,
                              /* <-------- About Us Content Heading Section --------> */

                              Text(
                                controller.aboutUsTextItem.content.ourHistory
                                    .description1,
                                textAlign: TextAlign.justify,
                              ),
                              /* <-------- 10px height gap --------> */
                              AppGaps.hGap10,
                              /* <-------- About Us Content Section --------> */

                              Text(
                                controller.aboutUsTextItem.content.ourHistory
                                    .description2,
                                textAlign: TextAlign.justify,
                              ),
                              /* <-------- 24px height gap --------> */
                              AppGaps.hGap24,
                              SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 175,
                                      width: 175,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: AppColors.formBorderColor),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const StrokeText(
                                              text: "6K+",
                                              textStyle: TextStyle(
                                                fontSize: 60,
                                              ),
                                              strokeColor: Colors.black,
                                              strokeWidth: 2,
                                            ),
                                            /* <-------- 15px height gap --------> */
                                            AppGaps.hGap15,
                                            Text(
                                              AppLanguageTranslation
                                                  .appDownloadsTransKey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .bodyBoldTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    /* <-------- 15px width gap --------> */
                                    AppGaps.wGap15,
                                    Container(
                                      height: 175,
                                      width: 175,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: AppColors.formBorderColor),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const StrokeText(
                                              text: "4K+",
                                              textStyle: TextStyle(
                                                  fontSize: 60,
                                                  color: Colors.black),
                                              strokeColor: Colors.white,
                                              strokeWidth: 4,
                                            ),
                                            /* <-------- 15px height gap --------> */
                                            AppGaps.hGap15,
                                            Text(
                                              AppLanguageTranslation
                                                  .activeRidesTransKey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .bodyBoldTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              /* <-------- 16px height gap --------> */
                              AppGaps.hGap16,
                              SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 175,
                                      width: 175,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: AppColors.formBorderColor),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const StrokeText(
                                              text: "30K+",
                                              textStyle: TextStyle(
                                                  fontSize: 60,
                                                  color: Colors.black),
                                              strokeColor: Colors.white,
                                              strokeWidth: 4,
                                            ),
                                            AppGaps.hGap15,
                                            Text(
                                              AppLanguageTranslation
                                                  .tripeOderSavedTranskey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .bodyBoldTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    /* <-------- 15px width gap --------> */
                                    AppGaps.wGap15,
                                    Container(
                                      height: 175,
                                      width: 175,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: AppColors.formBorderColor),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const StrokeText(
                                              text: "3K+",
                                              textStyle: TextStyle(
                                                fontSize: 60,
                                              ),
                                              strokeColor: Colors.black,
                                              strokeWidth: 2,
                                            ),
                                            AppGaps.hGap15,
                                            Text(
                                              AppLanguageTranslation
                                                  .activeUserTranskey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .bodyBoldTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              /* <-------- 30px height gap --------> */
                              AppGaps.hGap30,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /* <-------- Bottom bar of sign up text --------> */
            ));
  }
}
