import 'package:car2godriver/utils/helpers/api_helper.dart';

class RawAPIResponse {
  bool success;
  bool error;
  String msg;
  dynamic data;

  RawAPIResponse(
      {this.success = false, this.error = false, this.msg = '', this.data});

  factory RawAPIResponse.fromJson(Map<String, dynamic> json) {
    return RawAPIResponse(
      success: APIHelper.getSafeBool(json['success']),
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'error': error,
        'msg': msg,
        'data': data,
      };

  static RawAPIResponse getAPIResponseObjectSafeValue<D>(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RawAPIResponse.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : RawAPIResponse();
}
