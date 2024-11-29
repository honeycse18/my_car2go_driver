import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';

/// This file contains custom colors used throughout the app
class AppColors {
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color primaryColor = Color(0xFF016A70);
  static const Color primaryButtonColor = Color(0xFFFFFFFF);
  static const Color mainButtonBackColor = Color(0xFF1D272F);
  static const Color secondaryButtonColor = Color(0xFF1D272F);
  static const Color formBorderColor = Color(0xFFE8EAEB);
  static const Color fromSelectedBorderColor = Color(0xFFF2F5FC);
  static const Color formInnerColor = Color(0xFFFFFFFF);
  static const Color yColor = Color(0xFFEDEDEE);
  static const Color zColor = Color(0xFF1E797E);
  static const Color appbarTittleColor = Color(0xFFFFFFFF);
  static const Color primaryTextColor = Color(0xFF0B204C);
  static const Color bodyTextColor = Color(0xFF919BB3);
  static const Color bodyTextColor2 = Color(0xFFBDC3D1);
  static const Color grayShadeColor = Color(0xFFD4DAE3);
  static const Color grayShadeColor2 = Color(0xFFECEEF2);
  static const Color secondaryFont2Color = Color(0xFFB2BAC9);
  static const Color secondaryColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color alertColor = Color(0xFFFE4651);
  static const Color buttonLightStandardColor = Color(0xFF262626);
  static const Color fromBorderColor = Color(0xFFE8EAEB);
  static const Color successColor = Color(0xFF22C55E);
  static const Color earningColor = Color(0xFF50B498);
  static const Color warningColor = Color(0xFFEAB308);
  static const Color infoColor = Color(0xFF3B82F6);
  static const Color containerBoxColor = Color(0xFFECECEC);
  static const Color grayButtonColor = Color(0xFFF2F2F2);
  static const Color successBackgroundColor = Color(0xFFEEF9E8);

  static const Color unSelectVehicleColor = Color(0xFFF1F5F9);
  static const Color earningBoxColor = Color(0xFFF5F7F8);
  static const Color unSelectVehicleBorderColor = Color(0xFF64748B);
  static const Color selectVehicleColor = Color(0x19016A70);
  static const Color notificationIconColor = Color(0xFF304FFE);
  static const Color myRideTabColor = Color(0xFFF1F5F9);
  static const Color dividerColor = Color(0xFFCED7E2);
  static const Color gridColor = Color.fromARGB(255, 238, 238, 238);

  static const Color walletAddMoneyColor = Color(0xFFF0FDF4);
  static const Color walletWithdrawMoneyColor = Color(0xFFFEF2F2);
  // static const Color contentColorprimary = Color(0xFFCBDEDF);

  static const Color contentColorGreen = Color(0xFFCBDEDF);

  static const Color gray200 = Color(0xFFD4DAE3);

  static const Color coloredOutlinedButtonBackground = Color(0xFFF3F6F8);

  /// Custom MaterialColor from Helper function
  static final MaterialColor primaryMaterialColor =
      Helper.generateMaterialColor(AppColors.primaryColor);
}
