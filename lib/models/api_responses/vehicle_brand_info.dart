import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class VehicleBrandInfo {
  String id;
  String name;
  String description;
  String image;
  List<String> vehicleType;
  String attributeType;
  DateTime createdAt;
  DateTime updatedAt;

  VehicleBrandInfo({
    this.id = '',
    this.name = '',
    this.description = '',
    this.image = '',
    this.vehicleType = const [],
    this.attributeType = '',
    required this.createdAt,
    required this.updatedAt,
  });
  factory VehicleBrandInfo.empty() => VehicleBrandInfo(
      createdAt: AppConstants.defaultUnsetDateTime,
      updatedAt: AppConstants.defaultUnsetDateTime);

  factory VehicleBrandInfo.fromJson(Map<String, dynamic> json) {
    return VehicleBrandInfo(
      id: APIHelper.getSafeString(json['_id']),
      name: APIHelper.getSafeString(json['name']),
      description: APIHelper.getSafeString(json['description']),
      image: APIHelper.getSafeString(json['image']),
      vehicleType: APIHelper.getSafeList(json['vehicle_type'])
          .map((e) => APIHelper.getSafeString(e))
          .toList(),
      attributeType: APIHelper.getSafeString(json['attribute_type']),
      createdAt: APIHelper.getSafeDateTime(json['createdAt']),
      updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'image': image,
        'vehicle_type': vehicleType,
        'attribute_type': attributeType,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  static VehicleBrandInfo getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? VehicleBrandInfo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : VehicleBrandInfo.empty();
}
