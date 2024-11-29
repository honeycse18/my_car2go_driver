import 'package:car2godriver/utils/helpers/api_helper.dart';

class SendOtp {
  String type;
  String identifier;

  SendOtp({this.type = '', this.identifier = ''});

  factory SendOtp.fromJson(Map<String, dynamic> json) => SendOtp(
        type: APIHelper.getSafeString(json['type']),
        identifier: APIHelper.getSafeString(json['identifier']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'identifier': identifier,
      };

  static SendOtp getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SendOtp.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : SendOtp();
}
