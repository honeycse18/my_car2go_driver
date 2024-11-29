import 'package:car2godriver/models/sealed_classes/dynamic_field_type.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:flutter/material.dart';

class ProfileDocumentsItem extends StatelessWidget {
  final String title;
  //final String value;
  final void Function()? onTap;
  final void Function()? onUpdateButtonTap;
  final bool isUploaded;

  const ProfileDocumentsItem(
      {super.key,
      required this.title,
      //required this.value,
      required this.onTap,
      required this.onUpdateButtonTap,
      this.isUploaded = false});

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      onTap: onTap,
      borderRadiusValue: 8,
      child: Container(
        // height: 75,
        constraints: const BoxConstraints(minHeight: 75),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.fromBorderColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: AppTextStyles.bodySmallTextStyle.copyWith(
                          color: AppColors.bodyTextColor,
                        )),
                    const VerticalGap(5),
                    Text(isUploaded ? 'Uploaded' : 'Not uploaded',
                        style: AppTextStyles.bodyLargeMediumTextStyle.copyWith(
                          color: AppColors.secondaryButtonColor,
                        )),
                    // SizedBox(height: 5),
                    // Text(value,
                    //     style:
                    //         AppTextStyles.bodyLargeMediumTextStyle.copyWith(
                    //       color: AppColors.secondaryButtonColor,
                    //     )),
                  ],
                ),
              ),
              RawButtonWidget(
                onTap: onUpdateButtonTap,
                child: Text(
                  'Update',
                  style: AppTextStyles.bodyMediumTextStyle.copyWith(
                    decoration: TextDecoration.underline,
                    color: AppColors.secondaryButtonColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileDocumentsDynamicItem extends StatelessWidget {
  final String title;
  final DynamicFieldType type;
  final List<String> values;
  final bool isRequired;
  final void Function()? onTap;

  const ProfileDocumentsDynamicItem(
      {super.key,
      required this.title,
      required this.type,
      required this.values,
      this.onTap,
      this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      onTap: onTap,
      borderRadiusValue: 8,
      child: Container(
        constraints: const BoxConstraints(minHeight: 75),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.fromBorderColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text.rich(
                  TextSpan(children: [
                    TextSpan(text: title),
                    if (isRequired) const WidgetSpan(child: HorizontalGap(8)),
                    if (isRequired)
                      const TextSpan(
                          text: '* Required',
                          style: TextStyle(color: AppColors.alertColor))
                  ]),
                  style: AppTextStyles.bodySmallTextStyle.copyWith(
                    color: AppColors.bodyTextColor,
                  )),
              const VerticalGap(5),
              switch (type) {
                DynamicFieldImage() => switch (type) {
                    DynamicFieldSingleImage() => (values.firstOrNull == null) ||
                            (values.firstOrNull?.isEmpty ?? false)
                        ? Text('No image set',
                            style:
                                AppTextStyles.bodyLargeMediumTextStyle.copyWith(
                              color: AppColors.secondaryButtonColor,
                            ))
                        : MixedImageWidget(
                            imageData: values.firstOrNull,
                            imageBuilder: (context, imageProvider) => Container(
                                  constraints:
                                      const BoxConstraints(maxHeight: 100),
                                  decoration: BoxDecoration(
                                    borderRadius: AppComponents.defaultBorder,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: values.isEmpty
                                          ? BoxFit.contain
                                          : BoxFit.cover,
                                    ),
                                  ),
                                )),
                    DynamicFieldMultipleImage() => values.isEmpty
                        ? Text('No image set',
                            style:
                                AppTextStyles.bodyLargeMediumTextStyle.copyWith(
                              color: AppColors.secondaryButtonColor,
                            ))
                        : SizedBox(
                            height: 100,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final value = values[index];
                                  return SizedBox(
                                    width: 120,
                                    child: MixedImageWidget(
                                        imageData: value,
                                        imageBuilder: (context,
                                                imageProvider) =>
                                            Container(
                                              constraints: const BoxConstraints(
                                                  maxHeight: 100),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    AppComponents.defaultBorder,
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: values.isEmpty
                                                      ? BoxFit.contain
                                                      : BoxFit.cover,
                                                ),
                                              ),
                                            )),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const HorizontalGap(5),
                                itemCount: values.length),
                          ),
                    _ => (values.firstOrNull == null) ||
                            (values.firstOrNull?.isEmpty ?? false)
                        ? Text('No image set',
                            style:
                                AppTextStyles.bodyLargeMediumTextStyle.copyWith(
                              color: AppColors.secondaryButtonColor,
                            ))
                        : MixedImageWidget(
                            imageData: values.firstOrNull,
                            imageBuilder: (context, imageProvider) => Container(
                                  constraints:
                                      const BoxConstraints(maxHeight: 100),
                                  decoration: BoxDecoration(
                                    borderRadius: AppComponents.defaultBorder,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: values.isEmpty
                                          ? BoxFit.contain
                                          : BoxFit.cover,
                                    ),
                                  ),
                                ))
                  },
                _ => Text(values.firstOrNull ?? '',
                    style: AppTextStyles.bodyLargeMediumTextStyle.copyWith(
                      color: AppColors.secondaryButtonColor,
                    )),
              },
            ],
          ),
        ),
      ),
    );
  }
}
