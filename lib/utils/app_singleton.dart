import 'dart:convert';

import 'package:car2godriver/models/api_responses/site_settings.dart';
import 'package:car2godriver/services/profile_service.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/constants/app_local_stored_keys.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppSingleton {
  static AppSingleton? _instance;

  late Box localBox;
  final GetStorage localStorage = GetStorage();
  SiteSettings _settings = SiteSettings();
  SiteSettings get settings {
    if (_settings.isEmpty) {
      _settings = getSavedSiteSettingsFromLocalStorage();
    }
    return _settings;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  CountryCode _currentCountryCode = AppConstants.defaultCountryCode;
  CountryCode get currentCountryCode => _currentCountryCode;
  set currentCountryCode(CountryCode value) {
    _currentCountryCode = value;
    localStorage.write(LocalStoredKeyName.defaultCountryShortCode, value.code);
  }

  final AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails(AppConstants.notificationChannelID,
          AppConstants.notificationChannelName,
          channelDescription: AppConstants.notificationChannelDescription,
          importance: Importance.max,
          priority: Priority.max,
          ticker: AppConstants.notificationChannelTicker);

  final DarwinNotificationDetails darwinNotificationDetails =
      const DarwinNotificationDetails(
    // sound: 'sound.mp3',
    presentAlert: true,
    presentBadge: true,
    presentBanner: true,
    presentSound: true,
    // presentList:
  );

  void _getSavedCountryCode() {
    final String? savedCountryShortCode =
        localStorage.read(LocalStoredKeyName.defaultCountryShortCode);
    if (savedCountryShortCode != null) {
      currentCountryCode = CountryCode.fromCountryCode(savedCountryShortCode);
      return;
    }
    currentCountryCode = AppConstants.defaultCountryCode;
  }

  void initializeServices() {
    Get.lazyPut(() => ProfileService());
    // TODO: Need refactor local storage codes using this service
    // Get.lazyPut(() => LocalStorageService());
  }

  Future<void> initialize() async {
    await GetStorage.init();
    await Hive.initFlutter();
    initializeServices();
    localBox = await Hive.openBox(AppConstants.hiveBoxName);
    _getSavedCountryCode();
    _settings = getSavedSiteSettingsFromLocalStorage();
  }

  // SiteSettings settings = SiteSettings.empty();
  CameraPosition defaultCameraPosition = AppConstants.defaultMapCameraPosition;
  // late Box localBox;
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  Future<void> saveSiteSettingsIntoLocalStorage(SiteSettings settings) async {
    final siteSettingsAsJson = settings.toJson();
    final siteSettingsAsString = jsonEncode(siteSettingsAsJson);
    localStorage.write(LocalStoredKeyName.siteSettings, siteSettingsAsString);
  }

  static SiteSettings getSavedSiteSettingsFromLocalStorage() {
    final siteSettingsAsString =
        GetStorage().read(LocalStoredKeyName.siteSettings);
    if (siteSettingsAsString is! String) {
      return SiteSettings();
    }
    final siteSettingsAsJson = jsonDecode(siteSettingsAsString);
    return SiteSettings.getSafeObject(siteSettingsAsJson);
  }

  Future<bool> updateSiteSettings() async {
    final response = await APIRepo.getSiteSettings();
    if (response == null) {
      return false;
    } else if (response.error) {
      return false;
    }
    final siteSettings = response.data;
    await saveSiteSettingsIntoLocalStorage(siteSettings);
    _settings = siteSettings;
    if (_settings.isNotEmpty) {
      AppComponents.currencySymbol = _settings.currencySymbol;
    }
    return true;
  }

  AppSingleton._();

  // static void _onDidReceiveNotificationResponse(
  //     NotificationResponse notificationResponse) async {
  //   final String? payload = notificationResponse.payload;
  //   if (notificationResponse.payload != null) {
  //     log('notification payload: $payload');
  //   }
  //   // await Navigator.push( context, MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),);
  // }

  // static void _onDidReceiveBackgroundNotificationResponse(
  //     NotificationResponse notificationResponse) async {
  //   final String? payload = notificationResponse.payload;
  //   if (notificationResponse.payload != null) {
  //     log('background notification payload: $payload');
  //   }
  //   // await Navigator.push( context, MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),);
  // }

  // void _initializeLocalNotification() async {
  //   // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   // initialize the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       // AndroidInitializationSettings('app_icon');
  //       AndroidInitializationSettings('@mipmap/launcher_icon');
  //   // final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings( onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  //   const InitializationSettings initializationSettings =
  //       InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     // iOS: initializationSettingsDarwin,
  //     // macOS: initializationSettingsDarwin,
  //   );
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
  //       onDidReceiveBackgroundNotificationResponse:
  //           _onDidReceiveBackgroundNotificationResponse);
  // }

  // Future<void> initialize() async {
  //   localBox = await Hive.openBox(Constants.hiveBoxName);
  //   _initializeLocalNotification();
  // }

  static AppSingleton get instance => _instance ??= AppSingleton._();
}
