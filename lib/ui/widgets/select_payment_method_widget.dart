import 'package:car2godriver/models/payment_option_model.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';

import 'package:flutter/material.dart';

/// Payment option list tile widget from checkout screen
class SelectPaymentMethodWidget extends StatelessWidget {
  const SelectPaymentMethodWidget({
    super.key,
    required this.hasShadow,
    required this.paymentOption,
    required this.paymentOptionImage,
    required this.index,
    required this.selectedPaymentOptionIndex,
    //required this.radioOnChange,
    this.onTap,
    required this.cancelReason,
    required this.selectedCancelReason,
  });

  final bool hasShadow;
  final String paymentOption;
  final String paymentOptionImage;
  final int index;
  final SelectPaymentOptionModel cancelReason;
  final SelectPaymentOptionModel selectedCancelReason;
  final int selectedPaymentOptionIndex;
  //final void Function(Object?) radioOnChange;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        hasShadow: hasShadow,
        paddingValue: const EdgeInsets.all(0),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          height: 60,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: AppColors.formBorderColor)),
          child: Row(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CachedNetworkImageWidget(
                  imageURL: paymentOptionImage,
                  imageBuilder: (context, imageProvider) => Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.contain)),
                  ),
                ),
              ),
              AppGaps.wGap15,
              Expanded(
                  child: Text(
                paymentOption,
                style: const TextStyle(fontWeight: FontWeight.w600),
              )),
              // AppGaps.wGap16,
              // CustomRadioWidget(
              //     value: index,
              //     groupValue: selectedPaymentOptionIndex,
              //     onChanged: radioOnChange),
            ],
          ),
        ));
  }
}
