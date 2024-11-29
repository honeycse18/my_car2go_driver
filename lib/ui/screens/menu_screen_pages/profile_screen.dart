import 'package:car2godriver/controller/profile_screen_controller.dart';
import 'package:car2godriver/models/api_responses/bottom_sheet_params/profile_entry_gender_bottom_sheet_parameter.dart';
import 'package:car2godriver/models/enums/gender.dart';
import 'package:car2godriver/models/enums/api/profile_field_name.dart';
import 'package:car2godriver/models/enums/profile_status.dart';
import 'package:car2godriver/models/local/profile_dynamic_field_widget_paramter.dart';
import 'package:car2godriver/ui/screens/bottomsheet/profile_dynamic_field_bottomsheet.dart';
import 'package:car2godriver/ui/screens/bottomsheet/profile_field_bottomsheet.dart';
import 'package:car2godriver/ui/widgets/screen_widget/profile_screen_widgets.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/screen_widget/document_item.dart';
import 'package:car2godriver/ui/widgets/screen_widget/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size both height and width
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<MyAccountScreenController>(
        init: MyAccountScreenController(),
        builder: (controller) => Scaffold(
              extendBodyBehindAppBar: false,
              extendBody: true,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText: 'Profile',
                  hasBackButton: true,
                  actions: [
                    Center(
                      child: ProfileStatusWidget(
                          status: controller.profileDetails.statusAsEnum),
                    ),
                    const HorizontalGap(24)
                  ]),
              body: Container(
                height: screenHeight,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: 0,
                      child: Container(
                        width: screenWidth,
                        height: screenHeight * 0.235,
                        decoration: const ShapeDecoration(
                          color: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 88),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: screenWidth,
                          // height: screenHeight * 0.85,
                          decoration: const ShapeDecoration(
                            color: AppColors.primaryButtonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: CustomScrollView(
                              slivers: [
                                /* <-------- 30px height gap --------> */
                                const SliverToBoxAdapter(
                                    child: VerticalGap(64)),
                                SliverToBoxAdapter(
                                  child: Text('Profile Information',
                                      style: AppTextStyles
                                          .titleSemiSmallSemiboldTextStyle
                                          .copyWith(
                                        color: Colors.black,
                                      )),
                                ),
                                const SliverToBoxAdapter(
                                    child: VerticalGap(16)),
                                /* <--------  Profile Information Field--------> */
                                SliverToBoxAdapter(
                                  child: ProfileItem(
                                    title: "Full Name",
                                    value: controller.profileDetails.name,
                                    onTap: controller.onFullNameTap,
                                  ),
                                ),
                                const SliverToBoxAdapter(
                                    child: VerticalGap(16)),
                                SliverToBoxAdapter(
                                  child: ProfileItem(
                                      title: "Email Address",
                                      value: controller.profileDetails.email,
                                      onTap: controller.onEmailAddressTap),
                                ),
                                const SliverToBoxAdapter(
                                    child: VerticalGap(16)),
                                SliverToBoxAdapter(
                                  child: ProfileItem(
                                      title: "Phone Number",
                                      value: controller.profileDetails.phone,
                                      onTap: controller.onPhoneNumberTap),
                                ),
                                const SliverToBoxAdapter(
                                    child: VerticalGap(16)),
                                SliverToBoxAdapter(
                                  child: ProfileItem(
                                      title: 'Gender',
                                      value: controller.profileDetails
                                                  .genderAsEnum ==
                                              Gender.unknown
                                          ? 'Not set'
                                          : controller
                                              .profileDetails
                                              .genderAsEnum
                                              .viewableTextTransKey
                                              .toCurrentLanguage,
                                      onTap: controller.onGenderTap),
                                ),
                                const SliverToBoxAdapter(
                                    child: VerticalGap(16)),
                                SliverToBoxAdapter(
                                  child: ProfileItem(
                                      title: 'City',
                                      value: controller.profileDetails.city,
                                      onTap: controller.onCityTap),
                                ),
                                const SliverToBoxAdapter(
                                    child: VerticalGap(16)),
                                SliverToBoxAdapter(
                                  child: ProfileItem(
                                      title: 'Address',
                                      value: controller.profileDetails.address,
                                      onTap: controller.onAddressTap),
                                ),
                                const SliverToBoxAdapter(
                                    child: VerticalGap(24)),

                                // / <---- Profile name ----> /
                                SliverToBoxAdapter(
                                  child: Text('Documents',
                                      style: AppTextStyles
                                          .titleSemiSmallSemiboldTextStyle
                                          .copyWith(
                                        color: Colors.black,
                                      )),
                                ),

                                const SliverToBoxAdapter(
                                    child: VerticalGap(16)),
                                SliverToBoxAdapter(
                                  child: ProfileDocumentsItem(
                                      title: 'Driving License',
                                      isUploaded: controller.profileDetails
                                          .drivingLicense.isNotEmpty,
                                      onTap: controller.onDriverLicenseTap,
                                      onUpdateButtonTap:
                                          controller.onDriverLicenseTap),
                                ),

                                /* const SliverToBoxAdapter( child: VerticalGap(24)),
                                 SliverToBoxAdapter(
                                  child: ProfileDocumentsItem(
                                      title: 'Id Card',
                                      onTap: controller.onIDCardTap),
                                ), */
                                const SliverToBoxAdapter(
                                    child: VerticalGap(16)),
                                SliverToBoxAdapter(
                                  child: Text('Others',
                                      style: AppTextStyles
                                          .titleSemiSmallSemiboldTextStyle
                                          .copyWith(
                                        color: Colors.black,
                                      )),
                                ),
                                const SliverToBoxAdapter(
                                    child: VerticalGap(16)),
                                // Dynamic fields
                                SliverList.separated(
                                  itemBuilder: (context, index) {
                                    final dynamicFieldValue =
                                        controller.dynamicFieldValues[index];
                                    return ProfileDocumentsDynamicItem(
                                        title: dynamicFieldValue
                                            .driverFieldInfo.placeholder,
                                        isRequired: dynamicFieldValue
                                            .driverFieldInfo.isRequired,
                                        type: dynamicFieldValue
                                            .driverFieldInfo.typeAsSealedClass,
                                        values: dynamicFieldValue.values,
                                        onTap: () async {
                                          final result = await Get.bottomSheet(
                                              isScrollControlled: true,
                                              const EditProfileDynamicFieldBottomSheet(),
                                              settings: RouteSettings(
                                                  arguments:
                                                      ProfileDynamicFieldWidgetParameter(
                                                          fieldDetails:
                                                              dynamicFieldValue
                                                                  .driverFieldInfo,
                                                          valueDetails:
                                                              dynamicFieldValue)));
                                          if (result is List<String>) {
                                            controller.dynamicFieldValues[index]
                                                .values = result;
                                            controller.update();
                                          }
                                        });
                                  },
                                  separatorBuilder: (context, index) =>
                                      const VerticalGap(16),
                                  itemCount: controller
                                      .dynamicFields.driverFields.length,
                                ),
                                const SliverToBoxAdapter(
                                    child: VerticalGap(30)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
                    Positioned(
                        top: 20,
                        child: Container(
                            height: 100,
                            width: 100,
                            decoration: const ShapeDecoration(
                              shape: CircleBorder(),
                              color: Colors.white,
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (controller.selectedProfileImage !=
                                        null) {
                                      Get.toNamed(AppPageNames.imageZoomScreen,
                                          arguments:
                                              controller.selectedProfileImage);
                                    }
                                  },
                                  child: controller.isImageUpdating
                                      ? const Center(
                                          child: SizedBox.square(
                                              dimension: 50,
                                              child:
                                                  CircularProgressIndicator()))
                                      : MixedImageWidget(
                                          imageData:
                                              controller.selectedProfileImage,
                                          imageBuilder: (context,
                                                  imageProvider) =>
                                              Container(
                                                height: 128,
                                                width: 128,
                                                decoration: ShapeDecoration(
                                                    shape: const CircleBorder(),
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: imageProvider)),
                                              )),
                                ),
/*                                 controller.imageEdit
                                    ? Container(
                                        height: 128,
                                        width: 128,
                                        decoration: ShapeDecoration(
                                            shape: const CircleBorder(),
                                            color: Colors.white,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: Image.memory(
                                                  controller
                                                      .selectedProfileImage,
                                                ).image)),
                                      )
                                    : CachedNetworkImageWidget(
                                        imageURL: controller.userDetails.image,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          alignment: Alignment.center,
                                          decoration: ShapeDecoration(
                                              shape: CircleBorder(),
                                              color: Colors.white,
                                              image: DecorationImage(
                                                image: imageProvider,
                                              )),
                                        ),
                                      ), */

                                /* <---- Camera icon for uploading the profile image ----> */

                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: SizedBox.square(
                                      dimension: 44,
                                      child: DecoratedBox(
                                        position: DecorationPosition.foreground,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.white, width: 2)),
                                        child: RawButtonWidget(
                                          onTap:
                                              controller.onEditImageButtonTap,
                                          isCircleShape: true,
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          child: const Center(
                                            child: SizedBox.square(
                                              dimension: 20,
                                              child: SvgPictureAssetWidget(
                                                AppAssetImages
                                                    .cameraSVGLogoLine,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                )
                              ],
                            ))),
                  ],
                ),
              ),
            ));
  }
}
