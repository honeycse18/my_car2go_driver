// Create a new screen for the in-app web view
import 'package:car2godriver/controller/trip_permit/inapp_web_view_controller.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class InAppWebViewScreen extends StatelessWidget {
  const InAppWebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InAppWebViewScreenController>(
        init: InAppWebViewScreenController(),
        global: false,
        builder: (controller) => CustomScaffold(
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleText: 'Payment'),
              body: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: InAppWebView(
                  initialUrlRequest: URLRequest(url: WebUri(controller.url)),
                  onLoadStop: (controller, url) {
                    // Check if the payment is successful and navigate back
                    if (url.toString().contains('/api/payment/completed')) {
                      Get.back();
                      Get.back();
                      AppDialogs.showSuccessDialog(
                          titleText: 'Payment Successfully',
                          messageText: 'Your Trip permit has been successful');
                    } else if (url.toString().contains('/api/payment/failed')) {
                      Get.back();
                      Get.back();
                      AppDialogs.showSuccessDialog(
                          messageText:
                              'Payment UnSuccessful. Please Try Again');
                    }
                  },
                ),
              ),
            ));
  }
}
