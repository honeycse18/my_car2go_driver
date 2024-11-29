import 'package:car2godriver/ui/screens/my_vehicle_details/my_vehicle_details_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/screen_widget/document_item.dart';
import 'package:car2godriver/ui/widgets/screen_widget/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyVehicleDetailsScreen extends StatelessWidget {
  const MyVehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyVehicleDetailsScreenController>(
      init: MyVehicleDetailsScreenController(),
      global: true,
      builder: (controller) => PopScope(
        onPopInvoked: (didPop) {
          if (didPop) {
            // controller.onClose();
          }
        },
        child: CustomScaffold(
          /* <-------- AppBar --------> */
          appBar: CoreWidgets.appBarWidget(
              screenContext: context,
              hasBackButton: true,
              titleText: controller.myVehicleDetails.carNumberPlate,
              actions: [
                TightSmallTextButtonWidget(
                  text: 'Delete',
                  textStyle: AppTextStyles.bodyTextStyle
                      .copyWith(color: AppColors.alertColor),
                  onTap: controller.onDeleteButtonTap,
                ),
                const HorizontalGap(24),
              ]),
          /* <-------- Body Content --------> */
          /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
          body: ScaffoldBodyWidget(
              child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: VerticalGap(30)),
              SliverToBoxAdapter(
                  child: Text('Your car category',
                      style: AppTextStyles.titleSemiSmallSemiboldTextStyle
                          .copyWith(
                        color: Colors.black,
                      ))),
              SliverToBoxAdapter(
                  child: ListTileWidget(
                      child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox.square(
                      dimension: 40,
                      child: CachedNetworkImageWidget(
                        imageURL:
                            controller.myVehicleDetails.images.firstOrNull ??
                                '',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                        ),
                      )),
                  const HorizontalGap(12),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        controller.myVehicleDetails.vehicleType.name,
                        style: AppTextStyles.bodyMediumTextStyle
                            .copyWith(fontSize: 16),
                      ),
                    ],
                  )),
                  const HorizontalGap(12),
                ],
              ))),
              const SliverToBoxAdapter(child: VerticalGap(20)),
              SliverToBoxAdapter(
                child: ProfileItem(
                  title: 'Brand name',
                  value: controller.myVehicleDetails.brand,
                ),
              ),
              const SliverToBoxAdapter(child: VerticalGap(20)),
              SliverToBoxAdapter(
                child: ProfileItem(
                  title: 'Model',
                  value: controller.myVehicleDetails.model,
                ),
              ),
              const SliverToBoxAdapter(child: VerticalGap(20)),
              SliverToBoxAdapter(
                child: ProfileItem(
                  title: 'Year',
                  value: controller.myVehicleDetails.year,
                ),
              ),
              const SliverToBoxAdapter(child: VerticalGap(20)),
              SliverToBoxAdapter(
                child: ProfileItem(
                  title: 'Seat',
                  value: controller.myVehicleDetails.seat.toString(),
                ),
              ),
              const SliverToBoxAdapter(child: VerticalGap(20)),
              SliverToBoxAdapter(
                child: ProfileItem(
                  title: 'Number plate',
                  value: controller.myVehicleDetails.carNumberPlate,
                ),
              ),
              const SliverToBoxAdapter(child: VerticalGap(20)),
              SliverToBoxAdapter(
                child: Text('Images',
                    style:
                        AppTextStyles.titleSemiSmallSemiboldTextStyle.copyWith(
                      color: Colors.black,
                    )),
              ),
              const SliverToBoxAdapter(child: VerticalGap(20)),
              SliverToBoxAdapter(
                  child: SizedBox(
                height: 64,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final image = controller.myVehicleDetails.images[index];
                      return SizedBox(
                        width: 64,
                        child: CachedNetworkImageWidget(
                            imageURL: image,
                            imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover)),
                                )),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const HorizontalGap(12),
                    itemCount: controller.myVehicleDetails.images.length),
              )),
              const SliverToBoxAdapter(child: VerticalGap(24)),
              SliverToBoxAdapter(
                child: Text('Others',
                    style:
                        AppTextStyles.titleSemiSmallSemiboldTextStyle.copyWith(
                      color: Colors.black,
                    )),
              ),
              const SliverToBoxAdapter(child: VerticalGap(24)),
              // Dynamic fields
              SliverList.separated(
                itemBuilder: (context, index) {
                  final dynamicFieldValue =
                      controller.dynamicFieldValues[index];
                  return ProfileDocumentsDynamicItem(
                    title: dynamicFieldValue.vehicleFieldInfo.placeholder,
                    type: dynamicFieldValue.vehicleFieldInfo.typeAsSealedClass,
                    values: dynamicFieldValue.values,
                  );
                },
                separatorBuilder: (context, index) => const VerticalGap(24),
                itemCount: controller.dynamicFieldValues.length,
              ),

              const SliverToBoxAdapter(child: VerticalGap(100)),
            ],
          )),
          bottomNavigationBar: CustomScaffoldBodyWidget(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 5),
            child: CustomStretchedTextButtonWidget(
              isLoading: controller.isLoading,
              buttonText: 'Edit vehicle',
              onTap: controller.onEditVehicleButtonTap,
            ),
          )),
        ),
      ),
    );
  }
}
