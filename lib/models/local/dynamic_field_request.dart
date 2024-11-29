import 'package:car2godriver/models/api_responses/driver_vehicle_dynamic_fields.dart';
import 'package:car2godriver/models/sealed_classes/dynamic_field_type.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';

class DynamicFieldRequest {
  DriverDynamicField driverFieldInfo;
  VehicleDynamicField vehicleFieldInfo;
  String keyValue;
  List<String> values;
  String type;
  bool isRequired;

  DynamicFieldRequest(
      {required this.values,
      required this.driverFieldInfo,
      required this.vehicleFieldInfo,
      this.keyValue = '',
      this.type = '',
      this.isRequired = false});

  factory DynamicFieldRequest.empty() => DynamicFieldRequest(
      values: [],
      driverFieldInfo: DriverDynamicField.empty(),
      vehicleFieldInfo: VehicleDynamicField.empty());

  factory DynamicFieldRequest.fromJson(Map<String, dynamic> json) =>
      DynamicFieldRequest(
        keyValue: APIHelper.getSafeString(json['key']),
        type: APIHelper.getSafeString(json['type']),
        values: APIHelper.getSafeList(json['options'])
            .map((e) => APIHelper.getSafeString(e))
            .toList(),
        driverFieldInfo: DriverDynamicField.empty(),
        vehicleFieldInfo: VehicleDynamicField.empty(),
        isRequired: APIHelper.getSafeBool(json['required']),
      );

  Map<String, dynamic> toRequestJson() => {
        'key': keyValue,
        'value': values.map((e) => e).toList(),
        'type': type,
      };

  static DynamicFieldRequest getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DynamicFieldRequest.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DynamicFieldRequest.empty();

  DynamicFieldType get typeAsSealedClass =>
      DynamicFieldType.parse(type: type, isRequired: isRequired);
}
