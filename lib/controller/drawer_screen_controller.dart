import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:car2godriver/controller/socket_controller.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class ZoomDrawerScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  final zoomDrawerController = ZoomDrawerController();
  SocketController? socketController;
  Widget nestedScreenWidget = const Scaffold();
  int currentPageIndex = 0;
  // const ZoomDrawerScreen({super.key});

  final pageController = PageController(initialPage: 0);

  final notchBottomBarController = NotchBottomBarController(index: 0);

  int maxCount = 5;

  /* <----  widget list ----> */
  final List<Widget> bottomBarPages = [
    /*  const Home_Page(),
    const Request_Page(),
    const UpcomingPage(),
    const Wallet_Page(), */
  ];
  /* <---- Initial state ----> */
  @override
  void onInit() {
    Helper.updateSavedDriverDetails(shouldLogout: true);
    try {
      // socketController = Get.find<SocketController>();
      socketController = Get.find<SocketController>();
    } catch (e) {
      socketController = Get.put<SocketController>(SocketController());
    }
    socketController?.initSocket();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    socketController?.disposeSocket();
    super.dispose();
  }
}
