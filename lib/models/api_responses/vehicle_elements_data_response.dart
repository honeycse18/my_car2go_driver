import 'package:car2godriver/utils/helpers/api_helper.dart';

class VehicleElementsDataResponse {
  bool error;
  String msg;
  CategoryShortItem data;

  VehicleElementsDataResponse(
      {this.error = false, this.msg = '', required this.data});

  factory VehicleElementsDataResponse.fromJson(Map<String, dynamic> json) {
    return VehicleElementsDataResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: CategoryShortItem.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory VehicleElementsDataResponse.empty() => VehicleElementsDataResponse(
        data: CategoryShortItem(),
      );
  static VehicleElementsDataResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? VehicleElementsDataResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : VehicleElementsDataResponse.empty();
}

class CategoryShortItem {
  List<Category> categories;

  CategoryShortItem({this.categories = const []});

  factory CategoryShortItem.fromJson(Map<String, dynamic> json) =>
      CategoryShortItem(
        categories: APIHelper.getSafeList(json['categories'])
            .map((e) => Category.getAPIResponseObjectSafeValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'categories': categories.map((e) => e.toJson()).toList(),
      };

  static CategoryShortItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CategoryShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CategoryShortItem();
}

class Category {
  String id;
  String uid;
  String name;
  String image;
  List<Subcategory> subcategories;

  Category({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.image = '',
    this.subcategories = const [],
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        image: APIHelper.getSafeString(json['image']),
        subcategories: APIHelper.getSafeList(json['subcategories'])
            .map((e) => Subcategory.getAPIResponseObjectSafeValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'image': image,
        'subcategories': subcategories.map((e) => e.toJson()).toList(),
      };

  static Category getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Category.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Category();

  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => isEmpty == false;
}

class Subcategory {
  String id;
  String uid;
  String name;
  String image;

  Subcategory({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.image = '',
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        image: APIHelper.getSafeString(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'image': image,
      };

  static Subcategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Subcategory.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Subcategory();
}
