import 'package:car2godriver/models/api_responses/trip_permit_list_data.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class TripPermitDetails {
  String id;
  TripPermitVehicleType vehicleType;
  TripPermitCategory category;
  List<String> facilities;
  List<TripPermitPricingModel> pricingModels;
  TripPermitWallet wallet;

  TripPermitDetails({
    this.id = '',
    required this.vehicleType,
    required this.category,
    this.facilities = const [],
    required this.wallet,
    this.pricingModels = const [],
  });
  factory TripPermitDetails.empty() => TripPermitDetails(
        vehicleType: TripPermitVehicleType(),
        category: TripPermitCategory(),
        wallet: TripPermitWallet(),
      );

  factory TripPermitDetails.fromJson(Map<String, dynamic> json) {
    return TripPermitDetails(
      id: APIHelper.getSafeString(json['_id']),
      vehicleType: TripPermitVehicleType.getSafeObject(json['vehicle_type']),
      category: TripPermitCategory.getSafeObject(json['category']),
      wallet: TripPermitWallet.getSafeObject(json['wallet']),
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
        'wallet': wallet.toJson(),
        'facilities': facilities,
        'pricing_models': pricingModels.map((e) => e.toJson()).toList(),
      };

  static TripPermitDetails getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? TripPermitDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : TripPermitDetails.empty();
}

class TripPermitWallet {
  double currentBalance;
  String msg;

  TripPermitWallet({
    this.currentBalance = 0,
    this.msg = '',
  });

  factory TripPermitWallet.fromJson(Map<String, dynamic> json) =>
      TripPermitWallet(
        currentBalance: APIHelper.getSafeDouble(json['current_balance'], 0),
        msg: APIHelper.getSafeString(json['msg']),
      );

  Map<String, dynamic> toJson() => {
        'current_balance': currentBalance,
        'msg': msg,
      };

  static TripPermitWallet getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? TripPermitWallet.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : TripPermitWallet();
}
