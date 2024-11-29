import 'package:car2godriver/utils/constants/app_constants.dart';

// enum AddVehicleTabState { vehicle, information, documents }
enum AddVehicleDetailsTabState { incomplete, current, completed }
// enum AddVehicleDetailsTabState { incomplete, current, completed }

enum AddVehicleTabState {
  vehicle,
  information,
  documents;

  static bool shouldSelectThisTab(
      {required AddVehicleTabState selectedTab,
      required AddVehicleTabState currentTab}) {
    if (selectedTab == currentTab) {
      return true;
    }
    return isThisPreviousTab(currentTab: currentTab, selectedTab: selectedTab);
  }

  static bool shouldNotSelectThisTab(
          {required AddVehicleTabState selectedTab,
          required AddVehicleTabState currentTab}) =>
      shouldSelectThisTab(currentTab: currentTab, selectedTab: selectedTab) ==
      false;

  static bool isThisPreviousTab({
    required AddVehicleTabState currentTab,
    required AddVehicleTabState selectedTab,
  }) =>
      switch (currentTab) {
        AddVehicleTabState.vehicle =>
          (selectedTab == AddVehicleTabState.information) ||
              (selectedTab == AddVehicleTabState.documents), // First tab
        AddVehicleTabState.information =>
          selectedTab == AddVehicleTabState.documents, // Seconds tab
        AddVehicleTabState.documents => false, //  Third/Last tab
      };
}

enum RideStatus {
  accepted(AppConstants.rideTypeStatusAccepted, 'Accepted'),
  rejected(AppConstants.rideTypeStatusRejected, 'Rejected');

  final String stringValue;
  final String stringValueForView;
  const RideStatus(this.stringValue, this.stringValueForView);

  static RideStatus toEnumValue(String value) {
    final Map<String, RideStatus> stringToEnumMap = {
      RideStatus.accepted.stringValue: RideStatus.accepted,
      RideStatus.rejected.stringValue: RideStatus.rejected,
    };
    return stringToEnumMap[value] ?? RideStatus.rejected;
  }
}

enum RideRequestStatus {
  accepted(AppConstants.rideRequestAccepted, 'Upcoming'),
  rejected(AppConstants.rideRequestRejected, 'Rejected'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const RideRequestStatus(this.stringValue, this.stringValueForView);

  static RideRequestStatus toEnumValue(String value) {
    final Map<String, RideRequestStatus> stringToEnumMap = {
      RideRequestStatus.accepted.stringValue: RideRequestStatus.accepted,
      RideRequestStatus.rejected.stringValue: RideRequestStatus.rejected,
      RideRequestStatus.unknown.stringValue: RideRequestStatus.unknown,
    };
    return stringToEnumMap[value] ?? RideRequestStatus.unknown;
  }
}

enum RideHistoryStatus {
  pending(AppConstants.orderStatusPending, 'Pending'),
  accepted(AppConstants.rideRequestAccepted, 'Upcoming'),
  started(AppConstants.ridePostAcceptanceStarted, 'Started'),
  completed(AppConstants.ridePostAcceptanceCompleted, 'Completed'),
  cancelled(AppConstants.ridePostAcceptanceCancelled, 'Cancelled'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const RideHistoryStatus(this.stringValue, this.stringValueForView);

  static RideHistoryStatus toEnumValue(String value) {
    final Map<String, RideHistoryStatus> stringToEnumMap = {
      RideHistoryStatus.pending.stringValue: RideHistoryStatus.pending,
      RideHistoryStatus.accepted.stringValue: RideHistoryStatus.accepted,
      RideHistoryStatus.started.stringValue: RideHistoryStatus.started,
      RideHistoryStatus.completed.stringValue: RideHistoryStatus.completed,
      RideHistoryStatus.cancelled.stringValue: RideHistoryStatus.cancelled,
      RideHistoryStatus.unknown.stringValue: RideHistoryStatus.unknown
    };
    return stringToEnumMap[value] ?? RideHistoryStatus.unknown;
  }
}

enum RideHistoryStatusEnum {
  pending(AppConstants.historyListEnumPending, 'Pending'),
  upcoming(AppConstants.historyListEnumAccepted, 'Upcoming'),
  started(AppConstants.historyListEnumStarted, 'Started'),
  complete(AppConstants.historyListEnumComplete, 'Complete'),
  cancelled(AppConstants.historyListEnumCancelled, 'Cancelled');

  final String stringValue;
  final String stringValueForView;
  const RideHistoryStatusEnum(this.stringValue, this.stringValueForView);

