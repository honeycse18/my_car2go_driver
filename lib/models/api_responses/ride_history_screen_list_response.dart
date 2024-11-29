import 'package:car2godriver/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class RideHistoryScreenListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<RideHistoryListItem> data;

  RideHistoryScreenListResponse(
      {this.error = false, this.msg = '', required this.data});

  factory RideHistoryScreenListResponse.fromJson(Map<String, dynamic> json) {
    return RideHistoryScreenListResponse(
      error: (json['error']),
      msg: (json['msg']),
      data: PaginatedDataResponse.getSafeObject(
        json['data'],
        docFromJson: (data) =>
            RideHistoryListItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory RideHistoryScreenListResponse.empty() =>
      RideHistoryScreenListResponse(data: PaginatedDataResponse.empty());
  static RideHistoryScreenListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryScreenListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryScreenListResponse.empty();
}

class RideHistoryListItem {
  From from;
  To to;
  Distance distance;
  Duration duration;
  Currency currency;
  Payment payment;
  String id;
  String uid;
  String cancelReason;
  Driver driver;
  User user;
  Ride ride;
  DateTime date;
  bool schedule;
  double total;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  RideHistoryListItem({
    required this.from,
    required this.to,
    required this.distance,
    required this.duration,
    required this.payment,
    required this.currency,
    this.id = '',
    this.cancelReason = '',
    this.uid = '',
    required this.driver,
    required this.user,
    required this.ride,
    required this.date,
    this.schedule = false,
    this.total = 0,
    this.status = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory RideHistoryListItem.fromJson(Map<String, dynamic> json) =>
      RideHistoryListItem(
        from: From.getAPIResponseObjectSafeValue(json['from']),
        to: To.getAPIResponseObjectSafeValue(json['to']),
        payment: Payment.getAPIResponseObjectSafeValue(json['payment']),
        distance: Distance.getAPIResponseObjectSafeValue(json['distance']),
        duration: Duration.getAPIResponseObjectSafeValue(json['duration']),
        currency: Currency.getAPIResponseObjectSafeValue(json['currency']),
        id: APIHelper.getSafeString(json['_id']),
        cancelReason: APIHelper.getSafeString(json['cancel_reason']),
        uid: APIHelper.getSafeString(json['uid']),
        driver: Driver.getAPIResponseObjectSafeValue(json['driver']),
        user: User.getAPIResponseObjectSafeValue(json['user']),
        ride: Ride.getAPIResponseObjectSafeValue(json['ride']),
        date: DateTime.parse(json['date']),
        schedule: APIHelper.getSafeBool(json['schedule']),
        total: APIHelper.getSafeDouble(json['total']),
        status: APIHelper.getSafeString(json['status']),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'from': from.toJson(),
        'to': to.toJson(),
        'payment': payment.toJson(),
        'distance': distance.toJson(),
        'duration': duration.toJson(),
        'currency': currency.toJson(),
        '_id': id,
        'cancel_reason': cancelReason,
        'uid': uid,
        'driver': driver.toJson(),
        'user': user.toJson(),
        'ride': ride.toJson(),
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'schedule': schedule,
        'total': total,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory RideHistoryListItem.empty() => RideHistoryListItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        currency: Currency(),
        payment: Payment(),
        date: AppComponents.defaultUnsetDateTime,
        distance: Distance(),
        driver: Driver(),
        duration: Duration(),
        from: From.empty(),
        ride: Ride.empty(),
        to: To.empty(),
        updatedAt: AppComponents.defaultUnsetDateTime,
        user: User(),
      );
  static RideHistoryListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryListItem.empty();
}

class Currency {
  String id;
  String name;
  String code;
  String symbol;
  int rate;

  Currency(
      {this.id = '',
      this.name = '',
      this.code = '',
      this.symbol = '',
      this.rate = 0});

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
        code: APIHelper.getSafeString(json['code']),
        symbol: APIHelper.getSafeString(json['symbol']),
        rate: APIHelper.getSafeInt(json['rate']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
        'symbol': symbol,
        'rate': rate,
      };

  static Currency getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Currency.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Currency();
}

class Duration {
  String text;
  int value;

  Duration({this.text = '', this.value = 0});

  factory Duration.fromJson(Map<String, dynamic> json) => Duration(
        text: APIHelper.getSafeString(json['text']),
        value: APIHelper.getSafeInt(json['value']),
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

  static Driver getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Driver.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Driver();
}

class Payment {
  String method;
  String status;
  String transactionId;
  double amount;

  Payment({
    this.method = '',
    this.status = '',
    this.amount = 0,
    this.transactionId = '',
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        method: APIHelper.getSafeString(json['method']),
        status: APIHelper.getSafeString(json['status']),
        transactionId: APIHelper.getSafeString(json['transaction_id']),
        amount: APIHelper.getSafeDouble(json['amount']),
      );

  Map<String, dynamic> toJson() => {
        'method': method,
        'status': status,
        'transaction_id': transactionId,
        'amount': amount,
      };

  static Payment getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Payment.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Payment();
}

class Distance {
  String text;
  int value;

  Distance({this.text = '', this.value = 0});

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        text: APIHelper.getSafeString(json['text']),
        value: APIHelper.getSafeInt(json['value']),
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

class From {
  Location location;
  String address;

  From({required this.location, this.address = ''});

  factory From.fromJson(Map<String, dynamic> json) => From(
        location: Location.getAPIResponseObjectSafeValue(json['location']),
        address: APIHelper.getSafeString(json['address']),
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

class Ride {
  String id;
  Vehicle vehicle;

  Ride({this.id = '', required this.vehicle});

  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
      id: APIHelper.getSafeString(json['_id']),
      vehicle: Vehicle.getAPIResponseObjectSafeValue(json['vehicle']));

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

  static Vehicle getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Vehicle.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Vehicle();
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
      this.image = '',
      this.email = ''});

  factory User.fromJson(Map<String, dynamic> json) => User(
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

  static User getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? User.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : User();
}

class To {
  Location location;
  String address;

  To({required this.location, this.address = ''});

  factory To.fromJson(Map<String, dynamic> json) => To(
        location: Location.getAPIResponseObjectSafeValue(json['location']),
        address: APIHelper.getSafeString(json['address']),
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
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
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
