import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:car2godriver/controller/drawer_screen_controller.dart';
import 'package:car2godriver/controller/home_navigator_screen_controller.dart';
import 'package:car2godriver/controller/menu_screen_controller.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/api_response.dart';
import 'package:car2godriver/models/api_responses/profile_details.dart';
import 'package:car2godriver/models/api_responses/user_details_response.dart';
import 'package:car2godriver/services/profile_service.dart';
import 'package:car2godriver/utils/app_singleton.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_local_stored_keys.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/utils/helpers/image_picker_helper.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:collection/collection.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:timeago/timeago.dart' as timeago;

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

/// This file contains helper functions and properties
class Helper {
  // static void select1ItemFromList(
  //     int listLength, int selectionIndex, Function(int, bool) doSelectOnIndex) {
  //   List.generate(listLength,
  //           (int booleanDataIndex) => booleanDataIndex == selectionIndex)
  //       .forEachIndexed((int dataIndex, bool booleanData) =>
  //           doSelectOnIndex(dataIndex, booleanData));
  // }

  static Size getScreenSize(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return screenSize;
  }

  // static NumberFormat get _currentNumberFormat {
  //   try {6
  //     return NumberFormat.currency(
  //         locale: Constants.fallbackFrenchLocale,
  //         symbol: AppSingleton.instance.settings.currencySymbol);
  //   } catch (e) {
  //     return NumberFormat.currency(
  //         locale: Constants.fallbackLocale,
  //         symbol: AppSingleton.instance.settings.currencySymbol);
  //   }
  // }

  /// Return default currency formatted text as string. Example: 45000 will
  /// return as $45,000
  // static String getCurrencyFormattedAmountText(double amount) {
  //   return _currentNumberFormat.format(amount);
  // }

  static String getFirstSafeString(List<String> images) {
    return images.firstOrNull ?? '';
  }

  static Future<void> showNotification(
      {required String title, required String message, String? payload}) async {
/*     const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            Constants.notificationChannelID, Constants.notificationChannelName,
            channelDescription: Constants.notificationChannelDescription,
            importance: Importance.max,
            priority: Priority.max,
            ticker: Constants.notificationChannelTicker); */
    final NotificationDetails notificationDetails = NotificationDetails(
        android: AppSingleton.instance.androidNotificationDetails,
        iOS: AppSingleton.instance.darwinNotificationDetails);
    await AppSingleton.instance.flutterLocalNotificationsPlugin.show(
        // getRandom6DigitGeneratedNumber(),
        generateNotificationID,
        title,
        message,
        notificationDetails,
        payload: payload);
  }

  static int get generateNotificationID {
    final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return id;
  }

  static double getAvailableScreenHeightForBottomSheet(BuildContext context) {
    final Size screenSize = getScreenSize(context);
    final double topUnavailableSpaceValue = MediaQuery.of(context).padding.top;
    final double topAvailableSpaceValue =
        screenSize.height - topUnavailableSpaceValue;
    return topAvailableSpaceValue;
  }

  static String getUserToken() {
    dynamic userToken =
        GetStorage().read(LocalStoredKeyName.loggedInDriverToken);
    if (userToken is! String) {
      return '';
    }
    return userToken;
  }

