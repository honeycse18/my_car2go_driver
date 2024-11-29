import 'package:car2godriver/controller/menu_screen_controller/privacy_policy_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<PrivacyPolicyScreenController>(
        init: PrivacyPolicyScreenController(),
        builder: (controller) => CustomScaffold(
              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleText: AppLanguageTranslation
                      .privacyPolicyTranskey.toCurrentLanguage),

              /* <-------- Body Content --------> */

              body: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Column(
                  children: [
                    Expanded(
                      /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
                      child: ScaffoldBodyWidget(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HtmlWidget(controller.supportTextItem.content),
                              /* <-------- 50px height gap --------> */
                              AppGaps.hGap50,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
