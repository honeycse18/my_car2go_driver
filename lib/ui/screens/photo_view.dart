import 'package:car2godriver/controller/photo_view_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends StatelessWidget {
  const PhotoViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotoViewScreenController>(
        global: false,
        init: PhotoViewScreenController(),
        builder: (controller) => Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: AppColors.backgroundColor,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context, hasBackButton: true),
              body: PhotoView(
                imageProvider: NetworkImage(
                    controller.image), // Replace with your image URL
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2,
                backgroundDecoration: const BoxDecoration(
                  color: Colors.black,
                ),
                enableRotation: true, // Enable image rotation
              ),
            ));
  }
}
