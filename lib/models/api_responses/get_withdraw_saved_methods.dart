import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class GetWithdrawSavedMethodsResponse {
  bool error;
  String msg;
  List<WithdrawMethodsItem> data;

  GetWithdrawSavedMethodsResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory GetWithdrawSavedMethodsResponse.fromJson(Map<String, dynamic> json) {
    return GetWithdrawSavedMethodsResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: APIHelper.getSafeList(json['data'])
          .map((e) => WithdrawMethodsItem.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static GetWithdrawSavedMethodsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? GetWithdrawSavedMethodsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : GetWithdrawSavedMethodsResponse();
}

class WithdrawMethodsItem {
  String id;
  String user;
  String type;
  Details details;
  DateTime createdAt;
  DateTime updatedAt;

  WithdrawMethodsItem({
    this.id = '',
    this.user = '',
    this.type = '',
    required this.details,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WithdrawMethodsItem.fromJson(Map<String, dynamic> json) =>
      WithdrawMethodsItem(
        id: APIHelper.getSafeString(json['_id']),
        user: APIHelper.getSafeString(json['user']),
        type: APIHelper.getSafeString(json['type']),
        details: Details.getAPIResponseObjectSafeValue(json['details']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user,
        'type': type,
        'details': details.toJson(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory WithdrawMethodsItem.empty() => WithdrawMethodsItem(
      createdAt: AppComponents.defaultUnsetDateTime,
      details: Details(),
      updatedAt: AppComponents.defaultUnsetDateTime);
  static WithdrawMethodsItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WithdrawMethodsItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WithdrawMethodsItem.empty();
}

class Details {
  String accountName;
  String accountEmail;
  String cardName;
  String cardNumber;
  String cardExpiry;
  String cardCvvNumber;
  String postalCode;
  String bankAccountName;
  String bankName;
  String branchCode;
  String accountNumber;

  Details({
    this.accountName = '',
    this.accountEmail = '',
    this.cardName = '',
    this.cardNumber = '',
    this.cardExpiry = '',
    this.cardCvvNumber = '',
    this.postalCode = '',
    this.bankAccountName = '',
    this.bankName = '',
    this.branchCode = '',
    this.accountNumber = '',
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        accountName: APIHelper.getSafeString(json['account_name']),
        accountEmail: APIHelper.getSafeString(json['account_email']),
        cardName: APIHelper.getSafeString(json['card_name']),
        cardNumber: APIHelper.getSafeString(json['card_number']),
        cardExpiry: APIHelper.getSafeString(json['card_expire_date']),
        cardCvvNumber: APIHelper.getSafeString(json['cvv_number']),
        postalCode: APIHelper.getSafeString(json['postal_code']),
        bankAccountName: APIHelper.getSafeString(json['bank_account_name']),
        bankName: APIHelper.getSafeString(json['bank_name']),
        branchCode: APIHelper.getSafeString(json['branch_code']),
        accountNumber: APIHelper.getSafeString(json['account_number']),
      );

  Map<String, dynamic> toJson() => {
        'account_name': accountName,
        'account_email': accountEmail,
        'card_name': cardName,
        'card_number': cardNumber,
        'card_expire_date': cardExpiry,
        'cvv_number': cardCvvNumber,
        'postal_code': postalCode,
        'bank_account_name': bankAccountName,
        'bank_name': bankName,
        'branch_code': branchCode,
        'account_number': accountNumber,
      };

  static Details getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Details.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Details();
}