  static hideKeyBoard() {
    Future.delayed(
      const Duration(milliseconds: 0),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
  }

  static String getRelativeDateTimeText(DateTime dateTime) {
    return DateTime.now().difference(dateTime).inDays == 1
        ? 'Yesterday'
        : timeago.format(dateTime);
  }

  static Future<void> setloggedInDriverToLocalStorage(
      UserDetailsData userDetails) async {
    var vendorDetailsMap = userDetails.toJson();
    String userDetailsJson = jsonEncode(vendorDetailsMap);
    await GetStorage()
        .write(LocalStoredKeyName.loggedInDriver, userDetailsJson);
  }

  static ProfileDetails getUser() {
    dynamic loggedInDriverJsonString =
        GetStorage().read(LocalStoredKeyName.loggedInDriver);
    if (loggedInDriverJsonString is! String) {
      return ProfileDetails.empty();
    }
    dynamic loggedInDriverJson = jsonDecode(loggedInDriverJsonString);
/*     if (loggedInDriverJson is! Map<String, dynamic>) {
      return UserDetails.empty();
    } */
    return ProfileDetails.getSafeObject(loggedInDriverJson);
  }

  static void logout() async {
    final profileService = Get.find<ProfileService>();
    profileService.profileDetails = ProfileDetails.empty();
    GetStorage().write(LocalStoredKeyName.loggedInDriverToken, null);
    GetStorage().write(LocalStoredKeyName.loggedInDriver, null);
    await AppSingleton.instance.localBox.clear();

    try {
      Get.find<HomeNavigatorScreenController>().onClose();
    } catch (_) {}
    try {
      Get.find<MenuScreenController>().onClose();
    } catch (_) {}
    try {
      Get.find<ZoomDrawerScreenController>().onClose();
    } catch (_) {}
    Get.offAllNamed(AppPageNames.loginScreen);
  }

  static String getUserBearerToken({String? token}) {
    String loggedInUserToken = token ?? getUserToken();
    return 'Bearer $loggedInUserToken';
  }

  static bool isUserLoggedIn() {
    return (getUserToken().isNotEmpty || (getUser().isNotEmpty));
  }

  static Future<String?> get getFCMToken async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      return fcmToken;
    } catch (e) {
      // log(e.toString());
      return null;
    }
  }

  static Future<void> refreshLoggedInUserDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    await Helper.setLoggedInUserToLocalStorage(response.data as ProfileDetails);
  }

  static Future<bool> updateSavedDriverDetails(
      {bool showErrorsOnUI = false, bool shouldLogout = false}) async {
    final APIResponse<ProfileDetails>? response =
        await APIRepo.getProfileUpdated();
    if (response == null) {
      if (shouldLogout) {
        Helper.logout();
        APIHelper.onFailure(
          AppLanguageTranslation.sessionExpiredTranskey.toCurrentLanguage,
        );
        return false;
      }
      return false;
    } else if (response.error) {
      if (showErrorsOnUI) {
        APIHelper.onFailure(response.message);
      }
      return false;
    }
    final profileDetails = response.data;
    await Helper.setLoggedInUserToLocalStorage(profileDetails);
    try {
      final profileService = Get.find<ProfileService>();
      profileService.profileDetails = profileDetails;
    } catch (_) {}
    return true;
  }
/*   static bool isRememberedMe() {
    final dynamic isRememberedMe =
        GetStorage().read(LocalStoredKeyName.rememberMe);
    if (isRememberedMe is bool) {
      return isRememberedMe;
    }
    return false;
  } */

