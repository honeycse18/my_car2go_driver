import 'package:car2godriver/controller/bottom_screen_controller/offer_pool_bottomsheet_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferPoolBottomsheet extends StatelessWidget {
  const OfferPoolBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfferPoolBottomsheetController>(
        init: OfferPoolBottomsheetController(),
        builder: (controller) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                  height: 209,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: Scaffold(
                      appBar: CoreWidgets.appBarWidget(
                        screenContext: context,
                        hasBackButton: true,
                        titleText: 'Offer Pool',
                      ),
                      resizeToAvoidBottomInset: false,
                      body: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'What Do you Want?',
                              style: AppTextStyles.bodyLargeMediumTextStyle
                                  .copyWith(color: AppColors.primaryTextColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  )));
        });
  }
}
