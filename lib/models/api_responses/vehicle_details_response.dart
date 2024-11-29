import 'package:car2godriver/models/api_responses/car_categories_response.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/constants/app_components.dart';

class VehicleDetailsResponse {
  bool error;
  String msg;
  VehicleDetailsItem data;

  VehicleDetailsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory VehicleDetailsResponse.fromJson(Map<String, dynamic> json) {
    return VehicleDetailsResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: VehicleDetailsItem.getAPIResponseObjectSafeValue(
          json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory VehicleDetailsResponse.empty() => VehicleDetailsResponse(
        data: VehicleDetailsItem.empty(),
      );
  static VehicleDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? VehicleDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : VehicleDetailsResponse.empty();
}

class VehicleDetailsItem {
  String id;
  String uid;
  VehicleOwner owner;
  String name;
  CarCategoriesCategory category;
  String model;
  String year;
  List<String> images;
  String maxPower;
  String maxSpeed;
  int capacity;
  String color;
  String fuelType;
  int mileage;
  String gearType;
  bool ac;
  String vehicleNumber;
  List<String> documents;
  String status;
  DateTime updatedAt;

  VehicleDetailsItem({
    this.id = '',
    this.uid = '',
    required this.owner,
    this.name = '',
    required this.category,
    this.model = '',
    this.year = '',
    this.images = const [],
    this.maxPower = '',
    this.maxSpeed = '',
    this.capacity = 0,
    this.color = '',
    this.fuelType = '',
    this.mileage = 0,
    this.gearType = '',
    this.vehicleNumber = '',
    this.ac = false,
    this.documents = const [],
    this.status = '',
    required this.updatedAt,
  });

  factory VehicleDetailsItem.fromJson(Map<String, dynamic> json) =>
      VehicleDetailsItem(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        owner: VehicleOwner.getAPIResponseObjectSafeValue(json['owner']),
        name: APIHelper.getSafeString(json['name']),
        category: CarCategoriesCategory.getAPIResponseObjectSafeValue(
            json['category']),
        model: APIHelper.getSafeString(json['model']),
        year: APIHelper.getSafeString(json['year']),
        images: APIHelper.getSafeList(json['images'])
            .map((e) => APIHelper.getSafeString(e))
            .toList(),
        maxPower: APIHelper.getSafeString(json['max_power']),
        maxSpeed: APIHelper.getSafeString(json['max_speed']),
        capacity: APIHelper.getSafeInt(json['capacity']),
        color: APIHelper.getSafeString(json['color']),
        fuelType: APIHelper.getSafeString(json['fuel_type']),
        mileage: APIHelper.getSafeInt(json['mileage']),
        gearType: APIHelper.getSafeString(json['gear_type']),
        ac: APIHelper.getSafeBool(json['ac']),
        vehicleNumber: APIHelper.getSafeString(json['vehicle_number']),
        documents: APIHelper.getSafeList(json['documents'])
            .map((e) => APIHelper.getSafeString(e))
            .toList(),
        status: APIHelper.getSafeString(json['status']),
        updatedAt: APIHelper.getSafeDateTime(
            APIHelper.getSafeString(json['updatedAt'])),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'owner': owner.toJson(),
        'name': name,
        'category': category.toJson(),
        'model': model,
        'year': year,
        'images': images,
        'max_power': maxPower,
        'max_speed': maxSpeed,
        'capacity': capacity,
        'color': color,
        'fuel_type': fuelType,
        'mileage': mileage,
        'gear_type': gearType,
        'ac': ac,
        'vehicle_number': vehicleNumber,
        'documents': documents,
        'status': status,
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory VehicleDetailsItem.empty() => VehicleDetailsItem(
        category: CarCategoriesCategory(),
        owner: VehicleOwner(),
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static VehicleDetailsItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? VehicleDetailsItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : VehicleDetailsItem.empty();
}

/* class VehicleCategory {
  String id;
  String name;

  VehicleCategory({this.id = '', this.name = ''});

  factory VehicleCategory.fromJson(Map<String, dynamic> json) =>
      VehicleCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static VehicleCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? VehicleCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : VehicleCategory();
} */

class VehicleOwner {
  String id;
  String name;
  String phone;
  String email;

  VehicleOwner(
      {this.id = '', this.name = '', this.phone = '', this.email = ''});

  factory VehicleOwner.fromJson(Map<String, dynamic> json) => VehicleOwner(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
        phone: APIHelper.getSafeString(json['phone']),
        email: APIHelper.getSafeString(json['email']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'phone': phone,
        'email': email,
      };

  static VehicleOwner getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? VehicleOwner.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : VehicleOwner();
}
