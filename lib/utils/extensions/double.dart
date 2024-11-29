import 'package:car2godriver/utils/helpers/helpers.dart';

extension DoubleExtensions on double {
  getCurrencyFormattedText({decimalDigits = 2}) =>
      Helper.getCurrencyFormattedWithDecimalAmountText(this, decimalDigits);
}