/*   static String? passwordFormValidator(String? text) {
    if (text != null) {
      if (text.isEmpty) {
        return 'Password can not be empty';
      }
      if (text.length < 6) {
        return 'Minimum length 6';
      }
      if (!text.contains(RegExp(r'[0-9]'))) {
        return 'Must contain a digit';
      }
    }
    return null;
  } */

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position?> getGPSLocationData() async {
    try {
      // Test if location services are enabled.
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        AppDialogs.showErrorDialog(
            messageText: 'Location services are disabled. Please turn on GPS');
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          AppDialogs.showErrorDialog(
              messageText:
                  'Location permissions are denied. Please try again to permit location access');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        AppDialogs.showErrorDialog(
            messageText:
                'Location permissions are permanently denied, we cannot request permissions. You can permit location by going on app settings.');
        return null;
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      return null;
    }
  }

  static String getRoundedDecimalUpToTwoDigitText(double doubleNumber) {
    return doubleNumber.toStringAsFixed(2);
  }

  /// Generate Material color
  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: _generateTintColor(color, 0.9),
      100: _generateTintColor(color, 0.8),
      200: _generateTintColor(color, 0.6),
      300: _generateTintColor(color, 0.4),
      400: _generateTintColor(color, 0.2),
      500: color,
      600: _generateShadeColor(color, 0.1),
      700: _generateShadeColor(color, 0.2),
      800: _generateShadeColor(color, 0.3),
      900: _generateShadeColor(color, 0.4),
    });
  }

  // Helper functions for above function
  static int _generateTintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color _generateTintColor(Color color, double factor) => Color.fromRGBO(
      _generateTintValue(color.red, factor),
      _generateTintValue(color.green, factor),
      _generateTintValue(color.blue, factor),
      1);

  static int _generateShadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color _generateShadeColor(Color color, double factor) =>
      Color.fromRGBO(
          _generateShadeValue(color.red, factor),
          _generateShadeValue(color.green, factor),
          _generateShadeValue(color.blue, factor),
          1);

  static void showSnackBar(String message) {
    BuildContext? context = Get.context;
    if (context != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  // static Future<Placemark?> getAddressDetails(
  //     double latitude, double longitude) async {
  //   try {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(latitude, longitude);
  //     return placemarks.firstOrNull;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // static String getAddressDetailsText(Placemark placemark) {
  //   String addressText = '';
  //   if (placemark.name != null && (placemark.name?.isNotEmpty ?? false)) {
  //     addressText += '${placemark.name}, ';
  //   }
  //   if (placemark.subLocality != null &&
  //       (placemark.subLocality?.isNotEmpty ?? false)) {
  //     addressText += '${placemark.subLocality}, ';
  //   }
  //   if (placemark.administrativeArea != null &&
  //       (placemark.administrativeArea?.isNotEmpty ?? false)) {
  //     addressText += '${placemark.administrativeArea}, ';
  //   }
  //   if (placemark.postalCode != null &&
  //       (placemark.postalCode?.isNotEmpty ?? false)) {
  //     addressText += '${placemark.postalCode}, ';
  //   }
  //   if (placemark.country != null && (placemark.country?.isNotEmpty ?? false)) {
  //     addressText += '${placemark.country}';
  //   }
  //   return addressText;
  // }

  static Color getColor(String hexCode) {
    final hexColor = hexCode.replaceFirst('#', '');
    return Color((int.tryParse(hexColor, radix: 16) ?? 0) + 0xFF000000);
  }

  static String ddMMMyyyyFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd MMM, yyyy').format(dateTime);
  static String yyyyMMddFormattedDateTime(DateTime dateTime) =>
      DateFormat('yyyy-MM-dd').format(dateTime);
  static String ddMMMyyyyhhmmFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd MMM, hh:mm a').format(dateTime);
  static String MMMddyyyyFormattedDateTime(DateTime dateTime) =>
      DateFormat('MMM dd, yyyy').format(dateTime);

  static String ddMMMyyyyhhmmaFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd MMM,yyyy | hh:mm a').format(dateTime);

  static String hhmmFormattedDateTime(DateTime dateTime) =>
      DateFormat('hh:mm a').format(dateTime);
  static int dateTimeDifferenceInDays(DateTime date) {
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime.now())
        .inDays;
  }

  static String timeZoneSuffixedDateTimeFormat(DateTime dateTime) {
    // Creating a DateFormat object with the required format
    DateFormat formatter = DateFormat("yyyy-MM-ddTHH:mm:ss");

    // Formatting the DateTime object using the formatter
    String formattedDateTime = formatter.format(dateTime);

    // Calculating the timezone offset
    Duration offset = dateTime.timeZoneOffset;
    String offsetSign = offset.isNegative ? '-' : '+';
    String offsetHours = offset.inHours.abs().toString().padLeft(2, '0');
    String offsetMinutes =
        offset.inMinutes.abs().remainder(60).toString().padLeft(2, '0');

    // Constructing the final formatted date string with timezone offset
    String finalFormattedDateTime =
        '$formattedDateTime$offsetSign$offsetHours$offsetMinutes';

    return finalFormattedDateTime;
  }

  static Future<void> setLoggedInUserToLocalStorage(
      ProfileDetails userDetails) async {
    final driverDetailsAsMap = userDetails.toJson();
    String driverDetailsJson = jsonEncode(driverDetailsAsMap);
    await GetStorage()
        .write(LocalStoredKeyName.loggedInDriver, driverDetailsJson);
  }

  static String ddMMMFormattedDate(DateTime dateTime) =>
      DateFormat('dd MMM').format(dateTime);
  static String hhmmFormattedTime(DateTime dateTime) =>
      DateFormat('hh:mm a').format(dateTime);

  /// Returns if today, true
  static bool isToday(DateTime date) {
    return dateTimeDifferenceInDays(date) == 0;
  }

  /// Returns if tomorrow, true
  static bool isTomorrow(DateTime date) {
    return dateTimeDifferenceInDays(date) == 1;
  }

  /// Returns if yesterday, true
  static bool wasYesterday(DateTime date) {
    return dateTimeDifferenceInDays(date) == -1;
  }

  static int getRandom6DigitGeneratedNumber() {
    Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
    double next = rnd.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    return next.toInt();
  }

  static Future<List<Uint8List?>> pickImages(
      {String imageName = '',
      int maxImages = AppConstants.maximumMultipleImageCount,
      // required void Function( List<Uint8List> imageData, Map<String, dynamic> additionalData) onSuccessUploadSingleImage,
      // Map<String, dynamic> additionalData = const {},
      String token = ''}) async {
    final List<image_picker.XFile>? pickedImages =
        await ImagePickerHelper.getPhoneImages();
    if (pickedImages == null) {
      return [];
    }
    if (pickedImages.length > maxImages) {
      AppDialogs.showErrorDialog(
          messageText: 'You cannot select more than $maxImages images');
      return [];
    }
    return _processPickedImages(
      pickedImages,
      // onSuccessUploadSingleImage: onSuccessUploadSingleImage,
      imageName: imageName,
      // additionalData: additionalData,
      // token: token
    );
    // AppDialogs.showProcessingDialog(message: 'Image is processing');
  }

  // Single image upload
  static Future<Uint8List?> pickImage(
      {String imageName = '',
      // required void Function(Uint8List?, Map<String, dynamic>) onSuccessUploadSingleImage,
      Map<String, dynamic> additionalData = const {},
      String token = ''}) async {
    final image_picker.XFile? pickedImage =
        await ImagePickerHelper.getPhoneImage();
    if (pickedImage == null) {
      return null;
    }
    return await _processPickedImage(pickedImage,
        // onSuccessUploadingSingleImage: onSuccessUploadSingleImage,
        imageName: imageName,
        additionalData: additionalData,
        token: token);
  }

  static Future<String> pickThenUploadImage({required String fileName}) async {
    final pickedImage = await pickImage();
    if (pickedImage == null) {
      return '';
    }
    final tempFile = await getTempFileFromImageBytes(pickedImage);
    FormData requestBody = FormData({
      'file': MultipartFile(tempFile,
          filename: '$fileName.jpg',
          contentType: AppConstants.jpgFileContentType),
      'file_name': fileName
    });
    final response = await APIRepo.uploadSingleImage(requestBody);
    await deleteTempFile(tempFile);
    if (response == null) {
      return '';
    }
    if (response.error) {
      return '';
    }
    return response.data.data;
  }

  static Future<List<String>> pickThenUploadImages(
      {required String fileName,
      int maxImages = AppConstants.maximumMultipleImageCount}) async {
    final pickedImages = await pickImages(maxImages: maxImages);
    if (pickedImages.isEmpty) {
      return [];
    }
    final validPickedImages = pickedImages.whereType<Uint8List>();
    if (validPickedImages.length < pickedImages.length) {
      return [];
    }
    final List<File> tempFiles = await Future.wait(validPickedImages
        .map(
          (image) async => getTempFileFromImageBytes(image),
        )
        .toList());
    FormData requestBody = FormData({
      'files': validPickedImages
          .mapIndexed((index, imageRawData) => MultipartFile(imageRawData,
              filename: 'image_$index.jpg',
              contentType: AppConstants.jpgFileContentType))
          .toList(),
      'file_name': fileName
    });
    final response = await APIRepo.uploadMultipleImage(requestBody);

    await Future.wait(tempFiles.map((e) => deleteTempFile(e)).toList());
    if (response == null) {
      return [];
    }
    if (response.error) {
      return [];
    }
    return response.data.data;
  }

  static Future<Uint8List?> _processPickedImage(image_picker.XFile pickedImage,
      {
      // required void Function(Uint8List?, Map<String, dynamic>) onSuccessUploadingSingleImage,
      required String imageName,
      required Map<String, dynamic> additionalData,
      required String token}) async {
    final Uint8List? processedImage =
        await ImagePickerHelper.getProcessedImage(pickedImage);
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    if (processedImage == null) {
      await AppDialogs.showErrorDialog(
          messageText: 'Failed to select image. Please select another image');
      return null;
    }
    const String messageText = 'Are you sure to set this image?';
    final dynamic confirmResponse =
        await AppDialogs.showSingleImageUploadConfirmDialog(
            selectedImageData: processedImage,
            messageText: messageText,
            shouldCloseDialogOnceYesTapped: false,
            onYesTap: () async {
              return Get.back(result: true);
            });
    if (confirmResponse == true) {
      // onSuccessUploadingSingleImage(processedImage, additionalData);
      return processedImage;
    }
    return null;
  }

  static String? withdrawValidator(String? text) {
    if (text != null) {
      if (text.isEmpty) return 'Can not be empty';
    }
    return null;
  }

  static Future<List<Uint8List?>> _processPickedImages(
    List<image_picker.XFile> pickedImages, {
    // required void Function(List<Uint8List>, Map<String, dynamic>) onSuccessUploadSingleImage,
    required String imageName,
    // required Map<String, dynamic> additionalData,
    // required String token
  }) async {
    final List<Uint8List?> processedImages =
        await ImagePickerHelper.getProcessedImages(pickedImages);
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    /* if (processedImages == null) {
      AppDialogs.showErrorDialog(
          messageText: 'Error occurred while processing image');
      return;
    } */
    if (processedImages.isEmpty) {
      await AppDialogs.showErrorDialog(
          messageText: 'Failed to select any image. Please exclude that image');
      return [];
    }
    final String messageText = imageName.isEmpty
        ? 'Are you sure to set these image?'
        : 'Are you sure to set these image as $imageName?';
    final dynamic confirmResponse =
        await AppDialogs.showMultipleImageUploadConfirmDialog(
      selectedImageData: processedImages,
      shouldCloseDialogOnceYesTapped: false,
      messageText: messageText,
      onYesTap: () async {
        return Get.back(result: true);
      },
    );
    if (confirmResponse is bool && confirmResponse) {
      return processedImages;
    }
    return [];
    // String imageFileName = '';
    // String id = '';
/*       Uri? logoUri = Uri.tryParse(vendorDetails.store.nidImage);
      if (logoUri != null) {
        if (logoUri.pathSegments.length >= 2) {
          // id = logoUri.pathSegments[logoUri.pathSegments.length - 2];
          // imageFileName = logoUri.pathSegments[logoUri.pathSegments.length - 1];
        }
      } */
    /* APIHelper.uploadSingleImage(processedImage, onSuccessUploadSingleImage,
          imageFileName: imageFileName,
          id: id,
          additionalData: additionalData,
          token: token); */
    // }
  }

  static Future<File> getTempFileFromImageBytes(Uint8List imageBytes) async {
    final tempDir = await getTemporaryDirectory();
    File file =
        await File('${tempDir.path}/${getRandom6DigitGeneratedNumber()}.jpg')
            .create();
    return file.writeAsBytes(imageBytes);
  }

  static Future<void> deleteTempFile(File tempFile) async {
    try {
      tempFile.delete();
    } catch (e) {
      dev.log(e.toString());
    }
  }

  static String getCurrencyFormattedWithDecimalAmountText(double amount,
      [int decimalDigit = 2]) {
    return AppComponents.defaultDecimalNumberFormat.format(amount);
  }

  static void scrollToStart(ScrollController scrollController) {
    if (scrollController.hasClients && !scrollController.position.outOfRange) {
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  static String ddMMyyFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd/MM/yy').format(dateTime);

  static String ddMMyyyyFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd-MM-yyyy').format(dateTime);

  static String hhMMaFormattedDate(DateTime dateTime) =>
      DateFormat('hh:mm a').format(dateTime);

  static String dayFullFormattedDateTime(DateTime dateTime) =>
      DateFormat('EEEE').format(dateTime);

  static String hhmm24FormattedDateTime(TimeOfDay dateTime) =>
      DateFormat('hh:mm').format(
          DateTime(DateTime.now().year, 1, 0, dateTime.hour, dateTime.minute));

  static String avatar2LetterUsername(String firstName, String lastName) {
    if (lastName.isEmpty) {
      if (firstName.isEmpty) {
        return '';
      }
      final firstCharacter = firstName.characters.first;
      final secondCharacter = firstName.characters.length >= 2
          ? firstName.characters.elementAt(1)
          : '';
      return '$firstCharacter$secondCharacter';
    }
    if (firstName.isEmpty) {
      return '';
    }
    final firstCharacter = firstName.characters.first;
    final secondCharacter = lastName.characters.first;
    return '$firstCharacter$secondCharacter';
  }

  static ({String dialCode, String strippedPhoneNumber})?
      separatePhoneAndDialCode(String fullPhoneNumber) {
    final foundCountryCode = codes.firstWhereOrNull(
        (code) => fullPhoneNumber.contains(code['dial_code'] ?? ''));
    if ((foundCountryCode == null) || (foundCountryCode['dial_code'] == null)) {
      return null;
    }
    final dialCode = fullPhoneNumber.substring(
      0,
      foundCountryCode["dial_code"]!.length,
    );
    final newPhoneNumber = fullPhoneNumber.substring(
      foundCountryCode["dial_code"]!.length,
    );
    return (dialCode: dialCode, strippedPhoneNumber: newPhoneNumber);
  }

  static String? phoneFormValidator(String? text) {
    if (text != null) {
      if (!GetUtils.isPhoneNumber(text)) {
        return 'Invalid phone number format';
      }
      return null;
    }
    return null;
  }

  static String? emailFormValidator(String? text) {
    if (text != null) {
      if (!GetUtils.isEmail(text)) {
        return 'Invalid email format';
      }
      return null;
    }
    return null;
  }

  static bool isPasswordMoreThanMinimumLength(String? text,
          {int minimumLength = 8}) =>
      ((text?.length ?? 0) >= minimumLength);

  static bool isPasswordHasUppercaseCharacter(String? text) =>
      RegExp(r'(?=.*?[A-Z])').hasMatch(text ?? '');

  static bool isPasswordHasLowercaseCharacter(String? text) =>
      RegExp(r'(?=.*?[a-z])').hasMatch(text ?? '');

  static bool isPasswordHasDigitCharacter(String? text) =>
      RegExp(r'(?=.*?[0-9])').hasMatch(text ?? '');

  static bool isPasswordHasSpecialCharacter(String? text) =>
      RegExp(r'(?=.*?[!@#$%^&*])').hasMatch(text ?? '');

  static bool isConfirmPasswordSame(String? text, String? confirmPassword) =>
      (text != null || confirmPassword != null)
          ? false
          : text == confirmPassword;

  static String? passwordFormValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Password is required';
    } else if (!isPasswordMoreThanMinimumLength(text)) {
      return 'Password must be at least 8 characters long';
    } else if (!isPasswordHasUppercaseCharacter(text)) {
      return 'Password must include at least 1 uppercase letter';
    } else if (!isPasswordHasLowercaseCharacter(text)) {
      return 'Password must include at least 1 lowercase letter';
    } else if (!isPasswordHasDigitCharacter(text)) {
      return 'Password must include at least 1 number';
    } else if (!isPasswordHasSpecialCharacter(text)) {
      return 'Password must include at least 1 special character (!@#\$%^&*)';
    }
    return null;
  }

  /// used to check User name Input Field Should no empty
  static String? textFormValidator(String? text) {
    if (text != null) {
      if (text.isEmpty) return 'Can not be empty';
      if (text.length < 3) return 'Minimum length 3';
    }
    return null;
  }

  static Future<DateTime?> openDatePicker({
    required BuildContext context,
    DateTime? selectedDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    String? helpText,
    String? cancelText,
    String? confirmText,
    Locale? locale,
  }) async =>
      showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: firstDate,
          lastDate: lastDate,
          initialDatePickerMode: initialDatePickerMode,
          helpText: helpText,
          cancelText: cancelText,
          confirmText: confirmText,
          locale: locale);

  static void getBackToHomePage() {
    Get.until((route) => Get.currentRoute == AppPageNames.zoomDrawerScreen);
  }
}
