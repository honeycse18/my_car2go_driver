class IntroContent {
  String localSVGImageLocation;
  String slogan;
  String content;
  IntroContent({
    this.localSVGImageLocation = '',
    this.slogan = '',
    this.content = '',
  });
}

class RecentSalesContent {
  String courseName;
  double price;
  RecentSalesContent({
    required this.courseName,
    required this.price,
  });
}

class FakeCancelRideReason {
  String reasonName;
  FakeCancelRideReason({
    this.reasonName = '',
  });
}

class FakeNotificationModel {
  String timeText;
  bool isRead;
  List<FakeNotificationTextModel> texts;
  FakeNotificationModel({
    required this.timeText,
    required this.isRead,
    required this.texts,
  });
}

class FakeNotificationTextModel {
  String text;
  bool isHashText;
  bool isColoredText;
  bool isBoldText;
  FakeNotificationTextModel({
    required this.text,
    this.isHashText = false,
    this.isColoredText = false,
    this.isBoldText = false,
  });
}

class FakeRentHistoryList {
  String name;
  String driverImage;
  String map;
  String pickLocation;
  String dropLocation;
  double amount;
  double review;
  String distance;
  FakeRentHistoryList({
    this.distance = '',
    this.driverImage = '',
    this.map = '',
    this.dropLocation = '',
    this.name = '',
    this.pickLocation = '',
    this.amount = 0,
    this.review = 0,
  });
}
