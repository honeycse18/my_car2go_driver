import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This file contain theme data of the app and initial custom default widget
/// configurations
class AppThemeData {
  static final ThemeData appThemeData = ThemeData(
      useMaterial3: false,
      // Set default font name
      // fontFamily: 'Nunito Sans 7pt',
      fontFamily: AppUIConstants.fontFamilyPoppins,
      primarySwatch: AppColors.primaryMaterialColor,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      // Setting all default textTheme based on design
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 36,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            fontSize: 26,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            fontSize: 24,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
            fontSize: 20,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.bold),
        labelLarge: TextStyle(
            fontSize: 18,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(
            fontSize: 16,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w400),
        bodySmall: TextStyle(
            fontSize: 14,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w400),
      ),
      // Set default TextField theme design
      inputDecorationTheme: const InputDecorationTheme(
          fillColor: AppColors.formInnerColor,
          filled: true,
          hintStyle: TextStyle(color: AppColors.bodyTextColor),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(AppComponents.defaultBorderRadius),
              borderSide:
                  BorderSide(color: AppColors.formBorderColor, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(AppComponents.defaultBorderRadius),
              borderSide:
                  BorderSide(color: AppColors.formBorderColor, width: 1))),
      // Set default appbar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 24,
            fontFamily: AppUIConstants.fontFamilyPoppins,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.bold),
      ),
      popupMenuTheme: const PopupMenuThemeData(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          textStyle: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w500)));
}
