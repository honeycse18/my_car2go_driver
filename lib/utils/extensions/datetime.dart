import 'package:intl/intl.dart';

extension ServerDateTime on DateTime {
  String formatted(String pattern) => DateFormat(pattern).format(this);
}
