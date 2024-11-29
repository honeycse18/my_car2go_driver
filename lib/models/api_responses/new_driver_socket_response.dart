import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class NewDriverSocketResponse {
  NewDriverSocketDriver driver;
  NewDriverSocketOwner owner;
  bool fleet;
  String status;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  NewDriverSocketResponse({
    required this.driver,
    required this.owner,
    this.fleet = false,
    this.status = '',
    this.id = '',
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory NewDriverSocketResponse.fromJson(Map<String, dynamic> json) {
    return NewDriverSocketResponse(
      driver:
          NewDriverSocketDriver.getAPIResponseObjectSafeValue(json['driver']),
      owner: NewDriverSocketOwner.getAPIResponseObjectSafeValue(json['owner']),
      fleet: APIHelper.getSafeBool(json['fleet']),
      status: APIHelper.getSafeString(json['status']),
      id: APIHelper.getSafeString(json['_id']),
      createdAt: APIHelper.getSafeDateTime(json['createdAt']),
      updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      v: APIHelper.getSafeInt(json['__v']),
    );
  }

  Map<String, dynamic> toJson() => {
        'driver': driver.toJson(),
        'owner': owner.toJson(),
        'fleet': fleet,
        'status': status,
        '_id': id,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory NewDriverSocketResponse.empty() => NewDriverSocketResponse(
      driver: NewDriverSocketDriver(),
      owner: NewDriverSocketOwner(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static NewDriverSocketResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NewDriverSocketResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NewDriverSocketResponse.empty();
}

class NewDriverSocketDriver {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  NewDriverSocketDriver({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
  });

  factory NewDriverSocketDriver.fromJson(Map<String, dynamic> json) =>
      NewDriverSocketDriver(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        phone: APIHelper.getSafeString(json['phone']),
        email: APIHelper.getSafeString(json['email']),
        image: APIHelper.getSafeString(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
      };

  static NewDriverSocketDriver getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NewDriverSocketDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NewDriverSocketDriver();
}

class NewDriverSocketOwner {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  NewDriverSocketOwner(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.email = '',
      this.image = ''});

  factory NewDriverSocketOwner.fromJson(Map<String, dynamic> json) =>
      NewDriverSocketOwner(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        phone: APIHelper.getSafeString(json['phone']),
        email: APIHelper.getSafeString(json['email']),
        image: APIHelper.getSafeString(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
      };

  static NewDriverSocketOwner getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NewDriverSocketOwner.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NewDriverSocketOwner();
}
