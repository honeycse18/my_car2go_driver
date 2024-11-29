import 'package:car2godriver/utils/helpers/api_helper.dart';

class LanguageTranslationsResponse {
  bool error;
  String msg;
  List<LanguageTranslation> data;

  LanguageTranslationsResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory LanguageTranslationsResponse.fromJson(Map<String, dynamic> json) {
    return LanguageTranslationsResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: APIHelper.getSafeList(json['data'])
          .map((e) => LanguageTranslation.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };
  static LanguageTranslationsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? LanguageTranslationsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : LanguageTranslationsResponse();
}

class LanguageTranslation {
  String id;
  String name;
  String code;
  String flag;
  bool isRTL;
  bool isDefault;
  Map<String, String> translation;

  LanguageTranslation({
    this.id = '',
    this.name = '',
    this.code = '',
    this.flag = '',
    this.isDefault = false,
    this.isRTL = false,
    this.translation = const {},
  });

  factory LanguageTranslation.fromJson(Map<String, dynamic> json) =>
      LanguageTranslation(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
        code: APIHelper.getSafeString(json['code']),
        flag: APIHelper.getSafeString(json['flag']),
        isDefault: APIHelper.getSafeBool(json['default']),
        isRTL: APIHelper.getSafeBool(json['rtl']),
        // translation: Translation.fromJson(json['translation'] as Map<String, dynamic>),
        translation: (json['translations'] is Map<String, dynamic>
            ? getProperTranslationMap(json['translations'])
            : {}),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
        'flag': flag,
        'rtl': isRTL,
        'default': isDefault,
        'translations': translation,
      };

  static Map<String, String> getProperTranslationMap(
      Map<String, dynamic> translationMap) {
    Map<String, String> properTranslationMap = <String, String>{};
    translationMap.forEach((key, value) {
      if (value is String) {
        properTranslationMap[key] = value;
      }
    });
    return properTranslationMap;
  }

  static LanguageTranslation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? LanguageTranslation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : LanguageTranslation();
}
