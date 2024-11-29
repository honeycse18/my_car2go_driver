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

class TripPermitTransactionHistoryScreenController extends GetxController {
  MyTripPermitTransaction transactionDetails = MyTripPermitTransaction.empty();

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is MyTripPermitTransaction) {
      transactionDetails = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    super.onInit();
  }
}
