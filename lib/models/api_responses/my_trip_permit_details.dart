import 'package:car2godriver/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:car2godriver/models/api_responses/trip_permit_list_data.dart';
import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class MyTripPermitDetails {
  MyTripPermitSubscribedDetails subscribed;
  PaginatedDataResponse<MyTripPermitTransaction> transactions;

  MyTripPermitDetails({required this.subscribed, required this.transactions});
  factory MyTripPermitDetails.empty() => MyTripPermitDetails(
      subscribed: MyTripPermitSubscribedDetails.empty(),
      transactions: PaginatedDataResponse<MyTripPermitTransaction>.empty());

  factory MyTripPermitDetails.fromJson(Map<String, dynamic> json) {
    return MyTripPermitDetails(
      subscribed:
          MyTripPermitSubscribedDetails.getSafeObject(json['subscribed']),
      transactions: PaginatedDataResponse.getSafeObject(
        json['transactions'],
        docFromJson: MyTripPermitTransaction.getSafeObject,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'subscribed': subscribed.toJson(),
        'transactions': transactions.toJson((item) => item.toJson()),
      };

  static MyTripPermitDetails getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyTripPermitDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyTripPermitDetails.empty();

  formatted(String s) {}
}

class MyTripPermitSubscribedDetails {
  String id;
  String uid;
  bool autoRenewal;
  TripPermitCategory category;
  DateTime expireDate;
  MyTripPermitPayment payment;
  DateTime startDate;
  TripPermitVehicleType vehicleType;
  TripPermitPricingModel pricingModels;
  bool hasExpired;
  int remainingDays;

  MyTripPermitSubscribedDetails({
    this.id = '',
    this.uid = '',
    this.autoRenewal = false,
    required this.category,
    required this.expireDate,
    required this.payment,
    required this.startDate,
    required this.vehicleType,
    required this.pricingModels,
    this.hasExpired = false,
    this.remainingDays = 0,
  });
  factory MyTripPermitSubscribedDetails.empty() =>
      MyTripPermitSubscribedDetails(
          category: TripPermitCategory(),
          expireDate: AppConstants.defaultUnsetDateTime,
          payment: MyTripPermitPayment(),
          startDate: AppConstants.defaultUnsetDateTime,
          vehicleType: TripPermitVehicleType(),
          pricingModels: TripPermitPricingModel());

  factory MyTripPermitSubscribedDetails.fromJson(Map<String, dynamic> json) =>
      MyTripPermitSubscribedDetails(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        autoRenewal: APIHelper.getSafeBool(json['auto_renewal']),
        category: TripPermitCategory.getSafeObject(json['category']),
        expireDate: APIHelper.getSafeDateTime(json['expire_date']),
        payment: MyTripPermitPayment.getSafeObject(json['payment']),
        startDate: APIHelper.getSafeDateTime(json['start_date']),
        vehicleType: TripPermitVehicleType.getSafeObject(json['vehicle_type']),
        pricingModels:
            TripPermitPricingModel.getSafeObject(json['pricing_models']),
        hasExpired: APIHelper.getSafeBool(json['has_expired']),
        remainingDays: APIHelper.getSafeInt(json['remaining_days'], 0),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'auto_renewal': autoRenewal,
        'category': category.toJson(),
        'expire_date': expireDate.toIso8601String(),
        'payment': payment.toJson(),
        'start_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
        'vehicle_type': vehicleType.toJson(),
        'pricing_models': pricingModels.toJson(),
        'has_expired': hasExpired,
        'remaining_days': remainingDays,
      };

  static MyTripPermitSubscribedDetails getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyTripPermitSubscribedDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyTripPermitSubscribedDetails.empty();
}

class MyTripPermitPayment {
  String status;
  String type;

  MyTripPermitPayment({this.status = '', this.type = ''});

  factory MyTripPermitPayment.fromJson(Map<String, dynamic> json) =>
      MyTripPermitPayment(
        status: APIHelper.getSafeString(json['status']),
        type: APIHelper.getSafeString(json['type']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'type': type,
      };

  static MyTripPermitPayment getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyTripPermitPayment.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyTripPermitPayment();
}

class MyTripPermitTransaction {
  String id;
  double amount;
  String status;
  MyTripPermitSubscribedDetails subscriptionOrder;
  DateTime createdAt;

  MyTripPermitTransaction({
    this.id = '',
    this.amount = 0,
    this.status = '',
    required this.subscriptionOrder,
    required this.createdAt,
  });
  factory MyTripPermitTransaction.empty() => MyTripPermitTransaction(
      subscriptionOrder: MyTripPermitSubscribedDetails.empty(),
      createdAt: AppConstants.defaultUnsetDateTime);

  factory MyTripPermitTransaction.fromJson(Map<String, dynamic> json) =>
      MyTripPermitTransaction(
        id: APIHelper.getSafeString(json['_id']),
        amount: APIHelper.getSafeDouble(json['amount'], 0),
        status: APIHelper.getSafeString(json['status']),
        subscriptionOrder: MyTripPermitSubscribedDetails.getSafeObject(
            json['subscription_order']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'amount': amount,
        'status': status,
        'subscription_order': subscriptionOrder.toJson(),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
      };

  static MyTripPermitTransaction getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyTripPermitTransaction.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyTripPermitTransaction.empty();
}
