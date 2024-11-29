import 'package:car2godriver/models/api_responses/common/location_position.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class VehicleOnlineOfflineResponse {
  String id;
  String brand;
  String model;
  bool isActive;
  bool isOnline;
  LocationPosition position;

  VehicleOnlineOfflineResponse({
    this.id = '',
    this.brand = '',
    this.model = '',
    this.isActive = false,
    this.isOnline = false,
    required this.position,
  });
  factory VehicleOnlineOfflineResponse.empty() =>
      VehicleOnlineOfflineResponse(position: LocationPosition());

  factory VehicleOnlineOfflineResponse.fromJson(Map<String, dynamic> json) {
    return VehicleOnlineOfflineResponse(
      id: APIHelper.getSafeString(json['_id']),
      brand: APIHelper.getSafeString(json['brand']),
      model: APIHelper.getSafeString(json['model']),
      isActive: APIHelper.getSafeBool(json['isActive']),
      isOnline: APIHelper.getSafeBool(json['isOnline']),
      position: LocationPosition.getSafeObject(json['position']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'brand': brand,
        'model': model,
        'isActive': isActive,
        'isOnline': isOnline,
        'position': position.toJson(),
      };

  static VehicleOnlineOfflineResponse getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? VehicleOnlineOfflineResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : VehicleOnlineOfflineResponse.empty();
}
