import 'package:car2godriver/utils/helpers/api_helper.dart';

class PaymentAPIResponse {
  bool error;
  String msg;
  dynamic data;

  PaymentAPIResponse({this.error = false, this.msg = '', this.data});

  factory PaymentAPIResponse.fromJson(Map<String, dynamic> json) {
    return PaymentAPIResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'url': data,
      };

  static PaymentAPIResponse getAPIResponseObjectSafeValue<D>(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PaymentAPIResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PaymentAPIResponse();
}
