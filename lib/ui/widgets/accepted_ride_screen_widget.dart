import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class AcceptedRideScreenWidget extends StatelessWidget {
  final String userName;
  final bool isRideNow;

  final String userImage;
  final String distance;
  final String duration;
  final String pickLocation;
  final String dropLocation;
  final double amount;
  final double rating;
  final void Function()? onTap;
  final void Function()? onSendTap;
  final void Function()? onAcceptTap;
  final void Function()? onRejectTap;

  const AcceptedRideScreenWidget({
    super.key,
    required this.userName,
    required this.userImage,
    required this.distance,
    required this.duration,
    required this.pickLocation,
    required this.dropLocation,
    required this.amount,
    required this.rating,
    this.onTap,
    required this.onSendTap,
    this.isRideNow = false,
    this.onAcceptTap,
    this.onRejectTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              /* <-------- Fetch user image from API --------> */
              child: CachedNetworkImageWidget(
                imageURL: userImage,
                imageBuilder: (context, imageProvider) => Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
            ),
            /* <-------- 10px width gap --------> */
            AppGaps.wGap10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: AppTextStyles.bodyLargeSemiboldTextStyle
                      .copyWith(color: AppColors.primaryTextColor),
                ),
                /* <-------- 4px height gap --------> */
                AppGaps.hGap4,
                Row(
                  children: [
                    const SvgPictureAssetWidget(
                      AppAssetImages.starSVGLogoSolid,
                      height: 8,
                      width: 8,
                      color: AppColors.primaryColor,
                    ),
                    AppGaps.wGap6,
                    Text(
                      '$rating ( 531 reviews )',
                      style: AppTextStyles.bodySmallTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    )
                  ],
                )
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${Helper.getCurrencyFormattedWithDecimalAmountText(amount)} FCA',
                  style: AppTextStyles.bodyLargeSemiboldTextStyle,
                ),
                /* <-------- 6px height gap --------> */
                AppGaps.hGap6,
                Text(
                  '$distance $duration',
                  style: AppTextStyles.bodySmallTextStyle
                      .copyWith(color: AppColors.bodyTextColor),
                ),
              ],
            )
          ],
        ),
      ),
      /* <-------- 16px height gap --------> */
      AppGaps.hGap16,
      /*  Row(
        children: [
          RawButtonWidget(
            borderRadiusValue: 12,
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: AppColors.fromBorderColor),
                  color: Colors.white),
              child: const Center(
                  child: SvgPictureAssetWidget(
                AppAssetImages.callingSVGLogoSolid,
                height: 15,
                width: 15,
              )),
            ),
            onTap: () {},
          ),
          AppGaps.wGap10,
          Expanded(
            child: CustomMessageTextFormField(
              boxHeight: 55,
              isReadOnly: true,
              onTap: onSendTap,
              hintText: AppLanguageTranslation.messageYourDriverTransKey.toCurrentLanguage,
              suffixIcon: const SvgPictureAssetWidget(
                AppAssetImages.sendSVGLogoLine,
                height: 18,
                width: 18,
              ),
            ),
          )
        ],
      ), */
      /* AppGaps.hGap12,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Start Date & Time ',
            style: AppTextStyles.bodyLargeTextStyle
                .copyWith(color: AppColors.bodyTextColor),
          ),
          const Text(
            '24 Oct,2022  I 05:40 AM',
            style: AppTextStyles.bodyLargeMediumTextStyle,
          )
        ],
      ), */
      /* <-------- 12px height gap --------> */
      AppGaps.hGap12,
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssetImages.pickupMarkerPngIcon,
                  height: 16,
                  width: 16,
                ),
                /* <-------- 4px width gap --------> */
                AppGaps.wGap4,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLanguageTranslation
                            .pickUpLocationTranskey.toCurrentLanguage,
                        style: AppTextStyles.bodySmallTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                      AppGaps.hGap6,
                      Text(
                        pickLocation,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyLargeMediumTextStyle,
                      )
                    ],
                  ),
                )
              ],
            ),
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssetImages.dropMarkerPngIcon,
                  height: 16,
                  width: 16,
                ),
                /* <-------- 6px width gap --------> */
                AppGaps.wGap6,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLanguageTranslation
                            .dropLocationTranskey.toCurrentLanguage,
                        style: AppTextStyles.bodySmallTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                      /* <-------- 4px height gap --------> */
                      AppGaps.hGap4,
                      Text(
                        dropLocation,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyLargeMediumTextStyle,
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      Row(
        children: [
          Expanded(
              child: Container(
            height: 1,
            color: AppColors.formBorderColor,
          )),
        ],
      ),
      /* <-------- 12px height gap --------> */
      AppGaps.hGap12,
    ]);
  }
}
