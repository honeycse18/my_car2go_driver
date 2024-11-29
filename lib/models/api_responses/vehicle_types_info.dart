import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class VehicleTypeInfo {
  String id;
  String name;
  String image;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  VehicleTypeInfo(
      {this.id = '',
      this.name = '',
      this.image = '',
      this.description = '',
      required this.createdAt,
      required this.updatedAt});

  factory VehicleTypeInfo.empty() => VehicleTypeInfo(
      createdAt: AppConstants.defaultUnsetDateTime,
      updatedAt: AppConstants.defaultUnsetDateTime);

  factory VehicleTypeInfo.fromJson(Map<String, dynamic> json) =>
      VehicleTypeInfo(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
        image: APIHelper.getSafeString(json['image']),
        description: APIHelper.getSafeString(json['description']),
        createdAt: APIHelper.getSafeDateTime(json['name']),
        updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'image': image,
        'description': description,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  static VehicleTypeInfo getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? VehicleTypeInfo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : VehicleTypeInfo.empty();

  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => isEmpty == false;
}
