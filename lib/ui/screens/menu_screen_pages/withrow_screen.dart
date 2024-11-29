// import 'package:car2gouser/controller/introscreen_controller.dart';
import 'package:car2godriver/controller/menu_screen_controller/withrow_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/screen_widget/transaction_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class WithrowScreen extends StatelessWidget {
  const WithrowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<WithrowScreenController>(
      init: WithrowScreenController(),
      global: false,
      builder: (controller) => CustomScaffold(
        /* <-------- AppBar --------> */
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleText: AppLanguageTranslation.withdrawTransKey.toCurrentLanguage,
          hasBackButton: true,
        ),
        /* <-------- Body Content --------> */
        body: ScaffoldBodyWidget(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* <-------- 30px height gap --------> */
            AppGaps.hGap30,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLanguageTranslation.withdrawTransKey.toCurrentLanguage,
                      style: AppTextStyles.titleSemiSmallBoldTextStyle
                          .copyWith(color: Colors.black),
                    ),
                    CustomTextFormField(
                      // validator: Helper.emailFormValidator,
                      controller: controller.emailTextEditingController,
                      labelText: AppLanguageTranslation
                          .howMuchWantWithrowTransKey.toCurrentLanguage,
                      hintText: 'E.g: \$50',
                      prefixIcon: const SvgPictureAssetWidget(
                          AppAssetImages.emailImage),
                    ),
                    Text(
                        AppLanguageTranslation
                            .selectMethodTransKey.toCurrentLanguage,
                        style: AppTextStyles.titleBoldTextStyle),
                    AppGaps.hGap10,
                    Container(
                      height: 56,
                      width: 392,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.bodyTextColor)),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 10),
                          child: TransactionWidget(
                            dateTime: DateTime.now(),
                            title: "**** **** **** 8970",
                            icon: const SvgPictureAssetWidget(
                              AppAssetImages.masterCardSvgFillIcon,
                            ),
                            text1: "Expires: 12/26",
                            text2: "",
                            backColor: Colors.transparent,
                          )),
                    ),
                    /* <-------- 60px height gap --------> */
                    AppGaps.hGap10,
                    Container(
                      height: 56,
                      width: 392,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.bodyTextColor)),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 10),
                          child: TransactionWidget(
                            dateTime: DateTime.now(),
                            title: "**** **** **** 8970",
                            icon: const SvgPictureAssetWidget(
                              AppAssetImages.paypalSvgFillIcon,
                            ),
                            text1: "Expires: 12/26",
                            text2: "",
                            backColor: Colors.transparent,
                          )),
                    ),
                    /* <-------- 10px height gap --------> */
                    AppGaps.hGap10,
                    Container(
                      height: 56,
                      width: 392,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.bodyTextColor)),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 10),
                          child: TransactionWidget(
                            dateTime: DateTime.now(),
                            title: "**** **** **** 8970",
                            icon: const SvgPictureAssetWidget(
                              AppAssetImages.visaSvgFillIcon,
                            ),
                            text1: "Expires: 12/26",
                            text2: "",
                            backColor: Colors.transparent,
                          )),
                    ),
                    /* <-------- 10px height gap --------> */
                    AppGaps.hGap10,
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
