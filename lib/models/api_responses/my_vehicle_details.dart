import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class MyVehicleDetails {
  String id;
  String driver;
  MyVehicleType vehicleType;
  String brand;
  String model;
  String year;
  int seat;
  String carNumberPlate;
  List<String> images;
  String status;
  bool isOnline;
  bool isActive;
  String rideStatus;
  List<MyVehicleDynamicField> dynamicFields;
  DateTime createdAt;
  DateTime updatedAt;

  MyVehicleDetails({
    this.id = '',
    this.driver = '',
    required this.vehicleType,
    this.brand = '',
    this.model = '',
    this.year = '',
    this.seat = 0,
    this.carNumberPlate = '',
    this.images = const [],
    this.status = '',
    this.isOnline = false,
    this.isActive = false,
    this.rideStatus = '',
    this.dynamicFields = const [],
    required this.createdAt,
    required this.updatedAt,
  });
  factory MyVehicleDetails.empty() => MyVehicleDetails(
      vehicleType: MyVehicleType(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  factory MyVehicleDetails.fromJson(Map<String, dynamic> json) {
    return MyVehicleDetails(
      id: APIHelper.getSafeString(json['_id']),
      driver: APIHelper.getSafeString(json['driver']),
      vehicleType: MyVehicleType.getSafeObject(json['vehicle_type']),
      brand: APIHelper.getSafeString(json['brand']),
      model: APIHelper.getSafeString(json['model']),
      year: APIHelper.getSafeString(json['year']),
      seat: APIHelper.getSafeInt(json['seat'], 0),
      carNumberPlate: APIHelper.getSafeString(json['car_number_plate']),
      images: APIHelper.getSafeList(json['images'])
          .map((e) => APIHelper.getSafeString(e))
          .toList(),
      status: APIHelper.getSafeString(json['status']),
      isOnline: APIHelper.getSafeBool(json['isOnline']),
      isActive: APIHelper.getSafeBool(json['isActive']),
      rideStatus: APIHelper.getSafeString(json['ride_status']),
      dynamicFields: APIHelper.getSafeList(json['dynamic_fields'])
          .map((e) => MyVehicleDynamicField.getSafeObject(e))
          .toList(),
      createdAt: APIHelper.getSafeDateTime(json['createdAt']),
      updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'driver': driver,
        'vehicle_type': vehicleType.toJson(),
        'brand': brand,
        'model': model,
        'year': year,
        'seat': seat,
        'car_number_plate': carNumberPlate,
        'images': images,
        'status': status,
        'isOnline': isOnline,
        'isActive': isActive,
        'ride_status': rideStatus,
        'dynamic_fields': dynamicFields.map((e) => e.toJson()).toList(),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  static MyVehicleDetails getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyVehicleDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyVehicleDetails.empty();
}

class MyVehicleType {
  String id;
  String name;

  MyVehicleType({this.id = '', this.name = ''});

  factory MyVehicleType.fromJson(Map<String, dynamic> json) => MyVehicleType(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static MyVehicleType getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyVehicleType.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : MyVehicleType();
}

class MyVehicleDynamicField {
  String key;
  List<String> value;
  String type;

  MyVehicleDynamicField({this.key = '', this.value = const [], this.type = ''});

  factory MyVehicleDynamicField.fromJson(Map<String, dynamic> json) =>
      MyVehicleDynamicField(
        key: APIHelper.getSafeString(json['key']),
        value: APIHelper.getSafeList(json['value'])
            .map((e) => APIHelper.getSafeString(e))
            .toList(),
        type: APIHelper.getSafeString(json['type']),
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
        'type': type,
      };

  static MyVehicleDynamicField getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyVehicleDynamicField.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyVehicleDynamicField();
}
