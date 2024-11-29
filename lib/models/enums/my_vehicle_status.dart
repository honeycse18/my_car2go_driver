import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';

enum MyVehicleStatus {
  pending(AppConstants.myVehicleStatusPending,
      AppLanguageTranslation.pendingTransKey),
  approved(AppConstants.myVehicleStatusApproved,
      AppLanguageTranslation.approvedTransKey),
  cancelled(AppConstants.myVehicleStatusCancelled,
      AppLanguageTranslation.cancelledTransKey),
  suspended(AppConstants.myVehicleStatusSuspended,
      AppLanguageTranslation.suspendedTransKey),
  unknown('unknown', 'Unknown');

  final String stringValue;
  final String viewableTextTransKey;
  const MyVehicleStatus(this.stringValue, this.viewableTextTransKey);

  static MyVehicleStatus get defaultValue => unknown;

  factory MyVehicleStatus.fromString(String value) {
    final Map<String, MyVehicleStatus> stringToEnumMap = {
      MyVehicleStatus.pending.stringValue: MyVehicleStatus.pending,
      MyVehicleStatus.approved.stringValue: MyVehicleStatus.approved,
      MyVehicleStatus.cancelled.stringValue: MyVehicleStatus.cancelled,
      MyVehicleStatus.suspended.stringValue: MyVehicleStatus.suspended,
    };
    return stringToEnumMap[value] ?? MyVehicleStatus.defaultValue;
  }
}
