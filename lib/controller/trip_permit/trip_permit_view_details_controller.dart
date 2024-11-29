import 'package:car2godriver/controller/trip_permit/trip_permit_history_controller.dart';
import 'package:car2godriver/controller/trip_permit/trip_permit_screen_controller.dart';
import 'package:car2godriver/models/api_responses/my_trip_permit_details.dart';
import 'package:car2godriver/models/screenParameters/trip_permit_payment_summery_screen_parameter.dart';
import 'package:car2godriver/services/profile_service.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:get/get.dart';

class TripPermitViewDetailsScreenController extends GetxController {
  // List<Subscription> broughtSubscriptionList = [];
  final tripPermitController = Get.find<TripPermitScreenController>();
  final myTripPermitDetailsController = Get.find<TripHistoryScreenController>();
  MyTripPermitDetails get myTripPermitDetails =>
      myTripPermitDetailsController.myTripPermitDetails;
  set myTripPermitDetails(MyTripPermitDetails value) {
    myTripPermitDetailsController.myTripPermitDetails = value;
    update();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  void onRenewNowButtonTap() {
    Get.toNamed(AppPageNames.tripPermitPaymentSummeryScreen,
        arguments: TripPermitPaymentSummeryScreenParameter(
            subscriptionID: tripPermitController.tripPermitListData.id,
            pricingModel: myTripPermitDetails.subscribed.pricingModels,
            isRenew: true,
            isFromMyTripPermitDetailsScreen: true));
  }

  // Method to toggle the switch
  void toggleAutoRenew() {
    toggleMyTripPermitSubscription(
        isAutoRenewActive: !myTripPermitDetails.subscribed.autoRenewal);
  }

  void onTransactionViewDetailsTap(MyTripPermitTransaction transaction) {
    Get.toNamed(AppPageNames.tripPermitTransactionHistoryDetailsScreen,
        arguments: transaction);
  }

  Future<void> toggleMyTripPermitSubscription(
      {required bool isAutoRenewActive}) async {
    final profileService = Get.find<ProfileService>();
    isLoading = true;
    final response =
        await APIRepo.updateTripPermitSubscriptionAutoRenew(requestBody: {
      'subscribed_id': myTripPermitDetails.subscribed.id,
      'pricing_models_id': myTripPermitDetails.subscribed.pricingModels.id,
      'vehicle_id': profileService.profileDetails.vehicle.active.id,
      'renewal_type': isAutoRenewActive ? 'auto' : 'manual',
    });
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.errorMessage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.errorMessage);
      return;
    }
    _onToggleMyTripPermitSubscriptionSuccess(response.message);
  }

  Future<void> _onToggleMyTripPermitSubscriptionSuccess(
      String responseMessage) async {
    myTripPermitDetails.subscribed.autoRenewal =
        !myTripPermitDetails.subscribed.autoRenewal;
    update();
    AppDialogs.showSuccessDialog(messageText: responseMessage);
    await tripPermitController.getPackageList();
    update();
  }

  Future<void> getMyTripPermitDetails() async {
    isLoading = true;
    final response = await APIRepo.getMyTripPermitDetails();
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.errorMessage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.errorMessage);
      return;
    }
    myTripPermitDetails = response.data;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
