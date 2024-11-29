import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:intl/intl.dart';

class EarningsResponse {
  bool error;
  String msg;
  List<EarningGraphList> data;

  EarningsResponse({this.error = false, this.msg = '', this.data = const []});

  factory EarningsResponse.fromJson(Map<String, dynamic> json) {
    return EarningsResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: APIHelper.getSafeList(json['data'])
          .map((e) => EarningGraphList.getAPIResponseObjectSafeValue(
              e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static EarningsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? EarningsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : EarningsResponse();
}

class EarningGraphList {
  String id;
  int trips;
  double total;
  DateTime date;

  EarningGraphList(
      {this.id = '', this.trips = 0, this.total = 0, required this.date});

  factory EarningGraphList.fromJson(Map<String, dynamic> json) =>
      EarningGraphList(
        id: APIHelper.getSafeString(json['_id']),
        trips: APIHelper.getSafeInt(json['trips']),
        total: APIHelper.getSafeDouble(json['total']),
        date: APIHelper.getSafeDateTime(json['_id'],
            dateTimeFormat: DateFormat('yy-MM-dd')),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'trips': trips,
        'total': total,
      };

  factory EarningGraphList.empty() =>
      EarningGraphList(date: AppComponents.defaultUnsetDateTime);
  static EarningGraphList getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? EarningGraphList.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : EarningGraphList.empty();
}
