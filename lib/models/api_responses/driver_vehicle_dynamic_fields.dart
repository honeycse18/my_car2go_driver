import 'package:car2godriver/models/sealed_classes/dynamic_field_type.dart';
import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class DriverVehicleDynamicFields {
  List<VehicleDynamicField> vehicleFields;
  List<DriverDynamicField> driverFields;

  DriverVehicleDynamicFields(
      {this.vehicleFields = const [], this.driverFields = const []});

  factory DriverVehicleDynamicFields.fromJson(Map<String, dynamic> json) {
    return DriverVehicleDynamicFields(
      vehicleFields: APIHelper.getSafeList(json['vehicle_fields'])
          .map((e) => VehicleDynamicField.getSafeObject(e))
          .toList(),
      driverFields: APIHelper.getSafeList(json['driver_fields'])
          .map((e) => DriverDynamicField.getSafeObject(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'vehicle_fields': vehicleFields.map((e) => e.toJson()).toList(),
        'driver_fields': driverFields.map((e) => e.toJson()).toList(),
      };

  static DriverVehicleDynamicFields getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DriverVehicleDynamicFields.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DriverVehicleDynamicFields();
}

class DriverDynamicField {
  String id;
  String fieldName;
  String placeholder;
  String type;
  bool isRequired;
  bool isActive;
  String category;
  DynamicFieldInfo fieldInfo;
  List<DynamicFieldOption> options;
  DateTime createdAt;
  DateTime updatedAt;

  DriverDynamicField({
    this.id = '',
    this.fieldName = '',
    this.placeholder = '',
    this.type = '',
    this.isRequired = false,
    this.isActive = false,
    this.category = '',
    required this.fieldInfo,
    this.options = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory DriverDynamicField.empty() => DriverDynamicField(
      fieldInfo: DynamicFieldInfo(),
      createdAt: AppConstants.defaultUnsetDateTime,
      updatedAt: AppConstants.defaultUnsetDateTime);

  factory DriverDynamicField.fromJson(Map<String, dynamic> json) =>
      DriverDynamicField(
        id: APIHelper.getSafeString(json['_id']),
        fieldName: APIHelper.getSafeString(json['field_name']),
        placeholder: APIHelper.getSafeString(json['placeholder']),
        type: APIHelper.getSafeString(json['type']),
        isRequired: APIHelper.getSafeBool(json['is_required']),
        isActive: APIHelper.getSafeBool(json['is_active']),
        category: APIHelper.getSafeString(json['category']),
        fieldInfo: DynamicFieldInfo.getSafeObject(json['field_info']),
        options: APIHelper.getSafeList(json['options'])
            .map((e) => DynamicFieldOption.getSafeObject(e))
            .toList(),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'field_name': fieldName,
        'placeholder': placeholder,
        'type': type,
        'is_required': isRequired,
        'is_active': isActive,
        'category': category,
        'field_info': fieldInfo.toJson(),
        'options': options.map((e) => e.toJson()).toList(),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  static DriverDynamicField getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DriverDynamicField.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DriverDynamicField.empty();

  DynamicFieldType get typeAsSealedClass => DynamicFieldType.parse(
      type: type,
      fieldInfoType: fieldInfo.type,
      maxImageCount: fieldInfo.maxAllow,
      maxSize: fieldInfo.maxSize);
}

class VehicleDynamicField {
  String id;
  String fieldName;
  String placeholder;
  String type;
  bool isRequired;
  bool isActive;
  String category;
  DynamicFieldInfo fieldInfo;
  List<DynamicFieldOption> options;
  DateTime createdAt;
  DateTime updatedAt;

  VehicleDynamicField({
    this.id = '',
    this.fieldName = '',
    this.placeholder = '',
    this.type = '',
    this.isRequired = false,
    this.isActive = false,
    this.category = '',
    required this.fieldInfo,
    this.options = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory VehicleDynamicField.empty() => VehicleDynamicField(
      fieldInfo: DynamicFieldInfo(),
      createdAt: AppConstants.defaultUnsetDateTime,
      updatedAt: AppConstants.defaultUnsetDateTime);

  factory VehicleDynamicField.fromJson(Map<String, dynamic> json) =>
      VehicleDynamicField(
        id: APIHelper.getSafeString(json['_id']),
        fieldName: APIHelper.getSafeString(json['field_name']),
        placeholder: APIHelper.getSafeString(json['placeholder']),
        type: APIHelper.getSafeString(json['type']),
        isRequired: APIHelper.getSafeBool(json['is_required']),
        isActive: APIHelper.getSafeBool(json['is_active']),
        category: APIHelper.getSafeString(json['category']),
        fieldInfo: DynamicFieldInfo.getSafeObject(json['field_info']),
        options: APIHelper.getSafeList(json['options'])
            .map((e) => DynamicFieldOption.getSafeObject(e))
            .toList(),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'field_name': fieldName,
        'placeholder': placeholder,
        'type': type,
        'is_required': isRequired,
        'is_active': isActive,
        'category': category,
        'field_info': fieldInfo.toJson(),
        'options': options.map((e) => e.toJson()).toList(),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  static VehicleDynamicField getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? VehicleDynamicField.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : VehicleDynamicField.empty();

  DynamicFieldType get typeAsSealedClass => DynamicFieldType.parse(
      type: type,
      fieldInfoType: fieldInfo.type,
      maxImageCount: fieldInfo.maxAllow,
      maxSize: fieldInfo.maxSize);
}

class DynamicFieldOption {
  String label;
  dynamic value;
  String id;

  DynamicFieldOption({this.label = '', this.value, this.id = ''});

  factory DynamicFieldOption.fromJson(Map<String, dynamic> json) =>
      DynamicFieldOption(
        label: APIHelper.getSafeString(json['label']),
        value: json['value'],
        id: APIHelper.getSafeString(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'value': value,
        '_id': id,
      };

  static DynamicFieldOption getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DynamicFieldOption.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DynamicFieldOption();
}

class DynamicFieldInfo {
  String type;
  int maxSize;
  int maxAllow;

  DynamicFieldInfo({this.type = '', this.maxSize = -1, this.maxAllow = -1});

  factory DynamicFieldInfo.fromJson(Map<String, dynamic> json) =>
      DynamicFieldInfo(
        type: APIHelper.getSafeString(json['type']),
        maxSize: APIHelper.getSafeInt(json['max_size']),
        maxAllow: APIHelper.getSafeInt(json['max_allow']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'max_size': maxSize,
        'max_allow': maxAllow,
      };

  static DynamicFieldInfo getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DynamicFieldInfo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DynamicFieldInfo();
}
