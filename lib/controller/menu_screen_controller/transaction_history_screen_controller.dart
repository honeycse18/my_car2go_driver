import 'dart:developer';

import 'package:car2godriver/models/api_responses/core_api_responses/api_response.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:car2godriver/models/api_responses/wallet_details.dart';
import 'package:car2godriver/models/api_responses/wallet_history_response.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransactionHistoryScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  String symbol = '';
  PagingController<int, WalletTransaction> transactionHistoryPagingController =
      PagingController(firstPageKey: 1);

  String formatTitle(String title) {
    return title
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  /* <---- Get Transaction History from API ----> */
  Future<void> getTransactionHistory(int currentPageNumber) async {
    final response = await APIRepo.getWalletTransactionHistoryUpdated(
        queries: {'page': currentPageNumber.toString()});
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);
      return;
    }
    onSuccessGetChatUsersList(response);
  }

  void onSuccessGetChatUsersList(
      APIResponse<PaginatedDataResponse<WalletTransaction>> response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      transactionHistoryPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    transactionHistoryPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  /*<----------- Fetch screen navigation argument----------->*/
  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      symbol = argument;
      update();
    }
  }

  /* <---- Initial state ----> */
  @override
  void onInit() {
    _getScreenParameters();
    transactionHistoryPagingController.addPageRequestListener((pageKey) {
      getTransactionHistory(pageKey);
    });
    super.onInit();
  }
}
