enum NotificationType {
  confirmed('confirmed'),
  wallet('wallet'),
  notification('notification'),
  unknown('unknown');

  final String stringValue;
  const NotificationType(this.stringValue);

  static NotificationType toEnumValue(String value) {
    final Map<String, NotificationType> stringToEnumMap = {
      NotificationType.confirmed.stringValue: NotificationType.confirmed,
      NotificationType.wallet.stringValue: NotificationType.wallet,
      NotificationType.notification.stringValue: NotificationType.notification,
    };
    return stringToEnumMap[value] ?? NotificationType.unknown;
  }
}
