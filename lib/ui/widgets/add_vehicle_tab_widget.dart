import 'package:car2godriver/models/enums.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class AddVehicleTabWidget extends StatelessWidget {
  final int tabIndex;
  final String tabName;
  final bool isLine;
  // final bool isSelected;
  final AddVehicleTabState selectedTab;
  final AddVehicleTabState currentTab;
  const AddVehicleTabWidget({
    super.key,
    required this.tabIndex,
    required this.tabName,
    this.isLine = false,
    this.selectedTab = AddVehicleTabState.vehicle,
    required this.currentTab,
    // this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: shouldSelectThisTab
                          ? AppColors.primaryColor.withOpacity(0.3)
                          : AppColors.bodyTextColor.withOpacity(0.5),
                      border: Border.all(color: AppColors.bodyTextColor)),
                  child: Stack(
                    children: [
                      if (shouldSelectThisTab)
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Image.asset(AppAssetImages.tickkImage)),
                      Center(
                        child: Text(
                          tabName,
                          style: AppTextStyles.bodyMediumTextStyle.copyWith(
                              color: shouldSelectThisTab
                                  ? AppColors.primaryColor
                                  : AppColors.primaryTextColor),
                        ),
                      ),
                    ],
                  )),
            ),
            /* <-------- 6px width gap --------> */
            AppGaps.wGap6,
          ],
        ));
  }

  Widget _getTabStatePrefixIconWidget(AddVehicleTabState tabState) {
    // ignore: unrelated_type_equality_checks
    if (tabState == AddVehicleDetailsTabState.completed) {
      //===============================
      return const LocalAssetSVGIcon(AppAssetImages.arrowDownSVGLogoLine,
          color: Colors.white, height: 4.81);
    }
    return Text(
      '$tabIndex',
      style:
          AppTextStyles.smallestMediumTextStyle.copyWith(color: Colors.white),
    );
  }

  Color _getTabStateColor(
      AddVehicleTabState myTabState, AddVehicleTabState currentTabState) {
    Color inactiveStateColor = AppColors.bodyTextColor.withOpacity(0.5);
    Color currentTabStateColor = inactiveStateColor;
    switch (myTabState) {
      case AddVehicleTabState.vehicle:
        if (currentTabState == AddVehicleTabState.vehicle) {
          currentTabStateColor = AppColors.primaryColor.withOpacity(0.3);
        } else if (currentTabState == AddVehicleTabState.information) {
          currentTabStateColor = AppColors.primaryColor.withOpacity(0.3);
        } else if (currentTabState == AddVehicleTabState.documents) {
          currentTabStateColor = AppColors.primaryColor.withOpacity(0.3);
        } else {
          currentTabStateColor = inactiveStateColor;
        }
        break;
      case AddVehicleTabState.information:
        if (currentTabState == AddVehicleTabState.vehicle) {
          currentTabStateColor = inactiveStateColor;
        } else if (currentTabState == AddVehicleTabState.information) {
          currentTabStateColor = AppColors.primaryColor.withOpacity(0.3);
        } else if (currentTabState == AddVehicleTabState.documents) {
          currentTabStateColor = AppColors.primaryColor.withOpacity(0.3);
        } else {
          currentTabStateColor = inactiveStateColor;
        }
        break;
      case AddVehicleTabState.documents:
        if (currentTabState == AddVehicleTabState.vehicle) {
          currentTabStateColor = inactiveStateColor;
        } else if (currentTabState == AddVehicleTabState.information) {
          currentTabStateColor = inactiveStateColor.withOpacity(0.3);
        } else if (currentTabState == AddVehicleTabState.documents) {
          currentTabStateColor = AppColors.primaryColor.withOpacity(0.3);
        } else {
          currentTabStateColor = inactiveStateColor;
        }
        break;
      default:
        currentTabStateColor = AppColors.primaryColor;
    }
    return currentTabStateColor;
  }

  bool get shouldSelectThisTab => AddVehicleTabState.shouldSelectThisTab(
      selectedTab: selectedTab, currentTab: currentTab);

  bool get shouldNotSelectThisTab => AddVehicleTabState.shouldNotSelectThisTab(
      selectedTab: selectedTab, currentTab: currentTab);

  bool get isThisPreviousTab => AddVehicleTabState.isThisPreviousTab(
      selectedTab: selectedTab, currentTab: currentTab);
}
