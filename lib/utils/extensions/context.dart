import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  bool get isKeyboardOpen => mediaQuery.viewInsets.bottom != 0;
}
