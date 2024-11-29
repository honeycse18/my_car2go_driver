import 'package:car2godriver/controller/view_requests_screen_controller.dart';
import 'package:car2godriver/models/api_responses/carpolling/pulling_offer_details_response.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewRequestsScreen extends StatelessWidget {
  const ViewRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<ViewRequestsScreenController>(
        init: ViewRequestsScreenController(),
        builder: (controller) => WillPopScope(
            onWillPop: () async {
              controller.popScope();
              return await Future.value(true);
            },
            child: CustomScaffold(
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleWidget: Text(AppLanguageTranslation
                      .requestTransKey.toCurrentLanguage)),
              body: RefreshIndicator(
                onRefresh: () async {
                  controller.getRequestDetails();
                  controller.update();
                },
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(24),
                      sliver: SliverList.separated(
                        itemBuilder: (context, index) {
                          PullingOfferDetailsRequest request =
                              controller.requestDetails.pending[index];
                          return Container(
                            height: controller.requestDetails.type == 'vehicle'
                                ? 290
                                : 275,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: AppColors.formBorderColor),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 45,
                                      width: 45,
                                      /* <-------- Fetch user image from API --------> */
                                      child: CachedNetworkImageWidget(
                                        imageURL: request.user.image,
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
                                    ),
                                    /* <-------- 8px width gap --------> */
                                    AppGaps.wGap8,
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  request.user.name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .bodyLargeSemiboldTextStyle,
                                                ),
                                              ),
                                              if (controller
                                                      .requestDetails.type ==
                                                  "vehicle")
                                                AppGaps.wGap5,
                                              if (request.seats > 1 &&
                                                  controller.requestDetails
                                                          .type ==
                                                      "vehicle")
                                                const Text(
                                                  '+',
                                                  style: AppTextStyles
                                                      .bodyLargeSemiboldTextStyle,
                                                ),
                                              if (controller
                                                      .requestDetails.type ==
                                                  "vehicle")
                                                Expanded(
                                                  child: Row(
                                                    children: List.generate(
                                                        request.seats > 2
                                                            ? 3
                                                            : request.seats - 1,
                                                        (index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 1),
                                                        child: Container(
                                                          width:
                                                              19, // Adjust the size of the dot as needed
                                                          height: 19,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Color(
                                                                0xFFD9D9D9),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const SingleStarWidget(review: 3),
                                              AppGaps.wGap4,
                                              Text(
                                                '(531 ${controller.requestDetails.type == "vehicle" ? "Trips" : "Rides"})',
                                                style: AppTextStyles
                                                    .bodySmallTextStyle,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${Helper.getCurrencyFormattedWithDecimalAmountText(request.rate)} ',
                                              style: AppTextStyles
                                                  .bodySmallSemiboldTextStyle,
                                            ),
                                            Text(
                                              ' / ${AppLanguageTranslation.perSeatTranskey.toCurrentLanguage}',
                                              style: AppTextStyles
                                                  .bodySmallSemiboldTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor),
                                            ),
                                          ],
                                        ),
                                        /* <-------- 6px height gap --------> */
                                        AppGaps.hGap6,
                                        Row(
                                          children: [
                                            const SvgPictureAssetWidget(
                                              AppAssetImages.seat,
                                              height: 10,
                                              width: 10,
                                            ),
                                            Text(
                                              ' ${request.seats}  ${AppLanguageTranslation.seatTranskey.toCurrentLanguage}${request.seats > 1 ? "s" : ""} ${controller.requestDetails.type == "vehicle" ? 'Needed' : 'Available'}',
                                              style: AppTextStyles
                                                  .smallestSemiboldTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                /* <-------- 12px height gap --------> */
                                AppGaps.hGap12,
                                if (controller.requestDetails.type == 'vehicle')
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLanguageTranslation
                                            .startDateTimeTranskey
                                            .toCurrentLanguage,
                                        style: AppTextStyles.bodyLargeTextStyle
                                            .copyWith(
                                                color: AppColors.bodyTextColor),
                                      ),
                                      Text(
                                        Helper.ddMMMyyyyhhmmaFormattedDateTime(
                                            controller.requestDetails.date),
                                        style: AppTextStyles
                                            .bodyLargeMediumTextStyle
                                            .copyWith(
                                                color:
                                                    AppColors.primaryTextColor),
                                      )
                                    ],
                                  ),
                                if (controller.requestDetails.type == 'vehicle')
                                  /* <-------- 12px height gap --------> */
                                  AppGaps.hGap12,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SvgPictureAssetWidget(
                                      AppAssetImages.currentLocationSVGLogoLine,
                                      height: 16,
                                      width: 16,
                                    ),
                                    /* <-------- 4px width gap --------> */
                                    AppGaps.wGap4,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLanguageTranslation
                                                .pickUpLocationTranskey
                                                .toCurrentLanguage,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles
                                                .bodySmallTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .bodyTextColor),
                                          ),
                                          /* <-------- 4px height gap --------> */
                                          AppGaps.hGap4,
                                          Text(
                                            controller
                                                .requestDetails.from.address,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles
                                                .bodyLargeMediumTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                /* <-------- 12px height gap --------> */
                                AppGaps.hGap12,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SvgPictureAssetWidget(
                                      AppAssetImages.DropLocationSVGLogoLine,
                                      height: 16,
                                      width: 16,
                                    ),
                                    /* <-------- 4px width gap --------> */
                                    AppGaps.wGap4,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLanguageTranslation
                                                .dropLocationTranskey
                                                .toCurrentLanguage,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles
                                                .bodySmallTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .bodyTextColor),
                                          ),
                                          /* <-------- 4px height gap --------> */
                                          AppGaps.hGap4,
                                          Text(
                                            controller
                                                .requestDetails.to.address,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles
                                                .bodyLargeMediumTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    Expanded(
                                        child:
                                            CustomStretchedOutlinedButtonWidget(
                                                onTap: () => controller
                                                    .onRejectButtonTap(
                                                        request.id),
                                                child: Text(
                                                    AppLanguageTranslation
                                                        .rejectTranskey
                                                        .toCurrentLanguage,
                                                    style: const TextStyle(
                                                        color: AppColors
                                                            .primaryColor)))),
                                    /* <-------- 50px width gap --------> */
                                    AppGaps.wGap50,
                                    Expanded(
                                        /* <-------- For Accept Button Tap --------> */
                                        child: StretchedTextButtonWidget(
                                            onTap: () => controller
                                                .onAcceptButtonTap(request.id),
                                            buttonText: AppLanguageTranslation
                                                .acceptTransKey
                                                .toCurrentLanguage))
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => AppGaps.hGap16,
                        itemCount: controller.pendingRequests.length,
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
