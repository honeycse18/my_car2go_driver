// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:car2godriver/models/api_responses/trip_permit_list_data.dart';

class TripPermitPaymentSummeryScreenParameter {
  final String subscriptionID;
  final TripPermitPricingModel pricingModel;
  final bool isRenew;
  final bool isFromMyTripPermitDetailsScreen;
  TripPermitPaymentSummeryScreenParameter({
    required this.subscriptionID,
    required this.pricingModel,
    this.isRenew = false,
    this.isFromMyTripPermitDetailsScreen = false,
  });
}
