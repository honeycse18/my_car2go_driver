import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class WalletWithdrawResponse {
  String driver;
  double amount;
  String withdrawMethod;
  String bankName;
  List<WalletWithdrawalDetail> withdrawalDetails;
  String by;
  String status;
  String type;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  WalletWithdrawResponse({
    this.driver = '',
    this.amount = 0,
    this.withdrawMethod = '',
    this.bankName = '',
    this.withdrawalDetails = const [],
    this.by = '',
    this.status = '',
    this.type = '',
    this.id = '',
    required this.createdAt,
    required this.updatedAt,
  });
  factory WalletWithdrawResponse.empty() => WalletWithdrawResponse(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  factory WalletWithdrawResponse.fromJson(Map<String, dynamic> json) {
    return WalletWithdrawResponse(
      driver: APIHelper.getSafeString(json['driver']),
      amount: APIHelper.getSafeDouble(json['amount'], 0),
      withdrawMethod: APIHelper.getSafeString(json['withdraw_method']),
      bankName: APIHelper.getSafeString(json['bank_name']),
      withdrawalDetails: APIHelper.getSafeList(json['withdrawal_details'])
          .map((e) => WalletWithdrawalDetail.getSafeObject(e))
          .toList(),
      by: APIHelper.getSafeString(json['by']),
      status: APIHelper.getSafeString(json['status']),
      type: APIHelper.getSafeString(json['type']),
      id: APIHelper.getSafeString(json['_id']),
      createdAt: APIHelper.getSafeDateTime(json['createdAt']),
      updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'driver': driver,
        'amount': amount,
        'withdraw_method': withdrawMethod,
        'bank_name': bankName,
        'withdrawal_details': withdrawalDetails.map((e) => e.toJson()).toList(),
        'by': by,
        'status': status,
        'type': type,
        '_id': id,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  static WalletWithdrawResponse getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletWithdrawResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WalletWithdrawResponse.empty();
}

class WalletWithdrawalDetail {
  String key;
  String value;
  String type;
  String id;

  WalletWithdrawalDetail(
      {this.key = '', this.value = '', this.type = '', this.id = ''});

  factory WalletWithdrawalDetail.fromJson(Map<String, dynamic> json) {
    return WalletWithdrawalDetail(
      key: APIHelper.getSafeString(json['key']),
      value: APIHelper.getSafeString(json['value']),
      type: APIHelper.getSafeString(json['type']),
      id: APIHelper.getSafeString(json['_id']),
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
        'type': type,
        '_id': id,
      };

  static WalletWithdrawalDetail getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletWithdrawalDetail.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WalletWithdrawalDetail();
}
