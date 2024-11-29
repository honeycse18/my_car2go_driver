import 'package:car2godriver/controller/menu_screen_controller/faqa_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqaScreen extends StatelessWidget {
  const FaqaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<FaqaScreenController>(
        init: FaqaScreenController(),
        global: false,
        builder: (controller) => CustomScaffold(
            /* <-------- AppBar --------> */
            appBar: CoreWidgets.appBarWidget(
              screenContext: context,
              titleText: AppLanguageTranslation.faqaTransKey.toCurrentLanguage,
              hasBackButton: true,
            ),
            /* <-------- Body Content --------> */
            body: Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Column(
                children: [
                  Expanded(
                    /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
                    child: ScaffoldBodyWidget(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(
                            AppLanguageTranslation
                                .faqaTransKey.toCurrentLanguage,
                            style: AppTextStyles.titleSemiSmallBoldTextStyle
                                .copyWith(color: Colors.black),
                          ),
                          /* <-------- 16px height gap --------> */
                          AppGaps.hGap16,
                          Expanded(
                              child: CustomScrollView(
                            slivers: [
                              /*  SliverToBoxAdapter(
                                child: Text(
                                  AppLanguageTranslation
                                      .faqaTransKey.toCurrentLanguage,
                                  style: AppTextStyles
                                      .titleSemiSmallBoldTextStyle
                                      .copyWith(color: Colors.black),
                                ),
                              ), */
                              const SliverToBoxAdapter(child: AppGaps.hGap5),
                              /* PagedSliverList.separated(
                                  pagingController:
                                      controller.faqPagingController,
                                  builderDelegate: PagedChildBuilderDelegate<
                                          FaqItems>(
                                      /* noItemsFoundIndicatorBuilder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  EmptyScreenWidget(
                                    height: 110,
                                    isSVGImage: true,
                                    localImageAssetURL:
                                        AppAssetImages.dropMarkerPngIcon,
                                    title: AppLanguageTranslation
                                        .youHaveNoUpcomingRequestsTranskey
                                        .toCurrentLanguage,
                                  ),
                                ],
                              );
                            }, */
                                      itemBuilder: (context, item, index) {
                                    final FaqItems faqItem = item;

                                    return ExpansionTileWidget(
                                      titleWidget: Text(faqItem.question),
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            child: Text(faqItem.answer))
                                      ],
                                    );
                                  }),
                                  separatorBuilder: (context, index)), */
                              SliverList.separated(
                                itemBuilder: (context, index) {
                                  final faqItem = controller.faqs[index];

                                  return ExpansionTileWidget(
                                    titleWidget: Text(faqItem.title),
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: Text(faqItem.description))
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    AppGaps.hGap16,
                                itemCount: controller.faqs.length,
                              ),
                              const SliverToBoxAdapter(child: AppGaps.hGap36),
                              SliverToBoxAdapter(
                                child: CustomStretchedButtonWidget(
                                  onTap: () async {
                                    await launchUrl(Uri.parse(
                                        "https://wa.me/${controller.faqData.whatsapp}"));
                                  },
                                  // onTap: controller.onContinueButtonTap,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/whatsapp.png'),
                                      /* <-------- 10px width gap --------> */
                                      AppGaps.wGap10,
                                      Text(AppLanguageTranslation
                                          .contactViaWhatsappTransKey
                                          .toCurrentLanguage)
                                    ],
                                  ),
                                ),
                              ),
                              const SliverToBoxAdapter(child: AppGaps.hGap16),
                              SliverToBoxAdapter(
                                  child: CustomStretchedOutlinedButtonWidget(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              'assets/images/Email.png'),
                                          /* <-------- 10px width gap --------> */
                                          AppGaps.wGap10,
                                          Text(
                                            AppLanguageTranslation
                                                .contactViaEmailTransKey
                                                .toCurrentLanguage,
                                            style: AppTextStyles
                                                .titleSemiSmallBoldTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .bodyTextColor),
                                          ),
                                        ],
                                      ),
                                      onTap: () async {
                                        /* controller.launchMailApp(
                                            controller.faqData.email); */

                                        await launchUrl(Uri.parse(
                                                'mailto:${controller.faqData.email}')
                                            .replace(queryParameters: {
                                          'subject': 'Example Subject',
                                          'body': 'Example Body',
                                        }));
                                      })),
                            ],
                          ) /* SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                
                                AppGaps.hGap10,
                                ExpansionTileWidget(
                                  titleWidget: Text(AppLanguageTranslation
                                      .howCanStartDrivingAppTransKey
                                      .toCurrentLanguage),
                                  children: [
                                    Text(AppLanguageTranslation
                                        .titleNumber1TransKey.toCurrentLanguage)
                                  ],
                                ),
                                AppGaps.hGap15,
                                ExpansionTileWidget(
                                  titleWidget: Text(AppLanguageTranslation
                                      .whenToDriveTransKey.toCurrentLanguage),
                                  children: [
                                    Text(AppLanguageTranslation
                                        .titleNumber1TransKey.toCurrentLanguage)
                                  ],
                                ),
                                AppGaps.hGap15,
                                ExpansionTileWidget(
                                  titleWidget: Text(AppLanguageTranslation
                                      .howWhenIGetPaidTransKey
                                      .toCurrentLanguage),
                                  children: [
                                    Text(AppLanguageTranslation
                                        .titleNumber1TransKey.toCurrentLanguage)
                                  ],
                                ),
                                AppGaps.hGap15,
                                ExpansionTileWidget(
                                  titleWidget: Text(AppLanguageTranslation
                                      .declineRideRequestTransKey
                                      .toCurrentLanguage),
                                  children: [
                                    Text(AppLanguageTranslation
                                        .titleNumber1TransKey.toCurrentLanguage)
                                  ],
                                ),
                                AppGaps.hGap15,
                                ExpansionTileWidget(
                                  titleWidget: Text(AppLanguageTranslation
                                      .howImproveDrivingRatingTransKey
                                      .toCurrentLanguage),
                                  children: [
                                    Text(AppLanguageTranslation
                                        .titleNumber1TransKey.toCurrentLanguage)
                                  ],
                                ),
                                /* AppGaps.hGap100,
                                Text(
                                  AppLanguageTranslation
                                      .contactCustomerServiceTransKey
                                      .toCurrentLanguage,
                                  style:
                                      AppTextStyles.titleSemiSmallBoldTextStyle,
                                ),
                                AppGaps.hGap15,
                                CustomStretchedButtonWidget(
                                  onTap: () {},
                                  // onTap: controller.onContinueButtonTap,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/whatsapp.png'),
                                      AppGaps.wGap10,
                                      Text(AppLanguageTranslation
                                          .contactViaWhatsappTransKey
                                          .toCurrentLanguage)
                                    ],
                                  ),
                                ), */
                                /* AppGaps.hGap20,
                                CustomStretchedOutlinedButtonWidget(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/Email.png'),
                                      AppGaps.wGap10,
                                      Text(
                                        AppLanguageTranslation
                                            .contactViaEmailTransKey
                                            .toCurrentLanguage,
                                        style: AppTextStyles
                                            .titleSemiSmallBoldTextStyle
                                            .copyWith(
                                                color: AppColors.bodyTextColor),
                                      ),
                                    ],
                                  ),
                                  onTap: () {}
                                  // onTap: controller
                                  //     .onMethodButtonTap /* () {
                                  //     // Get.toNamed(AppPageNames.emailLogInScreen);
                                  //   } */
                                  ,
                                ) */
                              ])) */
                              )
                        ])),
                  ),
                ],
              ),
            )));
  }
}
