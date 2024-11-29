import 'package:car2godriver/models/enums/gender.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class UserDetailsResponse {
  bool error;
  String msg;
  UserDetailsData data;

  UserDetailsResponse({this.error = false, this.msg = '', required this.data});

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) {
    return UserDetailsResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: UserDetailsData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory UserDetailsResponse.empty() => UserDetailsResponse(
        data: UserDetailsData.empty(),
      );
  static UserDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsResponse.empty();
}

class UserDetailsData {
  String id;
  String service;
  String uid;
  String name;
  String phone;
  String email;
  String image;
  String role;
  String address;
  double rate;
  bool fleet;
  String address2;
  String experience;
  String about;
  String gender;
  UserDetailsLoc location;
  UserDetailsRide ride;
  UserRentDetails rent;
  Driver driver;
  UserDetailsCountry country;
  UserDocumentsDetails documents;
  String licenseNo;
  double rating;
  List<String> paymentMethods;
  Currency currency;
  DriverVehicle vehicle;
  List<Subscription> subscription;

  UserDetailsData(
      {this.id = '',
      this.uid = '',
      this.service = '',
      this.name = '',
      this.phone = '',
      this.email = '',
      this.image = '',
      this.role = '',
      this.address = '',
      this.gender = '',
      this.rate = 0,
      this.fleet = false,
      this.address2 = '',
      this.experience = '',
      this.about = '',
      required this.location,
      this.subscription = const [],
      required this.rent,
      required this.driver,
      required this.country,
      required this.currency,
      required this.vehicle,
      required this.documents,
      this.licenseNo = '',
      this.rating = 0.0,
      this.paymentMethods = const [],
      required this.ride});

