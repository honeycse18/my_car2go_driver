import 'package:car2godriver/utils/constants/app_secrets.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppConstants {
  static const String appLiveBaseURL =
      'https://backend.1b.car2go.appstick.com.bd'; // New Live API
  // static const String appLiveBaseURL = 'https://api.car2go.1b.sabbir.tech'; // Deleted Live API
  // static const String appLiveBaseURL = 'https://car2gopro1b.appstick.com.bd'; // Old Live API
  static const String appLocalhostBaseURL = 'http://192.168.0.160:4400';
  static const bool isTestOnLocalhost = false;
  static const String appBaseURL =
      isTestOnLocalhost ? appLocalhostBaseURL : appLiveBaseURL;
  static const String apiVersionCode = 'v1';
  static const String googleMapBaseURL = 'https://maps.googleapis.com';

  static const String defaultCurrencySymbol = r'$';
  static const String defaultCountryShortCode = 'TG';
  static final CountryCode defaultCountryCode =
      CountryCode.fromCountryCode(defaultCountryShortCode);
  static const String languageTranslationKeyCode = '_code';
  static const String apiContentTypeFormURLEncoded =
      'application/x-www-form-urlencoded';
  static const String apiContentTypeJSON = 'application/json';
  static const String apiContentTypeFormData = 'multipart/form-data';
  static const String jpgFileContentType = 'image/jpeg';

  static const String googleAPIKey = AppSecrets.googleAPIKey;
  //==========================
  static const String rideRequestAccepted = 'accepted';
  static const String rideRequestRejected = 'rejected';
  static const String unknown = 'unknown';

//Payment method
  static const String cardStatus = 'card';
  static const String bankStatus = 'bank';
  static const String paypalStatus = 'paypal';

  // Push Notification configs
  static const String notificationChannelID = 'car2go';
  static const String notificationChannelName = 'Car2Go';
  static const String notificationChannelDescription =
      'One Ride app notification channel';
  static const String notificationChannelTicker = 'car2goticker';
  static const String hiveDefaultLanguageKey = 'default_language';
  static const double borderRadiusValue = 8;

  static const int defaultUnsetDateTimeYear = 1800;
  static final DateTime defaultUnsetDateTime =
      DateTime(AppConstants.defaultUnsetDateTimeYear);

  static const String apiDateTimeFormatValue =
      'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';

  static const double dialogBorderRadiusValue = 8;
  static const String apiOnlyDateFormatValue = 'dd-MM-yyyy';
  static const String apiOnlyTimeFormatValue = 'HH:mm';
  // ride status
  static const String rideTypeStatusAccepted = 'accepted';
  static const String rideTypeStatusRejected = 'rejected';
  //----------------------
  static const String hireDriverStatusHourly = 'hourly';
  static const String hireDriverStatusFixed = 'fixed';
  //----------------------
  static const String rentCarStatusHourly = 'hourly';
  static const String rentCarStatusWeekly = 'weekly';
  static const String rentCarStatusMonthly = 'monthly';
  //----------------------
  static const String regTypeVehicle = 'vehicle';
  static const String regTypeInfo = 'information';
  static const String regTypeDocument = 'documents';

  //vehicle list
  static const String vehicleListEnumPending = 'pending';
  static const String vehicleListEnumApproved = 'approved';
  static const String vehicleListEnumCancelled = 'cancelled';
  static const String vehicleListEnumSuspended = 'suspended';

  //Hire Driver list Type
  static const String hireDriverListEnumAccept = 'accepted';
  static const String hireDriverListEnumUserPending = 'user_pending';
  static const String hireDriverListEnumDriverPending = 'driver_pending';
  static const String hireDriverListEnumStarted = 'started';
  static const String hireDriverListEnumComplete = 'completed';
  static const String hireDriverListEnumCancel = 'cancelled';
  static const String ridePostAcceptanceStarted = 'started';
  static const String ridePostAcceptanceCompleted = 'completed';
  static const String ridePostAcceptanceCancelled = 'cancelled';

  static const String orderStatusPending = 'pending';
  static const String orderStatusAccepted = 'accepted';
  static const String orderStatusRejected = 'rejected';
  static const String orderStatusPicked = 'picked';
  static const String orderStatusOnWay = 'on_way';
  static const String orderStatusDelivered = 'delivered';

  // Profile status
  static const String profileStatusPending = 'pending';
  static const String profileStatusApproved = 'approved';
  static const String profileStatusCancelled = 'cancelled';
  static const String profileStatusSuspended = 'suspended';

  // Profile status
  static const String myVehicleStatusPending = 'pending';
  static const String myVehicleStatusApproved = 'approved';
  static const String myVehicleStatusCancelled = 'cancelled';
  static const String myVehicleStatusSuspended = 'suspended';

  // Profile current role
  static const String userRoleUser = 'user';
  static const String userRoleDriver = 'driver';

  static const String paymentMethodCashOnDelivery = 'cash_on_delivery';
  static const String paymentMethodStripe = 'stripe';
  static const String paymentMethodPaypal = 'paypal';
  //----------------------

  static const String confirmedOrderNotifyTypeConfirmOrder =
      'confirm_order_notify';

  static const String fallbackLocale = 'en_US';
  static const String fallbackFrenchLocale = 'fr_FR';
  // Vehicle Info Type status
  static const String vehicleDetailsInfoTypeStatusSpecifications =
      'specifications';

  static const String vehicleDetailsInfoTypeStatusFeatures = 'features';
  static const String vehicleDetailsInfoTypeStatusDocuments = 'documents';
  static const String vehicleDetailsInfoTypeStatusReview = 'review';
