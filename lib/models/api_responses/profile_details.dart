import 'package:car2godriver/models/api_responses/common/location_position.dart';
import 'package:car2godriver/models/enums/gender.dart';
import 'package:car2godriver/models/enums/profile_status.dart';
import 'package:car2godriver/models/enums/user_current_role.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class ProfileDetails {
  String id;
  String name;
  String email;
  String phone;
  String role;
  String gender;
  bool isVerified;
  String status;
  ProfileDetailsLocation location;
  String city;
  String address;
  DateTime createdAt;
  String image;
  // ProfileDrivingLicense drivingLicense;
  String drivingLicense;
  ProfileIDCard idCard;
  String currentRole;
  ProfileDetailsVehicle vehicle;
  List<ProfileDetailsDynamicField> dynamicFields;

  ProfileDetails({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.role = '',
    this.gender = '',
    this.isVerified = false,
    this.status = '',
    required this.location,
    this.city = '',
    this.address = '',
    required this.createdAt,
    this.image = '',
    required this.drivingLicense,
    required this.idCard,
    this.currentRole = '',
    required this.vehicle,
    this.dynamicFields = const [],
  });

  factory ProfileDetails.empty() => ProfileDetails(
        location: ProfileDetailsLocation.empty(),
        createdAt: AppComponents.defaultUnsetDateTime,
        vehicle: ProfileDetailsVehicle.empty(),
        drivingLicense: '',
        idCard: ProfileIDCard(),
      );

  factory ProfileDetails.fromJson(Map<String, dynamic> json) {
    return ProfileDetails(
      id: APIHelper.getSafeString(json['_id']),
      name: APIHelper.getSafeString(json['name']),
      email: APIHelper.getSafeString(json['email']),
      phone: APIHelper.getSafeString(json['phone']),
      role: APIHelper.getSafeString(json['role']),
      gender: APIHelper.getSafeString(json['gender']),
      isVerified: APIHelper.getSafeBool(json['is_verified']),
      status: APIHelper.getSafeString(json['status']),
      location: ProfileDetailsLocation.getSafeObject(json['location']),
      city: APIHelper.getSafeString(json['city']),
      address: APIHelper.getSafeString(json['address']),
      createdAt: APIHelper.getSafeDateTime(json['createdAt']),
      image: APIHelper.getSafeString(json['image']),
      drivingLicense:
          // ProfileDrivingLicense.getSafeObject(json['driving_license']),
          APIHelper.getSafeString(json['driving_license']),
      idCard: ProfileIDCard.getSafeObject(json['id_card']),
      currentRole: APIHelper.getSafeString(json['current_role']),
      vehicle: ProfileDetailsVehicle.getSafeObject(json['vehicle']),
      dynamicFields: APIHelper.getSafeList(json['dynamic_fields'])
          .map((e) => ProfileDetailsDynamicField.getSafeObject(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
        'gender': gender,
        'is_verified': isVerified,
        'status': status,
        'location': location.toJson(),
        'city': city,
        'address': address,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'image': image,
        // 'driving_license': drivingLicense.toJson(),
        'driving_license': drivingLicense,
        'id_card': idCard.toJson(),
        'current_role': currentRole,
        'vehicle': vehicle.toJson(),
        'dynamic_fields': dynamicFields.map((e) => e.toJson()).toList(),
      };

  static ProfileDetails getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProfileDetails.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ProfileDetails.empty();

  Gender get genderAsEnum => Gender.toEnumValue(gender);

  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => isEmpty == false;

  bool get isDriverInfoEmpty =>
      image.isEmpty || drivingLicense.isEmpty || dynamicFields.isEmpty;
  bool get isDriverInfoNotEmpty => isDriverInfoEmpty == false;

  bool get isVehicleRegistered => vehicle.isAnyVehicleRegistered;
  bool get isVehicleNotRegistered => vehicle.isNoVehicleRegistered;

  bool get isSubscriptionBought => false; // TODO: set the getter method
  bool get isSubscriptionNotBought => isSubscriptionBought == false;

  ProfileStatus get statusAsEnum => ProfileStatus.fromString(status);
  UserRole get roleAsEnum => UserRole.fromString(role);
}

class ProfileDrivingLicense {
  String front;
  String back;

  ProfileDrivingLicense({this.front = '', this.back = ''});

  factory ProfileDrivingLicense.fromJson(Map<String, dynamic> json) =>
      ProfileDrivingLicense(
        front: APIHelper.getSafeString(json['front']),
        back: APIHelper.getSafeString(json['back']),
      );

  Map<String, dynamic> toJson() => {
        'front': front,
        'back': back,
      };

  static ProfileDrivingLicense getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProfileDrivingLicense.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProfileDrivingLicense();

  bool get isEmpty => front.isEmpty && back.isEmpty;
  bool get isNotEmpty => isEmpty == false;
}

class ProfileIDCard {
  String front;
  String back;

  ProfileIDCard({this.front = '', this.back = ''});

  factory ProfileIDCard.fromJson(Map<String, dynamic> json) => ProfileIDCard(
        front: APIHelper.getSafeString(json['front']),
        back: APIHelper.getSafeString(json['back']),
      );

  Map<String, dynamic> toJson() => {
        'front': front,
        'back': back,
      };

  static ProfileIDCard getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProfileIDCard.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ProfileIDCard();

  bool get isEmpty => front.isEmpty && back.isEmpty;
  bool get isNotEmpty => isEmpty == false;
}

class ProfileDetailsLocation {
  LocationPosition position;
  List<double> coordinates;

  ProfileDetailsLocation({required this.position, this.coordinates = const []});

  factory ProfileDetailsLocation.empty() =>
      ProfileDetailsLocation(position: LocationPosition());

  factory ProfileDetailsLocation.fromJson(Map<String, dynamic> json) =>
      ProfileDetailsLocation(
        position: LocationPosition.getSafeObject(json['position']),
        coordinates: APIHelper.getSafeList(json['coordinates'])
            .map((e) => APIHelper.getSafeDouble(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'position': position.toJson(),
        'coordinates': coordinates,
      };

  static ProfileDetailsLocation getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProfileDetailsLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProfileDetailsLocation.empty();
}

class ProfileDetailsDynamicField {
  String key;
  List<String> value;
  String type;

  ProfileDetailsDynamicField({
    this.key = '',
    this.value = const [],
    this.type = '',
  });
  factory ProfileDetailsDynamicField.fromJson(Map<String, dynamic> json) =>
      ProfileDetailsDynamicField(
        key: APIHelper.getSafeString(json['key']),
        value: APIHelper.getSafeList(json['value'])
            .map((e) => APIHelper.getSafeString(e))
            .toList(),
        type: APIHelper.getSafeString(json['type']),
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value.map((e) => e).toList(),
        'type': type,
      };

  static ProfileDetailsDynamicField getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProfileDetailsDynamicField.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProfileDetailsDynamicField();
}

class ProfileDetailsVehicle {
  int total;
  ProfileDetailsVehicleActive active;
  int pending;
  int cancelled;
  int suspended;
  List<ProfileDetailsVehicleWarningMessage> warningMsg;

  ProfileDetailsVehicle({
    this.total = 0,
    required this.active,
    this.pending = 0,
    this.cancelled = 0,
    this.suspended = 0,
    this.warningMsg = const [],
  });
  factory ProfileDetailsVehicle.empty() =>
      ProfileDetailsVehicle(active: ProfileDetailsVehicleActive.empty());

  factory ProfileDetailsVehicle.fromJson(Map<String, dynamic> json) =>
      ProfileDetailsVehicle(
        total: APIHelper.getSafeInt(json['total']),
        active: ProfileDetailsVehicleActive.getSafeObject(json['active']),
        pending: APIHelper.getSafeInt(json['pending']),
        cancelled: APIHelper.getSafeInt(json['cancelled']),
        suspended: APIHelper.getSafeInt(json['suspended']),
        warningMsg: APIHelper.getSafeList(json['warning_msg'])
            .map((e) => ProfileDetailsVehicleWarningMessage.getSafeObject(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'active': active.toJson(),
        'pending': pending,
        'cancelled': cancelled,
        'suspended': suspended,
        'warning_msg': warningMsg.map((e) => e.toJson()).toList(),
      };

  static ProfileDetailsVehicle getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProfileDetailsVehicle.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProfileDetailsVehicle.empty();

  bool get isAnyVehicleRegistered => total > 0;
  bool get isNoVehicleRegistered => isAnyVehicleRegistered == false;
}

class ProfileDetailsVehicleActive {
  String id;
  String brand;
  String model;
  List<String> images;
  bool isOnline;
  bool isActive;
  LocationPosition position;

  ProfileDetailsVehicleActive({
    this.id = '',
    this.brand = '',
    this.model = '',
    this.images = const [],
    this.isOnline = false,
    this.isActive = false,
    required this.position,
  });

  factory ProfileDetailsVehicleActive.empty() =>
      ProfileDetailsVehicleActive(position: LocationPosition());

  factory ProfileDetailsVehicleActive.fromJson(Map<String, dynamic> json) =>
      ProfileDetailsVehicleActive(
        id: APIHelper.getSafeString(json['_id']),
        brand: APIHelper.getSafeString(json['brand']),
        model: APIHelper.getSafeString(json['model']),
        images: APIHelper.getSafeList(json['images'])
            .map((e) => APIHelper.getSafeString(e))
            .toList(),
        isOnline: APIHelper.getSafeBool(json['isOnline']),
        isActive: APIHelper.getSafeBool(json['isActive']),
        position: LocationPosition.getSafeObject(json['position']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'brand': brand,
        'model': model,
        'images': images,
        'isOnline': isOnline,
        'isActive': isActive,
        'position': position.toJson(),
      };

  static ProfileDetailsVehicleActive getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProfileDetailsVehicleActive.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProfileDetailsVehicleActive.empty();

  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => isEmpty == false;
}

class ProfileDetailsVehicleWarningMessage {
  String id;
  String brand;
  String model;
  String carNumberPlate;
  String warningMsg;

  ProfileDetailsVehicleWarningMessage({
    this.id = '',
    this.brand = '',
    this.model = '',
    this.carNumberPlate = '',
    this.warningMsg = '',
  });

  factory ProfileDetailsVehicleWarningMessage.fromJson(
          Map<String, dynamic> json) =>
      ProfileDetailsVehicleWarningMessage(
        id: APIHelper.getSafeString(json['_id']),
        brand: APIHelper.getSafeString(json['brand']),
        model: APIHelper.getSafeString(json['model']),
        carNumberPlate: APIHelper.getSafeString(json['car_number_plate']),
        warningMsg: APIHelper.getSafeString(json['warning_msg']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'brand': brand,
        'model': model,
        'car_number_plate': carNumberPlate,
        'warning_msg': warningMsg,
      };

  static ProfileDetailsVehicleWarningMessage getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProfileDetailsVehicleWarningMessage.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProfileDetailsVehicleWarningMessage();
}
