import 'package:car2godriver/utils/helpers/api_helper.dart';

class CarCategoriesResponse {
  bool error;
  String msg;
  CarCategoriesData data;

  CarCategoriesResponse(
      {this.error = false, this.msg = '', required this.data});

  factory CarCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CarCategoriesResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: CarCategoriesData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory CarCategoriesResponse.empty() => CarCategoriesResponse(
        data: CarCategoriesData(),
      );
  static CarCategoriesResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CarCategoriesResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CarCategoriesResponse.empty();
}

class CarCategoriesData {
  List<CarCategoriesCategory> categories;

  CarCategoriesData({this.categories = const []});

  factory CarCategoriesData.fromJson(Map<String, dynamic> json) =>
      CarCategoriesData(
        categories: APIHelper.getSafeList(json['categories'])
            .map((e) => CarCategoriesCategory.getAPIResponseObjectSafeValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'categories': categories.map((e) => e.toJson()).toList(),
      };

  static CarCategoriesData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CarCategoriesData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CarCategoriesData();
}

class CarCategoriesCategory {
  String id;
  String uid;
  String name;

  CarCategoriesCategory({this.id = '', this.uid = '', this.name = ''});

  factory CarCategoriesCategory.fromJson(Map<String, dynamic> json) =>
      CarCategoriesCategory(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
      };

  static CarCategoriesCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CarCategoriesCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CarCategoriesCategory();
}
