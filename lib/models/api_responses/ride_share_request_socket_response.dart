import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class RideShareRequestSocketResponse {
  RideShareRequestSocketDriver driver;
  RideShareRequestSocketUser user;
  RideShareRequestSocketRide ride;
  DateTime date;
  bool schedule;
  RideShareRequestSocketFrom from;
  RideShareRequestSocketTo to;
  RideShareRequestSocketDistance distance;
  RideShareRequestSocketDuration duration;
  double total;
  String id;
  DateTime expireAt;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  RideShareRequestSocketResponse({
    required this.driver,
    required this.user,
    required this.ride,
    required this.date,
    this.schedule = false,
    required this.from,
    required this.to,
    required this.distance,
    required this.duration,
    this.total = 0,
    this.id = '',
    required this.expireAt,
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory RideShareRequestSocketResponse.fromJson(Map<String, dynamic> json) {
    return RideShareRequestSocketResponse(
      driver: RideShareRequestSocketDriver.getAPIResponseObjectSafeValue(
          json['driver']),
      user: RideShareRequestSocketUser.getAPIResponseObjectSafeValue(
          json['user']),
      ride: RideShareRequestSocketRide.getAPIResponseObjectSafeValue(
          json['ride']),
      date: APIHelper.getSafeDateTime(json['date']),
      schedule: APIHelper.getSafeBool(json['schedule']),
      from: RideShareRequestSocketFrom.getAPIResponseObjectSafeValue(
          json['from']),
      to: RideShareRequestSocketTo.getAPIResponseObjectSafeValue(json['to']),
      distance: RideShareRequestSocketDistance.getAPIResponseObjectSafeValue(
          json['distance']),
      duration: RideShareRequestSocketDuration.getAPIResponseObjectSafeValue(
          json['duration']),
      total: APIHelper.getSafeDouble(json['total']),
      id: APIHelper.getSafeString(json['_id']),
      expireAt: APIHelper.getSafeDateTime(json['expireAt']),
      createdAt: APIHelper.getSafeDateTime(json['createdAt']),
      updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      v: APIHelper.getSafeInt(json['__v']),
    );
  }

  Map<String, dynamic> toJson() => {
        'driver': driver.toJson(),
        'user': user.toJson(),
        'ride': ride.toJson(),
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'schedule': schedule,
        'from': from.toJson(),
        'to': to.toJson(),
        'distance': distance.toJson(),
        'duration': duration.toJson(),
        'total': total,
        '_id': id,
        'expireAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(expireAt),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory RideShareRequestSocketResponse.empty() =>
      RideShareRequestSocketResponse(
          driver: RideShareRequestSocketDriver(),
          user: RideShareRequestSocketUser(),
          ride: RideShareRequestSocketRide.empty(),
          date: AppComponents.defaultUnsetDateTime,
          from: RideShareRequestSocketFrom.empty(),
          to: RideShareRequestSocketTo.empty(),
          distance: RideShareRequestSocketDistance(),
          duration: RideShareRequestSocketDuration(),
          expireAt: AppComponents.defaultUnsetDateTime,
          createdAt: AppComponents.defaultUnsetDateTime,
          updatedAt: AppComponents.defaultUnsetDateTime);
  static RideShareRequestSocketResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideShareRequestSocketResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideShareRequestSocketResponse.empty();
}

class RideShareRequestSocketDistance {
  String text;
  int value;

  RideShareRequestSocketDistance({this.text = '', this.value = 0});

  factory RideShareRequestSocketDistance.fromJson(Map<String, dynamic> json) =>
      RideShareRequestSocketDistance(
        text: APIHelper.getSafeString(json['text']),
        value: APIHelper.getSafeInt(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static RideShareRequestSocketDistance getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideShareRequestSocketDistance.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideShareRequestSocketDistance();
}

class RideShareRequestSocketDriver {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  RideShareRequestSocketDriver({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
  });

  factory RideShareRequestSocketDriver.fromJson(Map<String, dynamic> json) =>
      RideShareRequestSocketDriver(
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
        'image': image
      };

  static RideShareRequestSocketDriver getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideShareRequestSocketDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideShareRequestSocketDriver();
}

class RideShareRequestSocketDuration {
  String text;
  int value;

  RideShareRequestSocketDuration({this.text = '', this.value = 0});

  factory RideShareRequestSocketDuration.fromJson(Map<String, dynamic> json) =>
      RideShareRequestSocketDuration(
        text: APIHelper.getSafeString(json['text']),
        value: APIHelper.getSafeInt(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static RideShareRequestSocketDuration getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideShareRequestSocketDuration.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideShareRequestSocketDuration();
}

class RideShareRequestSocketFrom {
  String address;
  RideShareRequestSocketLocation location;

  RideShareRequestSocketFrom({this.address = '', required this.location});

  factory RideShareRequestSocketFrom.fromJson(Map<String, dynamic> json) =>
      RideShareRequestSocketFrom(
        address: APIHelper.getSafeString(json['address']),
        location: RideShareRequestSocketLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'location': location.toJson(),
      };

  factory RideShareRequestSocketFrom.empty() => RideShareRequestSocketFrom(
        location: RideShareRequestSocketLocation(),
      );
  static RideShareRequestSocketFrom getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideShareRequestSocketFrom.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideShareRequestSocketFrom.empty();
}

class RideShareRequestSocketTo {
  String address;
  RideShareRequestSocketLocation location;

  RideShareRequestSocketTo({this.address = '', required this.location});

  factory RideShareRequestSocketTo.fromJson(Map<String, dynamic> json) =>
      RideShareRequestSocketTo(
        address: APIHelper.getSafeString(json['address']),
        location: RideShareRequestSocketLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'location': location.toJson(),
      };

  factory RideShareRequestSocketTo.empty() => RideShareRequestSocketTo(
        location: RideShareRequestSocketLocation(),
      );
  static RideShareRequestSocketTo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideShareRequestSocketTo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideShareRequestSocketTo.empty();
}

class RideShareRequestSocketLocation {
  double lat;
  double lng;

  RideShareRequestSocketLocation({this.lat = 0, this.lng = 0});

  factory RideShareRequestSocketLocation.fromJson(Map<String, dynamic> json) =>
      RideShareRequestSocketLocation(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static RideShareRequestSocketLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideShareRequestSocketLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideShareRequestSocketLocation();
}

class RideShareRequestSocketRide {
  String id;
  RideShareRequestSocketVehicle vehicle;

  RideShareRequestSocketRide({this.id = '', required this.vehicle});

  factory RideShareRequestSocketRide.fromJson(Map<String, dynamic> json) =>
      RideShareRequestSocketRide(
        id: APIHelper.getSafeString(json['_id']),
        vehicle: RideShareRequestSocketVehicle.getAPIResponseObjectSafeValue(
            json['vehicle']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'vehicle': vehicle.toJson(),
      };

  factory RideShareRequestSocketRide.empty() => RideShareRequestSocketRide(
        vehicle: RideShareRequestSocketVehicle(),
      );
  static RideShareRequestSocketRide getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideShareRequestSocketRide.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideShareRequestSocketRide.empty();
}

class RideShareRequestSocketVehicle {
  String id;
  String name;
  String model;
  List<String> images;
  int capacity;
  String color;

  RideShareRequestSocketVehicle({
    this.id = '',
    this.name = '',
    this.model = '',
    this.images = const [],
    this.capacity = 0,
    this.color = '',
  });

  factory RideShareRequestSocketVehicle.fromJson(Map<String, dynamic> json) =>
      RideShareRequestSocketVehicle(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
        model: APIHelper.getSafeString(json['model']),
        images: APIHelper.getSafeList(json['images'])
            .map((e) => APIHelper.getSafeString(e))
            .toList(),
        capacity: APIHelper.getSafeInt(json['capacity']),
        color: APIHelper.getSafeString(json['color']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'model': model,
        'images': images,
        'capacity': capacity,
        'color': color,
      };

  static RideShareRequestSocketVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideShareRequestSocketVehicle.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideShareRequestSocketVehicle();
}

class RideShareRequestSocketUser {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  RideShareRequestSocketUser({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
  });

  factory RideShareRequestSocketUser.fromJson(Map<String, dynamic> json) =>
      RideShareRequestSocketUser(
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
        'image': image
      };

  static RideShareRequestSocketUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideShareRequestSocketUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideShareRequestSocketUser();
}
