import 'package:car2godriver/utils/helpers/api_helper.dart';

class VerifyOtp {
  String accessToken;

  VerifyOtp({this.accessToken = ''});

  factory VerifyOtp.fromJson(Map<String, dynamic> json) => VerifyOtp(
        accessToken: APIHelper.getSafeString(json['accessToken']),
      );

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
      };

  static VerifyOtp getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? VerifyOtp.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : VerifyOtp();
}
