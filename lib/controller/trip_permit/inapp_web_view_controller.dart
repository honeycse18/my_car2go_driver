import 'package:get/get.dart';

class InAppWebViewScreenController extends GetxController {
  String url = '';

  void _getScreenParameter() {
    dynamic params = Get.arguments;

    if (params is String) {
      url = params;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _getScreenParameter();
    super.onInit();
  }
}
