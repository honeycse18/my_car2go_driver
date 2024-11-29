import 'package:car2godriver/utils/helpers/api_helper.dart';

class PackageListResponse {
  bool error;
  String msg;
  List<PackageResponseList> data;

  PackageListResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory PackageListResponse.fromJson(Map<String, dynamic> json) {
    return PackageListResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: APIHelper.getSafeList(json['data'])
          .map((e) => PackageResponseList.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static PackageListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PackageListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PackageListResponse();
}

class PackageResponseList {
  String id;
  String uid;
  String name;
  double price;
  int duration;
  List<String> descriptions;
  bool popular;
  int v;

  PackageResponseList({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.price = 0,
    this.duration = 0,
    this.popular = false,
    this.v = 0,
    this.descriptions = const [],
  });

  factory PackageResponseList.fromJson(Map<String, dynamic> json) =>
      PackageResponseList(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        price: APIHelper.getSafeDouble(json['price']),
        duration: APIHelper.getSafeInt(json['duration']),
        descriptions: APIHelper.getSafeList(json['descriptions'])
            .map((e) => APIHelper.getSafeString(e))
            .toList(),
        popular: APIHelper.getSafeBool(json['popular']),
        v: APIHelper.getSafeInt(json['__v']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'price': price,
        'duration': duration,
        'descriptions': descriptions,
        'popular': popular,
        '__v': v,
      };

  static PackageResponseList getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PackageResponseList.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PackageResponseList();

  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => isEmpty == false;
}