//===========================
  static const String shareRideHistoryOffering = 'offer_ride';
  static const String shareRideHistoryFindRide = 'find_ride';

  static const String shareRideActionMyRequest = 'request';
  static const String shareRideActionMyOffer = 'offer';
  // All types of statuses

  static const String shareRideAllStatusActive = 'active';
  static const String shareRideAllStatusAccepted = 'accepted';
  static const String shareRideAllStatusRejected = 'reject';
  static const String shareRideAllStatusStarted = 'started';
  static const String shareRideAllStatusPending = 'pending';
  static const String shareRideAllStatusCompleted = 'completed';
  static const String shareRideAllStatusCancelled = 'cancelled';
  static const String shareRideAllStatusOffer = 'offer';
  static const String shareRideAllStatusRequest = 'request';
  static const String shareRideAllStatusVehicle = 'vehicle';
  static const String shareRideAllStatusPassenger = 'passenger';

  //===========================
  //history Status
  static const String historyListEnumPending = 'pending';
  static const String historyListEnumAccepted = 'accepted';
  static const String historyListEnumStarted = 'started';
  static const String historyListEnumComplete = 'completed';
  static const String historyListEnumCancelled = 'cancelled';

  // Gender
  static const String genderMale = 'male';
  static const String genderFemale = 'female';
  static const String genderOther = 'other';

// messege status
  static const String messageTypeStatusCustomer = 'user';
  static const String messageTypeStatusOwner = 'owner';
  static const String messageTypeStatusDriver = 'driver';
  static const String messageTypeStatusAdmin = 'admin';

  // Dynamic field types
  static const String dynamicFieldTypeText = 'text';
  static const String dynamicFieldTypeNumber = 'number';
  static const String dynamicFieldTypeEmail = 'email';
  static const String dynamicFieldTypeTextArea = 'textarea';
  static const String dynamicFieldTypeImage = 'image';

  // Dynamic field image types
  static const String dynamicFieldImageTypeSingle = 'single';
  static const String dynamicFieldImageTypeMultiple = 'multiple';

  static const int maximumMultipleImageCount = 20;
  static const int minimumVehicleModelYearDecrementCounter = 50;

  // Dialog padding values
  static const double dialogVerticalSpaceValue = 16;
  static const double dialogHalfVerticalSpaceValue = 8;
  static const double dialogHorizontalSpaceValue = 18;
  static const double imageBorderRadiusValue = 8;
  static const double smallBorderRadiusValue = 8;
  static const double auctionGridItemBorderRadiusValue = 8;
  static const double uploadImageButtonBorderRadiusValue = 8;
  static const double defaultBorderRadiusValue = 8;
  // static const LatLng defaultMapLatLng = LatLng(8.662471152081386,
  //     1.0180393971192057); // Coordinate of Togo country center

  /// Screen horizontal padding value
  static const double screenPaddingValue = 24;
  // Methods
  static BorderRadius borderRadius(double radiusValue) =>
      BorderRadius.all(Radius.circular(radiusValue));

  static const String hiveBoxName = 'car2go';
  static const LatLng defaultMapLatLng = LatLng(22.8012222, 89.5804764);
  static const double defaultMapZoomLevel = 12.4746;

  static const double unknownLatLongValue = -999;
  static const CameraPosition defaultMapCameraPosition = CameraPosition(
    target: defaultMapLatLng,
    zoom: defaultMapZoomLevel,
  );
}
