import 'package:car2godriver/models/enums/my_vehicle_status.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingMyVehicleItemWidget extends StatelessWidget {
  const LoadingMyVehicleItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      child: RawButtonWidget(
        borderRadiusValue: 5,
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.formBorderColor),
              borderRadius: BorderRadius.circular(5)),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadingImagePlaceholderWidget(height: 80, width: 80),
                HorizontalGap(16),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoadingTextWidget(),
                    VerticalGap(8),
                    LoadingTextWidget(),
                    VerticalGap(5),
                    Wrap(
                      children: [
                        SizedBox(width: 40, child: LoadingTextWidget()),
                        HorizontalGap(5),
                        VerticalDivider(
                            width: 2,
                            thickness: 1,
                            indent: 1,
                            endIndent: 1,
                            color: AppColors.bodyTextColor),
                        HorizontalGap(5),
                        SizedBox(width: 40, child: LoadingTextWidget()),
                      ],
                    )
                  ],
                )),
                HorizontalGap(5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyVehicleItemWidget extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onActiveIconTap;
  final String imageURL;
  final MyVehicleStatus status;
  final String brandName;
  final String modelName;
  final String numberPlateNumber;
  final bool isActive;
  const MyVehicleItemWidget({
    super.key,
    required this.onTap,
    required this.onActiveIconTap,
    required this.imageURL,
    required this.status,
    required this.brandName,
    required this.modelName,
    required this.numberPlateNumber,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      borderRadiusValue: 5,
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.formBorderColor),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox.square(
                dimension: 80,
                child: CachedNetworkImageWidget(
                  imageURL: imageURL,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                ),
              ),
              const HorizontalGap(16),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 3),
                      decoration: ShapeDecoration(
                          shape: const StadiumBorder(),
                          color: _statusBackgroundColor),
                      child: Text(
                        status.viewableTextTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyMediumTextStyle
                            .copyWith(color: _statusTextColor),
                      )),
                  const VerticalGap(8),
                  Text(brandName,
                      style: AppTextStyles.bodyMediumTextStyle
                          .copyWith(fontSize: 16)),
                  const VerticalGap(5),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        modelName,
                      ),
                      Container(
                        height: 15,
                        width: 2,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        color: AppColors.bodyTextColor,
                      ),
                      Text(numberPlateNumber),
                    ],
                  )
                ],
              )),
              const HorizontalGap(5),
              TightIconButtonWidget(
                  icon: SvgPictureAssetWidget(isActive
                      ? AppAssetImages.radioSVG
                      : AppAssetImages.radioUnselectedSVG),
                  onTap: onActiveIconTap),
            ],
          ),
        ),
      ),
    );
  }

  Color get _statusBackgroundColor => switch (status) {
        MyVehicleStatus.pending => Color.alphaBlend(
            AppColors.warningColor.withOpacity(0.1), Colors.white),
        MyVehicleStatus.approved => Color.alphaBlend(
            AppColors.successColor.withOpacity(0.1), Colors.white),
        MyVehicleStatus.cancelled =>
          Color.alphaBlend(AppColors.errorColor.withOpacity(0.1), Colors.white),
        MyVehicleStatus.suspended =>
          Color.alphaBlend(AppColors.errorColor.withOpacity(0.1), Colors.white),
        _ => Color.alphaBlend(
            AppColors.warningColor.withOpacity(0.1), Colors.white),
      };

  Color get _statusTextColor => switch (status) {
        MyVehicleStatus.pending => AppColors.warningColor,
        MyVehicleStatus.approved => AppColors.successColor,
        MyVehicleStatus.cancelled => AppColors.errorColor,
        MyVehicleStatus.suspended => AppColors.errorColor,
        _ => AppColors.warningColor,
      };
}
