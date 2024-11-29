import 'package:car2godriver/controller/select_payment_methods_screen_controller.dart';
import 'package:car2godriver/models/fakeModel/fake_data.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/select_payment_method_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectPaymentMethodsScreen extends StatelessWidget {
  const SelectPaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<SelectPaymentMethodScreenController>(
        global: false,
        init: SelectPaymentMethodScreenController(),
        builder: (controller) => CustomScaffold(
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleText: AppLanguageTranslation
                      .paymentMethodTranskey.toCurrentLanguage),
              /* <-------- Body Content --------> */
              /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
              body: ScaffoldBodyWidget(
                  child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    /* <-------- 24px height gap --------> */
                    child: AppGaps.hGap24,
                  ),
                  SliverList.separated(
                    itemCount: FakeData.paymentOptionList.length,
                    itemBuilder: (context, index) {
                      final paymentOption = FakeData.paymentOptionList[index];
                      return SelectPaymentMethodWidget(
                        paymentOptionImage: paymentOption.paymentImage,
                        cancelReason: paymentOption,
                        selectedCancelReason: controller.selectedPaymentOption,
                        paymentOption: paymentOption.viewAbleName,
                        hasShadow:
                            controller.selectedPaymentMethodIndex == index,
                        onTap: () {
                          controller.selectedPaymentMethodIndex = index;
                          controller.selectedPaymentOption = paymentOption;
                          controller.update();
                        },
                        // radioOnChange: (Value) {
                        //   controller.selectedPaymentMethodIndex = index;
                        //   controller.selectedPaymentOption = paymentOption;
                        //   controller.update();
                        // },
                        index: index,
                        selectedPaymentOptionIndex:
                            controller.selectedPaymentMethodIndex,
                      );
                    },
                    separatorBuilder: (context, index) => AppGaps.hGap16,
                  ),
                ],
              )),
              /* <-------- Bottom Bar button --------> */
              bottomNavigationBar: ScaffoldBodyWidget(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomStretchedButtonWidget(
                      onTap: controller.paymentAcceptCarRentRequest,
                      child: Text(AppLanguageTranslation
                          .paymentTranskey.toCurrentLanguage),
                    ),
                    AppGaps.hGap10,
                  ],
                ),
              ),
            ));
  }
}
