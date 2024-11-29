import 'package:car2godriver/utils/constants/app_constants.dart';

enum UserRole {
  user(AppConstants.userRoleUser, 'User'),
  driver(AppConstants.userRoleDriver, 'Driver'),
  unknown('unknown', 'Unknown');

  final String stringValue;
  final String viewableTextTransKey;
  const UserRole(this.stringValue, this.viewableTextTransKey);

  static UserRole get defaultValue => UserRole.unknown;

  factory UserRole.fromString(String value) {
    final Map<String, UserRole> stringToEnumMap = {
      UserRole.user.stringValue: UserRole.user,
      UserRole.driver.stringValue: UserRole.driver,
    };
    return stringToEnumMap[value] ?? defaultValue;
  }
}
