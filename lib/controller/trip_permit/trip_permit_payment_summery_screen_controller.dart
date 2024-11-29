import 'dart:developer';

import 'package:car2godriver/controller/menu_screen_controller/wallet_screen_controller.dart';
import 'package:car2godriver/controller/trip_permit/trip_permit_screen_controller.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/api_response.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/payment_api_response.dart';
import 'package:car2godriver/models/api_responses/package_list_response.dart';
import 'package:car2godriver/models/api_responses/site_settings.dart';
import 'package:car2godriver/models/api_responses/trip_permit_details.dart';
import 'package:car2godriver/models/api_responses/trip_permit_list_data.dart';
import 'package:car2godriver/models/payment_option_model.dart';
import 'package:car2godriver/models/screenParameters/trip_permit_payment_summery_screen_parameter.dart';
import 'package:car2godriver/services/profile_service.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:get/get.dart';

class TripPermitPaymentSummeryScreenController extends GetxController {
  final tripPermitController = Get.find<TripPermitScreenController>();
  bool isRenew = false;
  bool isFromMyTripPermitDetailsScreen = false;
  TripPermitDetails tripPermitDetails = TripPermitDetails.empty();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  int selectedReasonIndex = -1;
  SettingsPaymentGateway selectedPaymentOption = SettingsPaymentGateway();
/*   SelectPaymentOptionModel _selectedPaymentOption = SelectPaymentOptionModel();
  SelectPaymentOptionModel get selectedPaymentOption => _selectedPaymentOption;
  set selectedPaymentOption(SelectPaymentOptionModel value) {
    _selectedPaymentOption = value;
    update();
  } */

  // PackageResponseList selectedPackage = PackageResponseList();
  // TripPermitPricingModel selectedPricingModel = TripPermitPricingModel();
  String subscriptionID = '';
  TripPermitPricingModel selectedPackage = TripPermitPricingModel();

  // bool get shouldEnableConfirmAndPayButton => selectedPaymentOption.isNotEmpty;
  // bool get shouldDisableConfirmAndPayButton => selectedPaymentOption.isEmpty;

  void onPaymentOptionTap(SettingsPaymentGateway paymentOption) {
    selectedPaymentOption = paymentOption;
    update();
  }

  void onConfirmAndPayButtonTap() {
    // Get.toNamed(AppPageNames.tripPermitHistoryScreen);
    onPayTripPayment();
  }

  /*<------- Trip Permit payment -------->*/
  Future<void> onPayTripPayment() async {
    final profileService = Get.find<ProfileService>();
    isLoading = true;
    final response = await APIRepo.payTripPermit(requestBody: {
      'subscription_id': subscriptionID,
      'pricing_models_id': selectedPackage.id,
      'vehicle_id': profileService.profileDetails.vehicle.active.id,
    });
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);
      return;
    }
    _onPayTripPaymentSuccess(response);
  }

  void _onPayTripPaymentSuccess(APIResponse<void> response) {
    Helper.showSnackBar(response.message);
    _updateWalletScreen();
    tripPermitController.getPackageList();
    Get.back(result: true);
  }

  void _updateWalletScreen() {
    try {
      final walletScreenController = Get.find<WalletScreenController>();
      walletScreenController.getWalletDetails();
    } catch (_) {}
  }

  _onSucessPaymentStatus(PaymentAPIResponse response) async {
    // Get.to(() => InAppWebViewScreen(response.data));
    await Get.toNamed(AppPageNames.inAppWebViewScreen,
        arguments: response.data);
    update();
    _initializeAfterDelay(response);
  }

  _onSucessWalletPaymentStatus(PaymentAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
    Get.back();
    // Helper.getBackToHomePage();
  }

  _initializeAfterDelay(PaymentAPIResponse response) async {
    await Future.delayed(const Duration(seconds: 3));
    // AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    // if (argument is TripPermitPricingModel) {
    if (argument is TripPermitPaymentSummeryScreenParameter) {
      subscriptionID = argument.subscriptionID;
      selectedPackage = argument.pricingModel;
      isRenew = argument.isRenew;
      isFromMyTripPermitDetailsScreen =
          argument.isFromMyTripPermitDetailsScreen;
    }
  }

  Future<void> _getPackageDetails() async {
    isLoading = true;
    final response = await APIRepo.getTripPermitDetails(queries: {
      'subscription_id': subscriptionID,
      'pricing_models_id': selectedPackage.id
    });
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.errorMessage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.errorMessage);
      return;
    }
    tripPermitDetails = response.data;
    update();
  }

  @override
  void onInit() {
    _getScreenParameter();
    _getPackageDetails();
    super.onInit();
  }
}
