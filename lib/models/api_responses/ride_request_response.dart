import 'package:car2godriver/models/api_responses/ride_history_response.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class RideRequestResponse {
  bool error;
  String msg;
  List<RideHistoryDoc> data;

  RideRequestResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory RideRequestResponse.fromJson(Map<String, dynamic> json) {
    return RideRequestResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: APIHelper.getSafeList(json['data'])
          .map((e) => RideHistoryDoc.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static RideRequestResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideRequestResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideRequestResponse();
}
/* 
class RideRequestListItem {
  From from;
  To to;
  Distance distance;
  Duration duration;
  String id;
  Driver driver;
  User user;
  Ride ride;
  double total;
  DateTime expireAt;
  DateTime createdAt;
  DateTime updatedAt;

  RideRequestListItem({
    required this.from,
    required this.to,
    required this.distance,
    required this.duration,
    this.id = '',
    required this.driver,
    required this.user,
    required this.ride,
    this.total = 0,
    required this.expireAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RideRequestListItem.fromJson(Map<String, dynamic> json) =>
      RideRequestListItem(
        from: From.getAPIResponseObjectSafeValue(json['from']),
        to: To.getAPIResponseObjectSafeValue(json['to']),
        distance: Distance.getAPIResponseObjectSafeValue(json['distance']),
        duration: Duration.getAPIResponseObjectSafeValue(json['duration']),
        id: APIHelper.getSafeStringValue(json['_id']),
        driver: Driver.getAPIResponseObjectSafeValue(json['driver']),
        user: User.getAPIResponseObjectSafeValue(json['user']),
        ride: Ride.getAPIResponseObjectSafeValue(json['ride']),
        total: APIHelper.getSafeDoubleValue(json['total']),
        expireAt: APIHelper.getSafeDateTimeValue(json['expireAt']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'from': from.toJson(),
        'to': to.toJson(),
        'distance': distance.toJson(),
        'duration': duration.toJson(),
        '_id': id,
        'driver': driver.toJson(),
        'user': user.toJson(),
        'ride': ride.toJson(),
        'total': total,
        'expireAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(expireAt),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory RideRequestListItem.empty() => RideRequestListItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        distance: Distance(),
        driver: Driver(),
        expireAt: AppComponents.defaultUnsetDateTime,
        duration: Duration(),
        from: From.empty(),
        ride: Ride.empty(),
        to: To.empty(),
        updatedAt: AppComponents.defaultUnsetDateTime,
        user: User(),
      );
  static RideRequestListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideRequestListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideRequestListItem.empty();
}

class User {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  User(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.email = '',
      this.image = ''});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
      };

  static User getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? User.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : User();
}

class Vehicle {
  String id;
  String name;
  String model;
  List<String> images;
  int capacity;
  String color;

  Vehicle({
    this.id = '',
    this.name = '',
    this.model = '',
    this.images = const [],
    this.capacity = 0,
    this.color = '',
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        model: APIHelper.getSafeStringValue(json['model']),
        images: APIHelper.getSafeListValue(json['images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        capacity: APIHelper.getSafeIntValue(json['capacity']),
        color: APIHelper.getSafeStringValue(json['color']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'model': model,
        'images': images,
        'capacity': capacity,
        'color': color,
      };

  static Vehicle getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Vehicle.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Vehicle();
}

class Ride {
  String id;
  Vehicle vehicle;

  Ride({this.id = '', required this.vehicle});

  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
        id: APIHelper.getSafeStringValue(json['_id']),
        vehicle: Vehicle.getAPIResponseObjectSafeValue(json['vehicle']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'vehicle': vehicle.toJson(),
      };

  factory Ride.empty() => Ride(
        vehicle: Vehicle(),
      );
  static Ride getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Ride.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Ride.empty();
}

class To {
  Location location;
  String address;

  To({required this.location, this.address = ''});

  factory To.fromJson(Map<String, dynamic> json) => To(
        location: Location.getAPIResponseObjectSafeValue(json['location']),
        address: APIHelper.getSafeStringValue(json['address']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'address': address,
      };

  factory To.empty() => To(
        location: Location(),
      );
  static To getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? To.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : To.empty();
}

class Location {
  double lat;
  double lng;

  Location({this.lat = 0, this.lng = 0});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static Location getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Location.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Location();
}

class From {
  Location location;
  String address;

  From({required this.location, this.address = ''});

  factory From.fromJson(Map<String, dynamic> json) => From(
        location: Location.getAPIResponseObjectSafeValue(json['location']),
        address: APIHelper.getSafeStringValue(json['address']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'address': address,
      };

  factory From.empty() => From(location: Location());
  static From getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? From.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : From.empty();
}

class Distance {
  String text;
  int value;

  Distance({this.text = '', this.value = 0});

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        text: APIHelper.getSafeStringValue(json['text']),
        value: APIHelper.getSafeIntValue(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static Distance getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Distance.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Distance();
}

class Duration {
  String text;
  int value;

  Duration({this.text = '', this.value = 0});

  factory Duration.fromJson(Map<String, dynamic> json) => Duration(
        text: APIHelper.getSafeStringValue(json['text']),
        value: APIHelper.getSafeIntValue(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static Duration getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Duration.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Duration();
}

class Driver {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  Driver({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
      };

  static Driver getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Driver.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Driver();
}
 */
