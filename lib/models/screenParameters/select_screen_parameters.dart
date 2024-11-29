import 'package:car2godriver/models/location_model.dart';

class SelectLocationScreenParameters {
  String? screenTitle;
  bool? showCurrentLocationButton;
  LocationModel? locationModel;
  SelectLocationScreenParameters(
      {this.screenTitle, this.showCurrentLocationButton, this.locationModel});
}
