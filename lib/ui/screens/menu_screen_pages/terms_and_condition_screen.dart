import 'package:car2godriver/controller/menu_screen_controller/terms_condition_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:get/get.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<TermsConditionScreenController>(
        init: TermsConditionScreenController(),
        builder: (controller) => CustomScaffold(
            /* <-------- AppBar --------> */
            appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: true,
                titleText: AppLanguageTranslation
                    .termsConditionTransKey.toCurrentLanguage),
            /* <-------- Body Content --------> */

            body: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Column(
                children: [
                  Expanded(
                    /* <-------- Side padding for scaffold body contents  --------> */
                    child: ScaffoldBodyWidget(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* <-------- Fetch data from API --------> */
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
            )));
  }
}
