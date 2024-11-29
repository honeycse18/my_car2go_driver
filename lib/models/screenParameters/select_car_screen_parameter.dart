import 'package:car2godriver/models/location_model.dart';

class SelectCarScreenParameter {
  LocationModel pickupLocation;
  LocationModel dropLocation;
  bool isScheduleRide;
  SelectCarScreenParameter(
      {required this.pickupLocation,
      required this.dropLocation,
      this.isScheduleRide = false});
}
