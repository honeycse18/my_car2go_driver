import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/api_response.dart';
import 'package:car2godriver/models/api_responses/wallet_details.dart';
import 'package:car2godriver/models/api_responses/wallet_history_response.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class WalletScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  WalletDetails walletDetails = WalletDetails.empty();
  // PagingController<int, TransactionHistoryItems> transactionHistoryPagingController = PagingController(firstPageKey: 1);

/* <---- Get Transaction History from API ----> */
  String formatTitle(String title) {
    return title
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  void onTopUpButtonTap() {
    Get.toNamed(AppPageNames.topUpScreen);
  }

  Future<void> getTransactionHistory(int currentPageNumber) async {
    WalletTransactionHistoryResponse? response =
        await APIRepo.getTransactionHistory(currentPageNumber);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetChatUsersList(response);
  }

  void onSuccessGetChatUsersList(WalletTransactionHistoryResponse response) {
    // final isLastPage = !response.data.hasNextPage;
    // if (isLastPage) {
    // transactionHistoryPagingController.appendLastPage(response.data.docs);
    return;
    // }
    /* final nextPageNumber = response.data.page + 1;
    transactionHistoryPagingController.appendPage(response.data.docs, nextPageNumber); */
  }

  /* <---- Get wallet details from API  ----> */
  Future<void> getWalletDetails() async {
    isLoading = true;
    final response = await APIRepo.getWalletDetailsUpdated();
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);
      return;
    }
    log((response
        .toJson(
          (data) => data.toJson(),
        )
        .toString()));
    onSuccessGetWalletDetails(response);
  }

  void onSuccessGetWalletDetails(APIResponse<WalletDetails> response) {
    walletDetails = response.data;
    update();
  }

  /* void updateFromHomeNavigator() {
    final homeNavController = Get.find<HomeNavigatorScreenController>();
    homeNavController;
  } */

  /* <---- Initial state ----> */
  @override
  void onInit() {
    getWalletDetails();
    // transactionHistoryPagingController.addPageRequestListener((pageKey) { getTransactionHistory(pageKey); });
    super.onInit();
  }
}
