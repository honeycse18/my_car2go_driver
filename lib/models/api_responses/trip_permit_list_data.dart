// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class TripPermitListDetails {
  String id;
  TripPermitVehicleType vehicleType;
  TripPermitCategory category;
  List<String> facilities;
  List<TripPermitPricingModel> pricingModels;
  TripPermitSubscriptionOrder subscriptionOrder;

  TripPermitListDetails({
    this.id = '',
    required this.vehicleType,
    required this.category,
    this.facilities = const [],
    required this.subscriptionOrder,
    this.pricingModels = const [],
  });
  factory TripPermitListDetails.empty() => TripPermitListDetails(
        vehicleType: TripPermitVehicleType(),
        category: TripPermitCategory(),
        subscriptionOrder: TripPermitSubscriptionOrder(),
      );

  factory TripPermitListDetails.fromJson(Map<String, dynamic> json) {
    return TripPermitListDetails(
      id: APIHelper.getSafeString(json['_id']),
      vehicleType: TripPermitVehicleType.getSafeObject(json['vehicle_type']),
      category: TripPermitCategory.getSafeObject(json['category']),
      subscriptionOrder:
          TripPermitSubscriptionOrder.getSafeObject(json['subscription_order']),
      facilities: APIHelper.getSafeList(json['facilities'])
          .map((e) => APIHelper.getSafeString(e))
          .toList(),
      pricingModels: APIHelper.getSafeList(json['pricing_models'])
          .map((e) => TripPermitPricingModel.getSafeObject(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'vehicle_type': vehicleType.toJson(),
        'category': category.toJson(),
        'subscription_order': subscriptionOrder.toJson(),
        'facilities': facilities,
        'pricing_models': pricingModels.map((e) => e.toJson()).toList(),
      };

  static TripPermitListDetails getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? TripPermitListDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : TripPermitListDetails.empty();
}

class TripPermitVehicleType {
  String id;
  String name;

  TripPermitVehicleType({this.id = '', this.name = ''});

  factory TripPermitVehicleType.fromJson(Map<String, dynamic> json) =>
      TripPermitVehicleType(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static TripPermitVehicleType getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? TripPermitVehicleType.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : TripPermitVehicleType();
}

class TripPermitCategory {
  String id;
  String name;

  TripPermitCategory({this.id = '', this.name = ''});

  factory TripPermitCategory.fromJson(Map<String, dynamic> json) =>
      TripPermitCategory(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static TripPermitCategory getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? TripPermitCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : TripPermitCategory();
}

class TripPermitSubscriptionOrder {
  String pricingModel;
  bool hasExpired;
  int remainingDays;

  TripPermitSubscriptionOrder(
      {this.pricingModel = '',
      this.hasExpired = false,
      this.remainingDays = 0});

  factory TripPermitSubscriptionOrder.fromJson(Map<String, dynamic> json) =>
      TripPermitSubscriptionOrder(
        pricingModel: APIHelper.getSafeString(json['pricing_model']),
        hasExpired: APIHelper.getSafeBool(json['has_expired']),
        remainingDays: APIHelper.getSafeInt(json['remaining_days']),
      );

  Map<String, dynamic> toJson() => {
        'pricing_model': pricingModel,
        'has_expired': hasExpired,
        'remaining_days': remainingDays,
      };

  static TripPermitSubscriptionOrder getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? TripPermitSubscriptionOrder.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : TripPermitSubscriptionOrder();
}

class TripPermitPricingModel {
  double price;
  int durationInDay;
  String id;
  bool isSubscribed;

  TripPermitPricingModel(
      {this.price = 0,
      this.durationInDay = 0,
      this.id = '',
      this.isSubscribed = false});

  factory TripPermitPricingModel.fromJson(Map<String, dynamic> json) =>
      TripPermitPricingModel(
        price: APIHelper.getSafeDouble(json['price']),
        durationInDay: APIHelper.getSafeInt(json['duration_in_day']),
        id: APIHelper.getSafeString(json['_id']),
        isSubscribed: APIHelper.getSafeBool(json['subscribed']),
      );

  Map<String, dynamic> toJson() => {
        'price': price,
        'duration_in_day': durationInDay,
        '_id': id,
        'subscribed': id,
      };

  static TripPermitPricingModel getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? TripPermitPricingModel.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : TripPermitPricingModel();

  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => isEmpty == false;

  TripPermitPricingModel copyWith({
    double? price,
    int? durationInDay,
    String? id,
    bool? isSubscribed,
  }) {
    return TripPermitPricingModel(
      price: price ?? this.price,
      durationInDay: durationInDay ?? this.durationInDay,
      id: id ?? this.id,
      isSubscribed: isSubscribed ?? this.isSubscribed,
    );
  }
}
