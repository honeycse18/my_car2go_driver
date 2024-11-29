import 'package:car2godriver/models/api_responses/vehicle_brand_info.dart';
import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class VehicleModelInfo {
  String id;
  String name;
  String description;
  String image;
  VehicleBrandInfo brand;
  List<String> vehicleType;
  String attributeType;
  DateTime createdAt;
  DateTime updatedAt;

  VehicleModelInfo({
    this.id = '',
    this.name = '',
    this.description = '',
    this.image = '',
    required this.brand,
    this.vehicleType = const [],
    this.attributeType = '',
    required this.createdAt,
    required this.updatedAt,
  });
  factory VehicleModelInfo.empty() => VehicleModelInfo(
      createdAt: AppConstants.defaultUnsetDateTime,
      updatedAt: AppConstants.defaultUnsetDateTime,
      brand: VehicleBrandInfo.empty());

  factory VehicleModelInfo.fromJson(Map<String, dynamic> json) {
    return VehicleModelInfo(
      id: APIHelper.getSafeString(json['_id']),
      name: APIHelper.getSafeString(json['name']),
      description: APIHelper.getSafeString(json['description']),
      image: APIHelper.getSafeString(json['image']),
      brand:
          VehicleBrandInfo.getSafeObject(json['brand'] as Map<String, dynamic>),
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
        'brand': brand.toJson(),
        'vehicle_type': vehicleType,
        'attribute_type': attributeType,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  static VehicleModelInfo getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? VehicleModelInfo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : VehicleModelInfo.empty();
}
