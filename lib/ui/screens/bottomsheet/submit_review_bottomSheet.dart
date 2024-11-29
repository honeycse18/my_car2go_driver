import 'package:car2godriver/controller/submit_review_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';

class SubmitReviewBottomSheetScreen extends StatelessWidget {
  const SubmitReviewBottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<SubmitReviewBottomSheetScreenController>(
        init: SubmitReviewBottomSheetScreenController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.only(
                top: 24,
              ),
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
              child: ScaffoldBodyWidget(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: controller.submitReviewFormKey,
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 2,
                          color: Colors.grey,
                        ),
                        /* <-------- 27px height gap --------> */
                        AppGaps.hGap27,
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Get.back(),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                                child: const Center(
                                    child: SvgPictureAssetWidget(
                                  AppAssetImages.arrowLeftSVGLogoLine,
                                  color: AppColors.primaryTextColor,
                                )),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              AppLanguageTranslation
                                  .submitReviewTransKey.toCurrentLanguage,
                              style: AppTextStyles.titleBoldTextStyle,
                            ),
                            /* <-------- 30px width gap --------> */
                            AppGaps.wGap30,
                            const Spacer(),
                          ],
                        ),
                        /* <-------- 20px height gap --------> */
                        AppGaps.hGap20,
                        Obx(
                          () => RatingBar.builder(
                            initialRating: controller.rating.value,
                            minRating: 0.5,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) =>
                                const SvgPictureAssetWidget(
                              AppAssetImages.starSVGLogoSolid,
                              color: AppColors.primaryColor,
                            ),
                            onRatingUpdate: controller.setRating,
                          ),
                        ),
                        /* <-------- 10px height gap --------> */
                        AppGaps.hGap10,
                        Obx(
                          () => Text(
                            controller.rating.value < 1
                                ? AppLanguageTranslation
                                    .weakTranskey.toCurrentLanguage
                                : controller.rating.value < 2
                                    ? AppLanguageTranslation
                                        .emergingTranskey.toCurrentLanguage
                                    : controller.rating.value < 3
                                        ? AppLanguageTranslation
                                            .goodTranskey.toCurrentLanguage
                                        : controller.rating.value < 4
                                            ? AppLanguageTranslation
                                                .strongTranskey
                                                .toCurrentLanguage
                                            : controller.rating.value < 5
                                                ? AppLanguageTranslation
                                                    .excellentTranskey
                                                    .toCurrentLanguage
                                                : AppLanguageTranslation
                                                    .bestTranskey
                                                    .toCurrentLanguage,
                            style: AppTextStyles.titleBoldTextStyle,
                          ),
                        ),
                        /* <-------- 10px height gap --------> */
                        AppGaps.hGap10,
                        Obx(
                          () => Text(
                            '${AppLanguageTranslation.youRatedTranskey.toCurrentLanguage} ${controller.rating.value} ${AppLanguageTranslation.starTranskey.toCurrentLanguage}',
                            style: AppTextStyles.bodyLargeMediumTextStyle
                                .copyWith(color: AppColors.bodyTextColor),
                          ),
                        ),
                        /* <-------- 30px height gap --------> */
                        AppGaps.hGap30,
                        /* <-------- Write Something About Your Experience Input Field--------> */
                        CustomTextFormField(
                          validator: Helper.textFormValidator,
                          controller: controller.commentTextEditingController,
                          labelText: AppLanguageTranslation
                              .writeSomethingAboutYourExperienceTranskey
                              .toCurrentLanguage,
                          hintText: 'Write Something........',
                          maxLines: 5,
                        ),
                        /* <-------- 30px height gap --------> */
                        AppGaps.hGap30,
                        /* <-------- Submit Rent Review Button --------> */
                        CustomStretchedButtonWidget(
                          onTap: controller.submitRentReview,
                          child: Text(AppLanguageTranslation
                              .submitReviewTransKey.toCurrentLanguage),
                        ),
                        /* <-------- 20px height gap --------> */
                        AppGaps.hGap20,
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
