import 'package:car2godriver/models/api_responses/driver_vehicle_dynamic_fields.dart';
import 'package:car2godriver/models/local/dynamic_field_request.dart';

class ProfileDynamicFieldWidgetParameter {
  final DynamicFieldRequest valueDetails;
  final DriverDynamicField fieldDetails;
  ProfileDynamicFieldWidgetParameter({
    required this.valueDetails,
    required this.fieldDetails,
  });
}
