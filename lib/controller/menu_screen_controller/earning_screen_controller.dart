import 'dart:developer';

import 'package:car2godriver/models/api_responses/earnings_response.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class EarningScreenController extends GetxController {
  DateTime selectedDate = DateTime.now();
  List<EarningGraphList> earningCartList = [];

  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    update(); // This will update all GetX builders that are listening to this controller
    getEarningHistory();
    update();
  }

  Future<void> getEarningHistory() async {
    EarningsResponse? response = await APIRepo.getEarningHistory(
        Helper.yyyyMMddFormattedDateTime(
            selectedDate.subtract(const Duration(days: 7))),
        Helper.yyyyMMddFormattedDateTime(
            selectedDate.add(const Duration(days: 1))));
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _getEarningHistory(response);
  }

  void _getEarningHistory(EarningsResponse response) async {
    earningCartList = response.data;
    update();
  }

  @override
  void onInit() {
    getEarningHistory();
    super.onInit();
  }
}
