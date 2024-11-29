import 'package:car2godriver/models/enums/my_vehicle_status.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class MyVehiclesData {
  List<MyVehicleType> vehicleTypes;
  List<MyVehicle> vehicles;

  MyVehiclesData({this.vehicleTypes = const [], this.vehicles = const []});

  factory MyVehiclesData.fromJson(Map<String, dynamic> json) {
    return MyVehiclesData(
      vehicleTypes: APIHelper.getSafeList(json['vehicle_types'])
          .map((e) => MyVehicleType.getSafeObject(e))
          .toList(),
      vehicles: APIHelper.getSafeList(json['vehicles'])
          .map((e) => MyVehicle.getSafeObject(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'vehicle_types': vehicleTypes.map((e) => e.toJson()).toList(),
        'vehicles': vehicles.map((e) => e.toJson()).toList(),
      };

  static MyVehiclesData getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyVehiclesData.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : MyVehiclesData();
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

class MyVehicle {
  String id;
  String brand;
  String model;
  String year;
  int seat;
  String carNumberPlate;
  List<String> images;
  String status;
  bool isActive;

  MyVehicle({
    this.id = '',
    this.brand = '',
    this.model = '',
    this.year = '',
    this.seat = 0,
    this.carNumberPlate = '',
    this.images = const [],
    this.status = '',
    this.isActive = false,
  });

  factory MyVehicle.fromJson(Map<String, dynamic> json) => MyVehicle(
        id: APIHelper.getSafeString(json['_id']),
        brand: APIHelper.getSafeString(json['brand']),
        model: APIHelper.getSafeString(json['model']),
        year: APIHelper.getSafeString(json['year']),
        seat: APIHelper.getSafeInt(json['int'], 0),
        carNumberPlate: APIHelper.getSafeString(json['car_number_plate']),
        images: APIHelper.getSafeList(json['images'])
            .map(
              (e) => APIHelper.getSafeString(e),
            )
            .toList(),
        status: APIHelper.getSafeString(json['status']),
        isActive: APIHelper.getSafeBool(json['isActive']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'brand': brand,
        'model': model,
        'car_number_plate': carNumberPlate,
        'images': images,
        'status': status,
        'isActive': isActive,
      };

  static MyVehicle getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyVehicle.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : MyVehicle();

  MyVehicleStatus get statusAsEnum => MyVehicleStatus.fromString(status);
}
