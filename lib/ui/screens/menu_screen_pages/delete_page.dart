import 'package:car2godriver/controller/menu_screen_controller/delete_controller.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<DeleteAccountScreenController>(
      init: DeleteAccountScreenController(),
      global: false,
      builder: (controller) => CustomScaffold(
        /* <-------- AppBar --------> */
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleText:
              AppLanguageTranslation.deleteAccountTransKey.toCurrentLanguage,
          hasBackButton: true,
        ),
        /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
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
                      AppLanguageTranslation
                          .deleteAccountTransKey.toCurrentLanguage,
                      style: AppTextStyles.titleSemiSmallBoldTextStyle
                          .copyWith(color: Colors.black),
                    ),
                    // HtmlWidget(
                    //     'Lorem ipsum dolor sit amet consectetur. Sit pulvinar mauris mauris eu nibh semper nisl pretium laoreet. Sed non faucibus ac lectus eu arcu. Nulla sit congue facilisis vestibulum egestas nisl feugiat pharetra. Odio sit tortor morbi at orci ipsum dapibus interdum. Lorem felis est aliquet arcu nullam pellentesque. Et habitasse ac arcu et nunc euismod rhoncus facilisis sollicitudin. Mi scelerisque netus ornare blandit diam enim urna faucibus.Lorem ipsum dolor sit amet consectetur. Sit pulvinar mauris mauris eu nibh semper nisl pretium laoreet. Sed non faucibus ac lectus eu arcu. Nulla sit congue facilisis vestibulum egestas nisl feugiat pharetra. Odio sit tortor morbi at orci ipsum dapibus interdum. Lorem felis est aliquet arcu nullam pellentesque. Et habitasse ac arcu et nunc euismod rhoncus facilisis sollicitudin. Mi scelerisque netus ornare blandit diam enim urna faucibus.'),
                    /* <-------- 20px height gap --------> */
                    AppGaps.hGap20,
                    Text(AppLanguageTranslation.areYouWantDeleteAccountTransKey
                        .toCurrentLanguage), //Expanded(child: Text("Description")),
                    /* <-------- 20px height gap --------> */
                    AppGaps.hGap20,
                    Text(
                      AppLanguageTranslation.accountTransKey.toCurrentLanguage,
                      style: AppTextStyles.titleSemiSmallBoldTextStyle
                          .copyWith(color: Colors.black),
                    ),
                    /* <-------- 20px height gap --------> */
                    AppGaps.hGap20,
                    Text(
                      AppLanguageTranslation
                          .deleteAccountRemoveDataTransKey.toCurrentLanguage,
                    ),
                    /* <-------- 30px height gap --------> */
                    AppGaps.hGap30,
                    CustomStretchedButtonWidget(
                        onTap: () {},
                        // onTap: controller.onContinueButtonTap,
                        child: Text(
                          AppLanguageTranslation
                              .deleteTransKey.toCurrentLanguage,
                        )),
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