  factory UserDetailsData.fromJson(Map<String, dynamic> json) =>
      UserDetailsData(
        id: APIHelper.getSafeString(json['_id']),
        service: APIHelper.getSafeString(json['service']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        phone: APIHelper.getSafeString(json['phone']),
        email: APIHelper.getSafeString(json['email']),
        image: APIHelper.getSafeString(json['image']),
        role: APIHelper.getSafeString(json['role']),
        address: APIHelper.getSafeString(json['address']),
        address2: APIHelper.getSafeString(json['address2']),
        experience: APIHelper.getSafeString(json['experience']),
        gender: APIHelper.getSafeString(json['gender']),
        about: APIHelper.getSafeString(json['about']),
        rate: APIHelper.getSafeDouble(json['rate']),
        fleet: APIHelper.getSafeBool(json['fleet']),
        subscription: APIHelper.getSafeList(json['subscriptions'])
            .map((e) => Subscription.getAPIResponseObjectSafeValue(e))
            .toList(),
        location:
            UserDetailsLoc.getAPIResponseObjectSafeValue(json['location']),
        ride: UserDetailsRide.getAPIResponseObjectSafeValue(json['ride']),
        rent: UserRentDetails.getAPIResponseObjectSafeValue(json['rent']),
        driver: Driver.getAPIResponseObjectSafeValue(json['driver']),
        country:
            UserDetailsCountry.getAPIResponseObjectSafeValue(json['country']),
        documents: UserDocumentsDetails.getAPIResponseObjectSafeValue(
            json['documents']),
        licenseNo: APIHelper.getSafeString(json['license_no']),
        rating: APIHelper.getSafeDouble(json['rating'], 0.0),
        paymentMethods: APIHelper.getSafeList(json['payment_methods'])
            .map((e) => APIHelper.getSafeString(e))
            .toList(),
        currency: Currency.getAPIResponseObjectSafeValue(json['currency']),
        vehicle: DriverVehicle.getAPIResponseObjectSafeValue(json['vehicle']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'service': service,
        'name': name,
        'phone': phone,
        'vehicle': vehicle.toJson(),
        'email': email,
        'gender': gender,
        'image': image,
        'role': role,
        'address': address,
        'experience': experience,
        'address2': address2,
        'about': about,
        'rate': rate,
        'fleet': fleet,
        'location': location.toJson(),
        'ride': ride.toJson(),
        'rent': rent.toJson(),
        'driver': driver.toJson(),
        'currency': currency.toJson(),
        'documents': documents.toJson(),
        'license_no': licenseNo,
        'rating': rating,
        'payment_methods': paymentMethods,
        'country': country.toJson(),
        'subscription': subscription,
      };

  factory UserDetailsData.empty() => UserDetailsData(
      vehicle: DriverVehicle.empty(),
      location: UserDetailsLoc(),
      documents: UserDocumentsDetails(),
      ride: UserDetailsRide.empty(),
      rent: UserRentDetails.empty(),
      driver: Driver.empty(),
      country: UserDetailsCountry(),
      currency: Currency());
  static UserDetailsData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsData.empty();
  Gender get genderAsEnum => Gender.toEnumValue(gender);

  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => isEmpty == false;

  bool get isVehicleRegistered => vehicle.isNotEmpty;
  bool get isVehicleNotRegistered => isVehicleRegistered == false;

  bool get isSubscriptionBought => subscription.isNotEmpty;
  bool get isSubscriptionNotBought => isSubscriptionBought == false;
}

class Subscription {
  String id;
  Package package;
  DateTime start;
  DateTime end;
  SubscriptionPayment payment;

  Subscription(
      {this.id = '',
      required this.package,
      required this.start,
      required this.end,
      required this.payment});

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: APIHelper.getSafeString(json['_id']),
        package: Package.getAPIResponseObjectSafeValue(json['package']),
        start: APIHelper.getSafeDateTime(json['start']),
        end: APIHelper.getSafeDateTime(json['end']),
        payment:
            SubscriptionPayment.getAPIResponseObjectSafeValue(json['payment']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'package': package.toJson(),
        'start': start.toIso8601String(),
        'end': end.toIso8601String(),
        'payment': payment.toJson(),
      };

  factory Subscription.empty() => Subscription(
        start: AppComponents.defaultUnsetDateTime,
        end: AppComponents.defaultUnsetDateTime,
        package: Package(),
        payment: SubscriptionPayment(),
      );
  static Subscription getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Subscription.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Subscription.empty();
}

class SubscriptionPayment {
  String method;
  String status;

  SubscriptionPayment({this.method = '', this.status = ''});

  factory SubscriptionPayment.fromJson(Map<String, dynamic> json) =>
      SubscriptionPayment(
        method: APIHelper.getSafeString(json['method']),
        status: APIHelper.getSafeString(json['status']),
      );

  Map<String, dynamic> toJson() => {
        'method': method,
        'status': status,
      };

  static SubscriptionPayment getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SubscriptionPayment.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SubscriptionPayment();
}

class Package {
  String id;
  String name;
  double price;
  int duration;

  Package({this.name = '', this.id = '', this.price = 0, this.duration = 0});

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        name: APIHelper.getSafeString(json['name']),
        id: APIHelper.getSafeString(json['_id']),
        price: APIHelper.getSafeDouble(json['price']),
        duration: APIHelper.getSafeInt(json['duration']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'price': price,
        'duration': duration,
      };

  static Package getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Package.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Package();
}

class Currency {
  String id;
  String name;
  String code;
  String symbol;

  Currency({
    this.name = '',
    this.id = '',
    this.code = '',
    this.symbol = '',
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
        code: APIHelper.getSafeString(json['code']),
        symbol: APIHelper.getSafeString(json['symbol']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
        'symbol': symbol,
      };

  static Currency getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Currency.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Currency();
}

class Driver {
  bool fleet;
  String id;
  Owner owner;
  String status;

  Driver(
      {this.fleet = false,
      this.id = '',
      required this.owner,
      this.status = ''});

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        fleet: APIHelper.getSafeBool(json['fleet']),
        id: APIHelper.getSafeString(json['_id']),
        owner: Owner.getAPIResponseObjectSafeValue(json['owner']),
        status: APIHelper.getSafeString(json['status']),
      );

  Map<String, dynamic> toJson() => {
        'fleet': fleet,
        '_id': id,
        'owner': owner.toJson(),
        'status': status,
      };

  factory Driver.empty() => Driver(
        owner: Owner(),
      );
  static Driver getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Driver.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Driver.empty();
}

class Owner {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  Owner(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.email = '',
      this.image = ''});

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
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

  static Owner getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Owner.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Owner();
}

class UserRentDetails {
  String id;
  Vehicle vehicle;
  Prices prices;
  String address;
  UserRentDetailsLocation location;
  Facilities facilities;

  UserRentDetails({
    this.id = '',
    required this.vehicle,
    required this.prices,
    this.address = '',
    required this.location,
    required this.facilities,
  });

  factory UserRentDetails.fromJson(Map<String, dynamic> json) =>
      UserRentDetails(
        id: APIHelper.getSafeString(json['_id']),
        vehicle: Vehicle.getAPIResponseObjectSafeValue(json['vehicle']),
        prices: Prices.getAPIResponseObjectSafeValue(json['prices']),
        address: APIHelper.getSafeString(json['address']),
        location: UserRentDetailsLocation.getAPIResponseObjectSafeValue(
            json['location']),
        facilities:
            Facilities.getAPIResponseObjectSafeValue(json['facilities']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'vehicle': vehicle.toJson(),
        'prices': prices.toJson(),
        'address': address,
        'location': location.toJson(),
        'facilities': facilities.toJson(),
      };

  factory UserRentDetails.empty() => UserRentDetails(
        facilities: Facilities(),
        location: UserRentDetailsLocation(),
        prices: Prices.empty(),
        vehicle: Vehicle(),
      );
  static UserRentDetails getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserRentDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserRentDetails.empty();
}

class UserDetailsCountry {
  String id;
  String name;
  String code;

  UserDetailsCountry({this.id = '', this.name = '', this.code = ''});

  factory UserDetailsCountry.fromJson(Map<String, dynamic> json) =>
      UserDetailsCountry(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
        code: APIHelper.getSafeString(json['code']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
      };

  static UserDetailsCountry getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsCountry.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsCountry();
}

class Vehicle {
  String id;
  String uid;
  String name;
  List<String> images;

  Vehicle(
      {this.id = '', this.uid = '', this.name = '', this.images = const []});

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        images: APIHelper.getSafeList(json['images'])
            .map((e) => APIHelper.getSafeString(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'images': images,
      };

  static Vehicle getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Vehicle.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Vehicle();
}

class UserRentDetailsLocation {
  double lat;
  double lng;

  UserRentDetailsLocation({this.lat = 0, this.lng = 0});

  factory UserRentDetailsLocation.fromJson(Map<String, dynamic> json) =>
      UserRentDetailsLocation(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static UserRentDetailsLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserRentDetailsLocation.fromJson(unsafeResponseValue)
          : UserRentDetailsLocation();
}

class Prices {
  Hourly hourly;
  Weekly weekly;
  Monthly monthly;

  Prices({required this.hourly, required this.weekly, required this.monthly});

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        hourly: Hourly.getAPIResponseObjectSafeValue(json['hourly']),
        weekly: Weekly.getAPIResponseObjectSafeValue(json['weekly']),
        monthly: Monthly.getAPIResponseObjectSafeValue(json['monthly']),
      );

  Map<String, dynamic> toJson() => {
        'daily': hourly.toJson(),
        'weekly': weekly.toJson(),
        'monthly': monthly.toJson(),
      };

  factory Prices.empty() => Prices(
        hourly: Hourly(),
        monthly: Monthly(),
        weekly: Weekly(),
      );
  static Prices getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Prices.fromJson(unsafeResponseValue)
          : Prices.empty();
}

class Hourly {
  bool active;
  double price;

  Hourly({this.active = false, this.price = 0});

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        active: APIHelper.getSafeBool(json['active']),
        price: APIHelper.getSafeDouble(json['price']),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'price': price,
      };

  static Hourly getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Hourly.fromJson(unsafeResponseValue)
          : Hourly();
}

class Weekly {
  bool active;
  double price;

  Weekly({this.active = false, this.price = 0});

  factory Weekly.fromJson(Map<String, dynamic> json) => Weekly(
        active: APIHelper.getSafeBool(json['active']),
        price: APIHelper.getSafeDouble(json['price']),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'price': price,
      };

  static Weekly getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Weekly.fromJson(unsafeResponseValue)
          : Weekly();
}

class Monthly {
  bool active;
  double price;

  Monthly({this.active = false, this.price = 0});

  factory Monthly.fromJson(Map<String, dynamic> json) => Monthly(
        active: APIHelper.getSafeBool(json['active']),
        price: APIHelper.getSafeDouble(json['price']),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'price': price,
      };

  static Monthly getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Monthly.fromJson(unsafeResponseValue)
          : Monthly();
}

class Facilities {
  bool smoking;
  int luggage;

  Facilities({this.smoking = false, this.luggage = 0});

  factory Facilities.fromJson(Map<String, dynamic> json) => Facilities(
        smoking: APIHelper.getSafeBool(json['smoking']),
        luggage: APIHelper.getSafeInt(json['luggage']),
      );

  Map<String, dynamic> toJson() => {
        'smoking': smoking,
        'luggage': luggage,
      };

  static Facilities getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Facilities.fromJson(unsafeResponseValue)
          : Facilities();
}

class UserDetailsLoc {
  double lat;
  double lng;

  UserDetailsLoc({
    this.lat = 0,
    this.lng = 0,
  });

  factory UserDetailsLoc.fromJson(Map<String, dynamic> json) => UserDetailsLoc(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static UserDetailsLoc getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsLoc.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsLoc();
}

class UserDetailsRide {
  String id;
  UserDetailsRideDetailsVehicle vehicle;
  UserDetailsRideDetailsLocation location;
  bool online;

  UserDetailsRide(
      {this.id = '',
      required this.vehicle,
      required this.location,
      this.online = false});

  factory UserDetailsRide.fromJson(Map<String, dynamic> json) =>
      UserDetailsRide(
        id: APIHelper.getSafeString(json['_id']),
        vehicle: UserDetailsRideDetailsVehicle.getAPIResponseObjectSafeValue(
            json['vehicle']),
        location: UserDetailsRideDetailsLocation.getAPIResponseObjectSafeValue(
            json['location']),
        online: APIHelper.getSafeBool(json['online']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'vehicle': vehicle.toJson(),
        'location': location.toJson(),
        'online': online,
      };

  factory UserDetailsRide.empty() => UserDetailsRide(
      vehicle: UserDetailsRideDetailsVehicle(),
      location: UserDetailsRideDetailsLocation());
  static UserDetailsRide getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsRide.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsRide.empty();

  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => isEmpty == false;
}

class UserDetailsRideDetailsLocation {
  double lat;
  double lng;

  UserDetailsRideDetailsLocation({this.lat = 0, this.lng = 0});

  factory UserDetailsRideDetailsLocation.fromJson(Map<String, dynamic> json) =>
      UserDetailsRideDetailsLocation(
          lat: APIHelper.getSafeDouble(json['lat']),
          lng: APIHelper.getSafeDouble(json['lng']));

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static UserDetailsRideDetailsLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsRideDetailsLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsRideDetailsLocation();
}

class UserDetailsRideDetailsVehicle {
  String id;
  String uid;
  String name;
  List<String> images;

  UserDetailsRideDetailsVehicle(
      {this.id = '', this.uid = '', this.name = '', this.images = const []});

  factory UserDetailsRideDetailsVehicle.fromJson(Map<String, dynamic> json) =>
      UserDetailsRideDetailsVehicle(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        images: APIHelper.getSafeList(json['images'])
            .map((e) => APIHelper.getSafeString(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'images': images,
      };

  static UserDetailsRideDetailsVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsRideDetailsVehicle.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsRideDetailsVehicle();
}

class DriverVehicle {
  UserVehicleLocation location;
  String id;
  String uid;
  String driver;
  String name;
  VehicleCategory category;
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
  bool online;
  DateTime createdAt;
  DateTime updatedAt;

  DriverVehicle({
    required this.location,
    this.id = '',
    this.uid = '',
    this.driver = '',
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
    this.ac = false,
    this.documents = const [],
    this.status = '',
    this.online = false,
    required this.createdAt,
    required this.updatedAt,
    this.vehicleNumber = '',
  });

  factory DriverVehicle.fromJson(Map<String, dynamic> json) => DriverVehicle(
        location:
            UserVehicleLocation.getAPIResponseObjectSafeValue(json['location']),
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        driver: APIHelper.getSafeString(json['driver']),
        name: APIHelper.getSafeString(json['name']),
        category:
            VehicleCategory.getAPIResponseObjectSafeValue(json['category']),
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
        online: APIHelper.getSafeBool(json['online']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        '_id': id,
        'uid': uid,
        'driver': driver,
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
        'online': online,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory DriverVehicle.empty() => DriverVehicle(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        location: UserVehicleLocation(),
        category: VehicleCategory(),
      );
  static DriverVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DriverVehicle.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : DriverVehicle.empty();

  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => isEmpty == false;
}

class UserVehicleLocation {
  String type;
  List<double> coordinates;

  UserVehicleLocation({this.type = '', this.coordinates = const []});

  factory UserVehicleLocation.fromJson(Map<String, dynamic> json) =>
      UserVehicleLocation(
        type: APIHelper.getSafeString(json['type']),
        coordinates: APIHelper.getSafeList(json['coordinates'])
            .map((e) => APIHelper.getSafeDouble(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
      };

  static UserVehicleLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserVehicleLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserVehicleLocation();
}

class VehicleCategory {
  String id;
  String name;
  String image;

  VehicleCategory({this.id = '', this.name = '', this.image = ''});

  factory VehicleCategory.fromJson(Map<String, dynamic> json) =>
      VehicleCategory(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
        image: APIHelper.getSafeString(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'image': image,
      };

  static VehicleCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? VehicleCategory.fromJson(unsafeResponseValue)
          : VehicleCategory();
}

class UserDocumentsDetails {
  String front;
  String back;

  UserDocumentsDetails({this.front = '', this.back = ''});

  factory UserDocumentsDetails.fromJson(Map<String, dynamic> json) =>
      UserDocumentsDetails(
        front: APIHelper.getSafeString(json['front']),
        back: APIHelper.getSafeString(json['back']),
      );

  Map<String, dynamic> toJson() => {
        'front': front,
        'back': back,
      };

  static UserDocumentsDetails getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDocumentsDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDocumentsDetails();

  bool get isEmpty => front.isEmpty && back.isEmpty;
  bool get isNotEmpty => isEmpty == false;
}
