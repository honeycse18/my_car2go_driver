import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/api_response.dart';
import 'package:car2godriver/models/api_responses/package_list_response.dart';
import 'package:car2godriver/models/api_responses/trip_permit_list_data.dart';
import 'package:car2godriver/models/api_responses/user_details_response.dart';
import 'package:car2godriver/models/screenParameters/trip_permit_payment_summery_screen_parameter.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/double.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:get/get.dart';

class TripPermitScreenController extends GetxController {
  TripPermitListDetails tripPermitListData = TripPermitListDetails.empty();
  TripPermitPricingModel selectedPricingModel = TripPermitPricingModel();
  List<PackageResponseList> packageResponseList = [];
  List<Subscription> broughtSubscriptionList = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  PackageResponseList selectedPackage = PackageResponseList();

  // bool get shouldEnableSubscribeNowButton => selectedPackage.isNotEmpty;
  bool get shouldEnableSubscribeNowButton => selectedPricingModel.isNotEmpty;
  bool get shouldDisableSubscribeNowButton => selectedPricingModel.isEmpty;
/*   String get subscribeNowButtonText => shouldEnableSubscribeNowButton
      ? 'Subscribe Now - ${selectedPackage.price.getCurrencyFormattedText()}'
      : 'Subscribe Now'; */
  String get subscribeNowButtonText {
    // bool isRenew = broughtSubscriptionList .any((subscription) => subscription.package.id == selectedPackage.id);
    bool isRenew = selectedPricingModel.isSubscribed;
    return shouldEnableSubscribeNowButton
        ? (isRenew
            // ? 'Renew - ${selectedPackage.price.getCurrencyFormattedText()}'
            ? 'Renew - ${selectedPricingModel.price.getCurrencyFormattedText()}'
            // : 'Subscribe Now - ${selectedPackage.price.getCurrencyFormattedText()}')
            : 'Subscribe Now - ${selectedPricingModel.price.getCurrencyFormattedText()}')
        : 'Subscribe Now';
  }

  /*<-----------Get FAQA item list from API ----------->*/
  void onPackageItemTap(TripPermitPricingModel package) {
    selectedPricingModel = package;
    update();
  }

  void onSubscribeNowButtonTap() async {
    Get.toNamed(AppPageNames.tripPermitPaymentSummeryScreen,
        arguments: TripPermitPaymentSummeryScreenParameter(
          subscriptionID: tripPermitListData.id,
          pricingModel: selectedPricingModel,
          isRenew: selectedPricingModel.isSubscribed,
        ));
    // checkUserDetails();
    // getPackageList();
  }

  Future<void> getPackageList() async {
    isLoading = true;
    final response = await APIRepo.getTripPermitListData();
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.errorMessage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.errorMessage);
      return;
    }
    _onSuccessGetPackageList(response);
  }

  void _onSuccessGetPackageList(APIResponse<TripPermitListDetails> response) {
    tripPermitListData = response.data;
    update();
  }

  /*<----------- Check ride status from API----------->*/
/*   Future<void> checkUserDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      log('No response for getting user details!');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInUserDetails(response);
  } 

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) {
    broughtSubscriptionList = response.data.subscription;
    update();
  } */

  @override
  void onInit() {
    // checkUserDetails();
    getPackageList();
    super.onInit();
  }
}
