import 'package:car2godriver/ui/screens/my_vehicles/my_vehicles_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/screen_widget/my_vehicles_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyVehiclesScreen extends StatelessWidget {
  const MyVehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyVehiclesScreenController>(
      init: MyVehiclesScreenController(),
      global: true,
      builder: (controller) => CustomScaffold(
        /* <-------- AppBar --------> */
        appBar: CoreWidgets.appBarWidget(
            screenContext: context,
            hasBackButton: true,
            titleText:
                AppLanguageTranslation.myVehicleTransKey.toCurrentLanguage),
        /* <-------- Body Content --------> */
        /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
        body: ScaffoldBodyWidget(child: Builder(
          builder: (context) {
            if (controller.isLoading) {
              return ListView.separated(
                  padding: const EdgeInsets.only(top: 30, bottom: 120),
                  itemBuilder: (context, index) =>
                      const LoadingMyVehicleItemWidget(),
                  separatorBuilder: (context, index) => const VerticalGap(12),
                  itemCount: 15);
            }
            if (controller.myVehiclesData.vehicles.isEmpty) {
              return const Center(
                child: EmptyScreenWidget(
                    localImageAssetURL: AppAssetImages.carImage,
                    title: 'No vehicle added'),
              );
            }
            return RefreshIndicator(
              onRefresh: () async => controller.getMyVehicles(),
              child: ListView.separated(
                  padding: const EdgeInsets.only(top: 30, bottom: 100),
                  itemBuilder: (context, index) {
                    final vehicle = controller.myVehiclesData.vehicles[index];
                    return MyVehicleItemWidget(
                        isActive: vehicle.isActive,
                        brandName: vehicle.brand,
                        imageURL: vehicle.images.firstOrNull ?? '',
                        modelName: vehicle.model,
                        numberPlateNumber: vehicle.carNumberPlate,
                        status: vehicle.statusAsEnum,
                        onTap: () => controller.onVehicleTap(vehicle),
                        onActiveIconTap: () =>
                            controller.onVehicleActiveIconButtonTap(vehicle));
                  },
                  separatorBuilder: (context, index) => const VerticalGap(12),
                  itemCount: controller.myVehiclesData.vehicles.length),
            );
          },
        )),
        floatingActionButton: FloatingActionButton.extended(
            elevation: 0,
            backgroundColor: Color.alphaBlend(
                AppColors.primaryColor.withAlpha(37), Colors.white),
            foregroundColor: AppColors.primaryColor,
            onPressed: controller.onAddNewButtonTap,
            icon: const Icon(Icons.add),
            label: Text('Add new',
                style: AppTextStyles.bodySemiboldTextStyle
                    .copyWith(fontSize: 16))),
      ),
    );
  }
}
