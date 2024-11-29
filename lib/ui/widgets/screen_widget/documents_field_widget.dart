import 'dart:typed_data';

import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:flutter/material.dart';

class ImageDocumentFieldWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final dynamic imageData;
  final void Function()? onTap;
  final void Function()? onImageTap;

  const ImageDocumentFieldWidget({
    Key? key,
    required this.title,
    this.subTitle = '',
    this.onTap,
    this.onImageTap,
    this.imageData,
  }) : super(key: key);

  bool get isImageHasData {
    if (imageData is Uint8List) {
      return (imageData as Uint8List).isNotEmpty;
    }
    if (imageData is String) {
      return (imageData as String).isNotEmpty;
    }
    return false;
  }

  bool get isImageHasNoData => isImageHasData == false;

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      onTap: onTap,
      borderRadiusValue: 8,
      child: Container(
        constraints: const BoxConstraints(minHeight: 74),
        alignment: AlignmentDirectional.centerStart,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.formBorderColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HorizontalGap(40),
                  // if (isImageHasNoData)
                  Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child:
                          Image.asset(AppAssetImages.licenseImage, height: 16)),
                  /*               if (isImageHasData)
                    SizedBox.square(
                        dimension: 64,
                        child: RawButtonWidget(
                            onTap: onImageTap,
                            borderRadiusValue: 8,
                            child: MixedImageWidget(
                              imageData: imageData,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ))), */
                  const HorizontalGap(8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style:
                            AppTextStyles.bodyLargeSemiboldTextStyle.copyWith(
                          color: AppColors.primaryTextColor,
                        ),
                      ),
                      Text(
                        subTitle,
                        style: AppTextStyles.bodySmallTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                    ],
                  ),
                  const Spacer(),
                  TightSmallTextButtonWidget(
                      onTap: onImageTap,
                      text: 'Click to view',
                      textStyle: AppTextStyles.bodyMediumTextStyle.copyWith(
                          fontSize: 16, decoration: TextDecoration.underline)),
                  const HorizontalGap(12),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