  static RideHistoryStatusEnum toEnumValue(String value) {
    final Map<String, RideHistoryStatusEnum> stringToEnumMap = {
      RideHistoryStatusEnum.pending.stringValue: RideHistoryStatusEnum.pending,
      RideHistoryStatusEnum.upcoming.stringValue:
          RideHistoryStatusEnum.upcoming,
      RideHistoryStatusEnum.started.stringValue: RideHistoryStatusEnum.started,
      RideHistoryStatusEnum.complete.stringValue:
          RideHistoryStatusEnum.complete,
      RideHistoryStatusEnum.cancelled.stringValue:
          RideHistoryStatusEnum.cancelled,
    };
    return stringToEnumMap[value] ?? RideHistoryStatusEnum.pending;
  }
}

enum ShareRideRequestsStatus {
  offering(AppConstants.shareRideHistoryOffering, 'Offering'),
  findRide(AppConstants.shareRideHistoryOffering, 'Find Ride'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const ShareRideRequestsStatus(this.stringValue, this.stringValueForView);

  static ShareRideRequestsStatus toEnumValue(String value) {
    final Map<String, ShareRideRequestsStatus> stringToEnumMap = {
      ShareRideRequestsStatus.offering.stringValue:
          ShareRideRequestsStatus.offering,
      ShareRideRequestsStatus.findRide.stringValue:
          ShareRideRequestsStatus.findRide,
      ShareRideRequestsStatus.unknown.stringValue:
          ShareRideRequestsStatus.unknown,
    };
    return stringToEnumMap[value] ?? ShareRideRequestsStatus.unknown;
  }
}

enum ShareRideHistoryStatus {
  accepted(AppConstants.rideRequestAccepted, 'Upcoming'),
  started(AppConstants.ridePostAcceptanceStarted, 'Started'),
  completed(AppConstants.ridePostAcceptanceCompleted, 'Completed'),
  cancelled(AppConstants.ridePostAcceptanceCancelled, 'Cancelled'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const ShareRideHistoryStatus(this.stringValue, this.stringValueForView);

  static ShareRideHistoryStatus toEnumValue(String value) {
    final Map<String, ShareRideHistoryStatus> stringToEnumMap = {
      ShareRideHistoryStatus.accepted.stringValue:
          ShareRideHistoryStatus.accepted,
      ShareRideHistoryStatus.started.stringValue:
          ShareRideHistoryStatus.started,
      ShareRideHistoryStatus.completed.stringValue:
          ShareRideHistoryStatus.completed,
      ShareRideHistoryStatus.cancelled.stringValue:
          ShareRideHistoryStatus.cancelled,
      ShareRideHistoryStatus.unknown.stringValue:
          ShareRideHistoryStatus.unknown,
    };
    return stringToEnumMap[value] ?? ShareRideHistoryStatus.unknown;
  }
}

enum ShareRideActions {
  myRequest(AppConstants.shareRideActionMyRequest, 'Find Ride'),
  myOffer(AppConstants.shareRideActionMyOffer, 'Offer Ride'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const ShareRideActions(this.stringValue, this.stringValueForView);

  static ShareRideActions toEnumValue(String value) {
    final Map<String, ShareRideActions> stringToEnumMap = {
      ShareRideActions.myRequest.stringValue: ShareRideActions.myRequest,
      ShareRideActions.myOffer.stringValue: ShareRideActions.myOffer,
      ShareRideActions.unknown.stringValue: ShareRideActions.unknown
    };
    return stringToEnumMap[value] ?? ShareRideActions.unknown;
  }
}

enum RentCarStatusStatus {
  hourly(AppConstants.rentCarStatusHourly, 'Hourly'),
  weekly(AppConstants.rentCarStatusWeekly, 'Weekly'),
  monthly(AppConstants.rentCarStatusMonthly, 'Monthly');

  final String stringValue;
  final String stringValueForView;
  const RentCarStatusStatus(this.stringValue, this.stringValueForView);

  static RentCarStatusStatus toEnumValue(String value) {
    final Map<String, RentCarStatusStatus> stringToEnumMap = {
      RentCarStatusStatus.hourly.stringValue: RentCarStatusStatus.hourly,
      RentCarStatusStatus.weekly.stringValue: RentCarStatusStatus.weekly,
      RentCarStatusStatus.monthly.stringValue: RentCarStatusStatus.monthly,
    };
    return stringToEnumMap[value] ?? RentCarStatusStatus.hourly;
  }
}

enum ShareRideAllStatus {
  active(AppConstants.shareRideAllStatusActive, 'Active'),
  accepted(AppConstants.shareRideAllStatusAccepted, 'Accepted'),
  reject(AppConstants.shareRideAllStatusRejected, 'Rejected'),
  pending(AppConstants.shareRideAllStatusPending, 'Pending'),
  started(AppConstants.shareRideAllStatusStarted, 'Started'),
  completed(AppConstants.shareRideAllStatusCompleted, 'Completed'),
  cancelled(AppConstants.shareRideAllStatusCancelled, 'Cancelled'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;

  const ShareRideAllStatus(this.stringValue, this.stringValueForView);

  static ShareRideAllStatus toEnumValue(String value) {
    final Map<String, ShareRideAllStatus> stringToEnumMap = {
      ShareRideAllStatus.active.stringValue: ShareRideAllStatus.active,
      ShareRideAllStatus.accepted.stringValue: ShareRideAllStatus.accepted,
      ShareRideAllStatus.reject.stringValue: ShareRideAllStatus.reject,
      ShareRideAllStatus.pending.stringValue: ShareRideAllStatus.pending,
      ShareRideAllStatus.started.stringValue: ShareRideAllStatus.started,
      ShareRideAllStatus.completed.stringValue: ShareRideAllStatus.completed,
      ShareRideAllStatus.cancelled.stringValue: ShareRideAllStatus.cancelled,
    };
    return stringToEnumMap[value] ?? ShareRideAllStatus.unknown;
  }
}

enum PaymentHistoryStatus {
  card(AppConstants.cardStatus, 'Card'),
  bank(AppConstants.bankStatus, 'Bank'),
  paypal(AppConstants.paypalStatus, 'Paypal'),

  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const PaymentHistoryStatus(this.stringValue, this.stringValueForView);

  static PaymentHistoryStatus toEnumValue(String value) {
    final Map<String, PaymentHistoryStatus> stringToEnumMap = {
      PaymentHistoryStatus.card.stringValue: PaymentHistoryStatus.card,
      PaymentHistoryStatus.bank.stringValue: PaymentHistoryStatus.bank,
      PaymentHistoryStatus.paypal.stringValue: PaymentHistoryStatus.paypal,
      PaymentHistoryStatus.unknown.stringValue: PaymentHistoryStatus.unknown
    };
    return stringToEnumMap[value] ?? PaymentHistoryStatus.unknown;
  }
}
