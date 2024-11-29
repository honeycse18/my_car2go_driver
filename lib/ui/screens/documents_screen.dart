import 'package:car2godriver/controller/setting_pages_controller/documents_screen.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocumentsScreenController>(
        init: DocumentsScreenController(),
        global: false,
        builder: (controller) => CustomScaffold(
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText:
                      AppLanguageTranslation.documentTranskey.toCurrentLanguage,
                  hasBackButton: true),
              body: ScaffoldBodyWidget(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Form(
                              key: controller.documentFormKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppGaps.hGap15,
                                  if (controller
                                      .userDetails.documents.isNotEmpty)
                                    CustomTextFormField(
                                      isReadOnly: true,
                                      // controller: controller.licenseNumberEditingController,
                                      labelText: AppLanguageTranslation
                                          .licenseNumberTransKey
                                          .toCurrentLanguage,
                                      hintText:
                                          controller.userDetails.licenseNo,
                                      prefixIcon: AppGaps.wGap10,
                                    ),
                                  if (controller
                                      .userDetails.documents.isNotEmpty)
                                    AppGaps.hGap24,
                                  if (controller
                                      .userDetails.documents.isNotEmpty)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                            AppLanguageTranslation
                                                .uploadedLicensePhotoTransKey
                                                .toCurrentLanguage,
                                            style:
                                                AppTextStyles.labelTextStyle),
                                      ],
                                    ),
                                  AppGaps.hGap24,
                                  if (controller.userDetails.documents.isEmpty)
                                    Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 120,
                                            width: 120,
                                            child: SvgPictureAssetWidget(
                                              color: AppColors.primaryColor,
                                              AppAssetImages.documentSvgIcon,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          AppGaps.hGap10,
                                          Text(
                                              AppLanguageTranslation
                                                  .noLicensePhotoUploadedTransKey
                                                  .toCurrentLanguage,
                                              style:
                                                  AppTextStyles.labelTextStyle),
                                        ],
                                      ),
                                    ),
                                  if (controller
                                      .userDetails.documents.isNotEmpty)
                                    UploadedLicenseFrontPhotoWithName(
                                      frontImage: controller
                                          .userDetails.documents.front,
                                    ),
                                  if (controller
                                      .userDetails.documents.isNotEmpty)
                                    AppGaps.hGap8,
                                  if (controller
                                      .userDetails.documents.isNotEmpty)
                                    UploadedLicenseBackPhotoWithName(
                                      backImage:
                                          controller.userDetails.documents.back,
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: CustomScaffoldBodyWidget(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  controller.userDetails.documents.isNotEmpty
                      ? CustomStretchedTextButtonWidget(
                          buttonText: AppLanguageTranslation
                              .editDocumentsTransKey.toCurrentLanguage,
                          onTap: () async {
                            await Get.toNamed(
                                AppPageNames.completeProfileScreen,
                                arguments: 'edit');
                            controller.getUserDetails();
                          },
                        )
                      : CustomStretchedTextButtonWidget(
                          buttonText: AppLanguageTranslation
                              .addDocumentsTransKey.toCurrentLanguage,
                          onTap: () async {
                            await Get.toNamed(
                                AppPageNames.completeProfileScreen,
                                arguments: 'edit');
                            controller.getUserDetails();
                          },
                        ),
                  AppGaps.hGap37,
                ],
              )),
            ));
  }
}

class UploadedLicenseFrontPhotoWithName extends StatelessWidget {
  final String frontImage;
  const UploadedLicenseFrontPhotoWithName({
    super.key,
    required this.frontImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: CustomRawListTileWidget(
        borderRadiusRadiusValue: const Radius.circular(18),
        onTap: () {
          Get.toNamed(AppPageNames.photoViewScreen, arguments: frontImage);
          // Show image preview
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  height: 60,
                  width: 90,
                  child: CachedNetworkImageWidget(
                    imageURL: frontImage,
                    imageBuilder: (context, imageProvider) => Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                    ),
                  ),
                ),
                AppGaps.wGap15,
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLanguageTranslation
                              .frontSideImageTransKey.toCurrentLanguage,
                          style: AppTextStyles.bodyLargeTextStyle,
                        ),
                        AppGaps.hGap3,
                        AppGaps.hGap3,
                        AppGaps.hGap5,
                        /* Text("200 KB",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryTextColor)),
                        AppGaps.hGap3, */
                        RawButtonWidget(
                          child: Text(
                              AppLanguageTranslation
                                  .clickToViewTransKey.toCurrentLanguage,
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor)),
                          onTap: () {
                            Get.toNamed(AppPageNames.photoViewScreen,
                                arguments: frontImage);
                          },
                        )
                      ]),
                ),
                AppGaps.wGap12,
                /* TightIconButtonWidget(
                  icon: SvgPicture.asset(AppAssetImages.trashSVGLogoLine),
                  onTap: () {
                    // Delete Button
                  },
                ), */
              ])
            ],
          ),
        ),
      ),
    );
  }
}

class UploadedLicenseBackPhotoWithName extends StatelessWidget {
  final String backImage;
  const UploadedLicenseBackPhotoWithName({
    super.key,
    required this.backImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: CustomRawListTileWidget(
        borderRadiusRadiusValue: const Radius.circular(18),
        onTap: () {
          Get.toNamed(AppPageNames.photoViewScreen, arguments: backImage);
          // Show image preview
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  height: 60,
                  width: 90,
                  child: CachedNetworkImageWidget(
                    imageURL: backImage,
                    imageBuilder: (context, imageProvider) => Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                    ),
                  ),
                ),
                AppGaps.wGap15,
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLanguageTranslation
                              .backSideImageTransKey.toCurrentLanguage,
                          style: AppTextStyles.bodyLargeTextStyle,
                        ),
                        AppGaps.hGap3,
                        AppGaps.hGap3,
                        AppGaps.hGap5,
                        /* Text("200 KB",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryTextColor)),
                        AppGaps.hGap3, */
                        RawButtonWidget(
                          child: Text(
                              AppLanguageTranslation
                                  .clickToViewTransKey.toCurrentLanguage,
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor)),
                          onTap: () {
                            Get.toNamed(AppPageNames.photoViewScreen,
                                arguments: backImage);
                          },
                        )
                      ]),
                ),
                AppGaps.wGap12,
                /* TightIconButtonWidget(
                  icon: SvgPicture.asset(AppAssetImages.trashSVGLogoLine),
                  onTap: () {
                    // Delete Button
                  },
                ), */
              ])
            ],
          ),
        ),
      ),
    );
  }
}
