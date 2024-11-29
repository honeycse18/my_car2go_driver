import 'package:car2godriver/models/api_responses/my_trip_permit_details.dart';
import 'package:car2godriver/models/api_responses/package_list_response.dart';
import 'package:car2godriver/models/api_responses/trip_permit_details.dart';
import 'package:car2godriver/models/api_responses/user_details_response.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TripHistoryScreenController extends GetxController {
  // List<Subscription> broughtSubscriptionList = [];
  MyTripPermitDetails myTripPermitDetails = MyTripPermitDetails.empty();
  PackageResponseList selectedPackage = PackageResponseList();
  PagingController<int, MyTripPermitTransaction>
      myTransactionsPagingController = PagingController(firstPageKey: 1);
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  var isAutoRenewEnabled = true.obs; // Default value is 'On'

  // Method to toggle the switch
  void toggleAutoRenew() {
    isAutoRenewEnabled.value = !isAutoRenewEnabled.value;
  }

  void onMyTripPermitViewDetailsTap() {
    Get.toNamed(AppPageNames.tripPermitViewDetailsScreen);
  }

  void onTransactionViewDetailsTap(MyTripPermitTransaction transaction) {
    Get.toNamed(AppPageNames.tripPermitTransactionHistoryDetailsScreen,
        arguments: transaction);
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

  Future<void> _getMyTripTransactionPaginated(
      {required int currentPage}) async {
    final response = await APIRepo.getMyTripPermitDetails(queries: {
      'page': currentPage.toString(),
    });
    if (response == null) {
      myTransactionsPagingController.error = response?.message ??
          AppLanguageTranslation
              .noResponseForThisActionTranskey.toCurrentLanguage;
      return;
    } else if (response.error) {
      myTransactionsPagingController.error = response.message;
      return;
    }
    final transactionPaginated = response.data.transactions;
    final isLastPage = transactionPaginated.hasNextPage == false;
    if (isLastPage) {
      myTransactionsPagingController.appendLastPage(transactionPaginated.docs);
      return;
    }
    final nextPageNumber = transactionPaginated.page + 1;
    myTransactionsPagingController.appendPage(
        transactionPaginated.docs, nextPageNumber);
  }

  @override
  void onInit() {
    getMyTripPermitDetails();

    myTransactionsPagingController.addPageRequestListener((pageKey) {
      _getMyTripTransactionPaginated(currentPage: pageKey);
    });
    super.onInit();
  }
}
