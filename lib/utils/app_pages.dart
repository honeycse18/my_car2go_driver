import 'package:car2godriver/ui/screens/accept_ride_request_screen.dart';
import 'package:car2godriver/ui/screens/auth/login_password_screen.dart';
import 'package:car2godriver/ui/screens/auth/login_screen.dart';
import 'package:car2godriver/ui/screens/auth/verification_screen.dart';
import 'package:car2godriver/ui/screens/car_pooling/cancel_ride_reason.dart';
import 'package:car2godriver/ui/screens/car_pooling/choose_you_need_screen.dart';
import 'package:car2godriver/ui/screens/car_pooling/pooling_request_details_screen.dart';
import 'package:car2godriver/ui/screens/car_pooling/pooling_request_screen.dart';
import 'package:car2godriver/ui/screens/car_pooling/ride_share_screen.dart';
import 'package:car2godriver/ui/screens/car_pooling/view_request_screen.dart';
import 'package:car2godriver/ui/screens/car_pooling_history_screen.dart';
import 'package:car2godriver/ui/screens/chat_screen.dart';
import 'package:car2godriver/ui/screens/documents_screen.dart';
import 'package:car2godriver/ui/screens/home_navigator/contact_us_.dart';
import 'package:car2godriver/ui/screens/image_zoom.dart';
import 'package:car2godriver/ui/screens/intro_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/about_us_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/add_bank_details.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/change_password_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/delete_page.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/earning_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/faqa_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/help_support.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/languagescreen/language_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/licence_add.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/my_vehicle_information.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/notification_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/privacy_policy_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/profile_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/settings_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/terms_and_condition_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/top_up_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/transaction_history_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/vehicle_details_document_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/vehicle_details_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/wallet_screen.dart';
import 'package:car2godriver/ui/screens/menu_screen_pages/withrow_screen.dart';
import 'package:car2godriver/ui/screens/my_vehicle_details/my_vehicle_details_screen.dart';
import 'package:car2godriver/ui/screens/my_vehicles/my_vehicles_screen.dart';
import 'package:car2godriver/ui/screens/my_vehicles_edit/my_vehicles_edit_screen.dart';
import 'package:car2godriver/ui/screens/payment_method_bank.dart';
import 'package:car2godriver/ui/screens/payment_method_card.dart';
import 'package:car2godriver/ui/screens/payment_method_paypal.dart';
import 'package:car2godriver/ui/screens/payment_method_screen.dart';
import 'package:car2godriver/ui/screens/photo_view.dart';
import 'package:car2godriver/ui/screens/pooling_offerdetails_screen.dart';
import 'package:car2godriver/ui/screens/registration/Signup_screen.dart';
import 'package:car2godriver/ui/screens/registration/create_new_password_screen.dart';
import 'package:car2godriver/ui/screens/schedule_ride_list_screen.dart';
import 'package:car2godriver/ui/screens/select_location_screen.dart';
import 'package:car2godriver/ui/screens/select_payment_methods_screen.dart';
import 'package:car2godriver/ui/screens/splash_screen.dart';
import 'package:car2godriver/ui/screens/start_ride_request_screen.dart';
import 'package:car2godriver/ui/screens/trip_permit/trip_permit_payment_summery.dart';
import 'package:car2godriver/ui/screens/trip_permit/trip_permit_screen.dart';
import 'package:car2godriver/ui/screens/trip_permit_history_screen.dart';
import 'package:car2godriver/ui/screens/trip_permit_transaction_history_details.dart';
import 'package:car2godriver/ui/screens/trip_permit_view_details.dart';
import 'package:car2godriver/ui/screens/unknown_screen.dart';
import 'package:car2godriver/ui/screens/add_vehicle_screen.dart';
import 'package:car2godriver/ui/screens/wallet_withdraw/wallet_withdraw_screen.dart';
import 'package:car2godriver/ui/screens/zoom_drawer_screen.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/ui/widgets/app_view_widget.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage<dynamic>> pages = [
    GetPage(name: AppPageNames.rootScreen, page: () => const SplashScreen()),
    GetPage(
        name: AppPageNames.notificationScreen,
        page: () => const NotificationScreen()),
    GetPage(
        name: AppPageNames.deleteAccount,
        page: () => const DeleteAccountScreen()),
    GetPage(
        name: AppPageNames.inAppWebViewScreen,
        page: () => const InAppWebViewScreen()),
    GetPage(
        name: AppPageNames.helpsupport, page: () => const HelpSupportScreen()),
    GetPage(name: AppPageNames.aboutUs, page: () => const AboutUsScreen()),
    GetPage(
        name: AppPageNames.privacyPolicyScreen,
        page: () => const PrivacyPolicyScreen()),
    GetPage(name: AppPageNames.contactUs, page: () => const ContactUsScreen()),
    GetPage(name: AppPageNames.faqaScreen, page: () => const FaqaScreen()),
    GetPage(
        name: AppPageNames.myVehicleInfo,
        page: () => const MyVehicleInformationScreen()),
    GetPage(
        name: AppPageNames.myVehicleDetails,
        page: () => const MyVehicleDetailsScreen()),
    GetPage(
        name: AppPageNames.myVehicleEdit,
        page: () => const MyVehicleEditScreen()),
    GetPage(name: AppPageNames.introScreen, page: () => const IntroScreen()),
    GetPage(
      name: AppPageNames.vehicleDetailsScreen,
      page: () => const VehicleDetailsScreen(),
    ),
    GetPage(
        name: AppPageNames.termCondition,
        page: () => const TermsConditionScreen()),
    GetPage(
        name: AppPageNames.profileScreen, page: () => const ProfileScreen()),
    GetPage(name: AppPageNames.earningScreen, page: () => EarningScreen()),
    GetPage(name: AppPageNames.loginScreen, page: () => const LoginScreen()),
    GetPage(
        name: AppPageNames.selectLocationScreen,
        page: () => const SelectLocationScreen()),
    GetPage(name: AppPageNames.walletScreen, page: () => const WalletScreen()),
    GetPage(
        name: AppPageNames.walletWithdrawScreen,
        page: () => const WalletWithdrawScreen()),
    GetPage(
        name: AppPageNames.paymentMethodScreen,
        page: () => const PaymentMethodScreen()),
    GetPage(
        name: AppPageNames.paymentMethodPaypalScreen,
        page: () => const PaymentMethodPaypalScreen()),
    GetPage(
        name: AppPageNames.paymentMethodBankScreen,
        page: () => const PaymentMethodBankScreen()),
    GetPage(
        name: AppPageNames.paymentMethodCardScreen,
        page: () => const PaymentMethodCardScreen()),
    GetPage(
      name: AppPageNames.imageZoomScreen,
      page: () => const ImageZoomScreen(),
    ),
    GetPage(
        name: AppPageNames.transactionScreen,
        page: () => const TransactionHistoryScreen()),
    GetPage(
        name: AppPageNames.transactionHistoryScreen,
        page: () => const TransactionHistoryScreen()),
    GetPage(
        name: AppPageNames.withrowScreen, page: () => const WithrowScreen()),
    GetPage(name: AppPageNames.topUpScreen, page: () => const TopUpScreen()),
    GetPage(
        name: AppPageNames.addBankDetailsScreen,
        page: () => const AddBankDetailsScreen()),
    GetPage(
        name: AppPageNames.zoomDrawerScreen,
        page: () => const ZoomDrawerScreen()),
    GetPage(
      name: AppPageNames.vehicleDetailsInformationScreen,
      page: () => const VehicleDetailsInformationScreen(),
    ),
    GetPage(
        name: AppPageNames.settingsScreen, page: () => const SettingsScreen()),
    GetPage(
      name: AppPageNames.photoViewScreen,
      page: () => const PhotoViewScreen(),
    ),
    GetPage(
        name: AppPageNames.languageScreen, page: () => const LanguageScreen()),
    GetPage(
        name: AppPageNames.verificationScreen,
        page: () => const VerificationScreen()),
    GetPage(
        name: AppPageNames.registrationScreen,
        page: () => const RegistrationScreen()),
    GetPage(
        name: AppPageNames.logInPasswordScreen,
        page: () => const LoginPasswordScreen()),
    GetPage(
        name: AppPageNames.createNewPasswordScreen,
        page: () => const CreateNewPasswordScreen()),
    GetPage(
        name: AppPageNames.addVehicleScreen,
        page: () => const AddVehicleScreen()),
    GetPage(
        name: AppPageNames.changePasswordPromptScreen,
        page: () => const ChangePasswordPromptScreen()),
    GetPage(
        name: AppPageNames.tripPermitHistoryScreen,
        page: () => const TripPermitHistoryScreen()),
    GetPage(
        name: AppPageNames.tripPermitTransactionHistoryDetailsScreen,
        page: () => const TripPermitTransactionHistoryDetails()),
    GetPage(
        name: AppPageNames.tripPermitViewDetailsScreen,
        page: () => const TripPermitViewDetails()),
    GetPage(
        name: AppPageNames.completeProfileScreen,
        page: () => const AddLicenseScreen()),
    GetPage(
        name: AppPageNames.tripPermitScreen,
        page: () => const TripPermitScreen()),
    GetPage(
        name: AppPageNames.startRideRequestScreen,
        page: () => const StartRideRequestScreen()),

    //========= car pooling==============
    GetPage(
        name: AppPageNames.rideShareScreen,
        page: () => const RideShareScreen()),
    GetPage(
        name: AppPageNames.chooseYouNeedScreen,
        page: () => const ChooseYouNeedScreen()),
    GetPage(
        name: AppPageNames.acceptedRequestScreen,
        page: () => const AcceptedRideRequestScreen()),
    //============
    GetPage(
        name: AppPageNames.pullingOfferDetailsScreen,
        page: () => const PoolingOfferDetailsScreen()),
    GetPage(
        name: AppPageNames.pullingRequestDetailsScreen,
        page: () => const PoolingRequestDetailsScreen()),
    GetPage(
        name: AppPageNames.selectPaymentMethodsScreen,
        page: () => const SelectPaymentMethodsScreen()),
    GetPage(
        name: AppPageNames.viewRequestsScreen,
        page: () => const ViewRequestsScreen()),
    GetPage(name: AppPageNames.chatScreen, page: () => const ChatScreen()),
    GetPage(
        name: AppPageNames.documentsScreen,
        page: () => const DocumentsScreen()),
    GetPage(
        name: AppPageNames.carPoolingHistroyScreen,
        page: () => const CarPollingHistoryScreen()),
    GetPage(
        name: AppPageNames.pullingRequestOverviewScreen,
        page: () => const PoolingRequestOverviewScreen()),
    GetPage(
        name: AppPageNames.scheduleRideListScreen,
        page: () => const ScheduleRideListScreen()),
    GetPage(
        name: AppPageNames.tripPermitPaymentSummeryScreen,
        page: () => const TripPermitPaymentSummeryScreen()),
    GetPage(
        name: AppPageNames.myVehiclesScreen,
        page: () => const MyVehiclesScreen()),
    GetPage(
        name: AppPageNames.cancelRideReason,
        page: () => const ChooseReasonCancelRide()),
  ];

  static final GetPage<dynamic> unknownScreenPageRoute = GetPage(
    name: AppPageNames.unknownScreen,
    page: () => const UnKnownScreen(),
  );
}
