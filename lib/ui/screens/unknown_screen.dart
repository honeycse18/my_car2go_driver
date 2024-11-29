import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:flutter/material.dart';

class UnKnownScreen extends StatelessWidget {
  const UnKnownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Text(AppLanguageTranslation.unKnownTransKey.toCurrentLanguage),
    );
  }
}
