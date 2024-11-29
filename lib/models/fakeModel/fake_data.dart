// import 'fake_models/bid_category_model.dart';

import 'package:car2godriver/models/fakeModel/intro_content_model.dart';
import 'package:car2godriver/models/payment_option_model.dart';

class FakeData {
  // Intro screens
  static List<IntroContent> introContents = [
    IntroContent(
        localSVGImageLocation: 'assets/images/intro1.png',
        slogan: 'Anywhere you are',
        content:
            'Whether you\'re in the heart of the city or off the beaten path Car2go brings the seamless travel to your fingertips.'),
    IntroContent(
        localSVGImageLocation: 'assets/images/intro2.png',
        slogan: 'At anytime',
        content:
            'Whether it\'s the crack of dawn or the depths of the night, our app is your 24/7 gateway to effortless transportation'),
    IntroContent(
        localSVGImageLocation: 'assets/images/intro3.png',
        slogan: 'Book your car',
        content:
            'Just a few taps, and your car is on its way. Seamlessly designed car2go empowers you to secure your ride with ease and efficiency'),
  ];
  static var paymentOptionList = <SelectPaymentOptionModel>[
    SelectPaymentOptionModel(
        paymentImage:
            'https://icons.iconarchive.com/icons/flat-icons.com/flat/512/Wallet-icon.png',
        value: 'wallet',
        viewAbleName: 'Wallet'),
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/8808/8808875.png',
        value: 'cash',
        viewAbleName: 'Cash'),
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/174/174861.png',
        value: 'paypal',
        viewAbleName: 'PayPal'),
  ];
  static var topupOptionList = <SelectPaymentOptionModel>[
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/174/174861.png',
        value: 'paypal',
        viewAbleName: 'PayPal'),
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/174/174861.png',
        value: 'stripe',
        viewAbleName: 'Stripe'),
  ];
  static var tripPaymentOptionList = <SelectPaymentOptionModel>[
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/5968/5968382.png',
        value: 'stripe',
        viewAbleName: 'Stripe'),
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/174/174861.png',
        value: 'paypal',
        viewAbleName: 'PayPal'),
  ];

  static var cancelRideReason = <FakeCancelRideReason>[
    FakeCancelRideReason(reasonName: 'Waiting for a long time '),
    FakeCancelRideReason(reasonName: 'Ride isn’t here '),
    FakeCancelRideReason(reasonName: 'Wrong address shown'),
    FakeCancelRideReason(reasonName: 'Don’t charge rider'),
    FakeCancelRideReason(reasonName: 'Other'),
  ];
}
