import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';

enum ProfileStatus {
  pending(AppConstants.profileStatusPending,
      AppLanguageTranslation.pendingTransKey),
  approved(AppConstants.profileStatusApproved,
      AppLanguageTranslation.approvedTransKey),
  cancelled(AppConstants.profileStatusCancelled,
      AppLanguageTranslation.cancelledTransKey),
  suspended(AppConstants.profileStatusSuspended,
      AppLanguageTranslation.suspendedTransKey),
  unknown('unknown', 'Unknown');

  final String stringValue;
  final String viewableTextTransKey;
  const ProfileStatus(this.stringValue, this.viewableTextTransKey);

  static ProfileStatus get defaultValue => unknown;

  factory ProfileStatus.fromString(String value) {
    final Map<String, ProfileStatus> stringToEnumMap = {
      ProfileStatus.pending.stringValue: ProfileStatus.pending,
      ProfileStatus.approved.stringValue: ProfileStatus.approved,
      ProfileStatus.cancelled.stringValue: ProfileStatus.cancelled,
      ProfileStatus.suspended.stringValue: ProfileStatus.suspended,
    };
    return stringToEnumMap[value] ?? ProfileStatus.defaultValue;
  }
}
