import 'package:car2godriver/utils/helpers/api_helper.dart';

class PullingNewRequestSocketResponse {
  String offer;

  PullingNewRequestSocketResponse({this.offer = ''});

  factory PullingNewRequestSocketResponse.fromJson(Map<String, dynamic> json) {
    return PullingNewRequestSocketResponse(
      offer: APIHelper.getSafeString(json['offer']),
    );
  }

  Map<String, dynamic> toJson() => {
        'offer': offer,
      };

  static PullingNewRequestSocketResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingNewRequestSocketResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingNewRequestSocketResponse();
}
