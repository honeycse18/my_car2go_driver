import 'package:get/get.dart';

class PhotoViewScreenController extends GetxController {
  String image = '';

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      image = params;
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _getScreenParameters();
    super.onInit();
  }
}
