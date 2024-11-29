import 'dart:convert';

import 'package:car2godriver/models/api_responses/core_api_responses/api_list_response.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/api_response.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/payment_api_response.dart';
import 'package:car2godriver/models/api_responses/country_list_response.dart';
import 'package:car2godriver/models/api_responses/faq_response_updated.dart';
import 'package:car2godriver/models/api_responses/driver_vehicle_dynamic_fields.dart';
import 'package:car2godriver/models/api_responses/find_account_response_updated.dart';
import 'package:car2godriver/models/api_responses/forget_password_response.dart';
import 'package:car2godriver/models/api_responses/forgot_password_verify_otp.dart';
import 'package:car2godriver/models/api_responses/get_withdraw_saved_methods.dart';
import 'package:car2godriver/models/api_responses/get_withdraw_saved_methods_details.dart';
import 'package:car2godriver/models/api_responses/multiple_image_upload_response.dart';
import 'package:car2godriver/models/api_responses/my_trip_permit_details.dart';
import 'package:car2godriver/models/api_responses/my_vehicle_details.dart';
import 'package:car2godriver/models/api_responses/otp_verification_response.dart';
import 'package:car2godriver/models/api_responses/about_us_response.dart';
import 'package:car2godriver/models/api_responses/car_categories_response.dart';
import 'package:car2godriver/models/api_responses/carpolling/all_categories_response.dart';
import 'package:car2godriver/models/api_responses/carpolling/nearest_pulling_requests_response.dart';
import 'package:car2godriver/models/api_responses/carpolling/post_pulling_request_response.dart';
import 'package:car2godriver/models/api_responses/carpolling/pulling_offer_details_response.dart';
import 'package:car2godriver/models/api_responses/chat_message_list_response.dart';
import 'package:car2godriver/models/api_responses/chat_message_list_sender_response.dart';
import 'package:car2godriver/models/api_responses/contact_us_response.dart';
import 'package:car2godriver/models/api_responses/dashboard_api_response.dart';
import 'package:car2godriver/models/api_responses/dashboard_police_response.dart';
import 'package:car2godriver/models/api_responses/earnings_response.dart';
import 'package:car2godriver/models/api_responses/faq_response.dart';
import 'package:car2godriver/models/api_responses/get_user_data_response.dart';
import 'package:car2godriver/models/api_responses/get_wallet_details_response.dart';
import 'package:car2godriver/models/api_responses/google_map_poly_lines_response.dart';
import 'package:car2godriver/models/api_responses/language_translations_response.dart';
import 'package:car2godriver/models/api_responses/languages_response.dart';
import 'package:car2godriver/models/api_responses/login_response.dart';
import 'package:car2godriver/models/api_responses/nearest_cars_list_response.dart';
import 'package:car2godriver/models/api_responses/notification_list_response.dart';
import 'package:car2godriver/models/api_responses/otp_request_response.dart';
import 'package:car2godriver/models/api_responses/package_list_response.dart';
import 'package:car2godriver/models/api_responses/profile_details.dart';
import 'package:car2godriver/models/api_responses/pulling_request_details_response.dart';
import 'package:car2godriver/models/api_responses/registration_response.dart';
import 'package:car2godriver/models/api_responses/request_otp.dart';
import 'package:car2godriver/models/api_responses/ride_details_response.dart';
import 'package:car2godriver/models/api_responses/ride_history_response.dart';
import 'package:car2godriver/models/api_responses/ride_request_response.dart';
import 'package:car2godriver/models/api_responses/send_user_profile_update_otp_response.dart';
import 'package:car2godriver/models/api_responses/share_ride_history_response.dart';
import 'package:car2godriver/models/api_responses/single_image_upload_response.dart';
import 'package:car2godriver/models/api_responses/site_settings.dart';
import 'package:car2godriver/models/api_responses/social_google_login_response.dart';
import 'package:car2godriver/models/api_responses/support_text_response.dart';
import 'package:car2godriver/models/api_responses/my_vehicles_data.dart';
import 'package:car2godriver/models/api_responses/t/register/send_otp.dart';
import 'package:car2godriver/models/api_responses/top_up_response.dart';
import 'package:car2godriver/models/api_responses/trip_permit_details.dart';
import 'package:car2godriver/models/api_responses/trip_permit_list_data.dart';
import 'package:car2godriver/models/api_responses/user_details_response.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/vehicle_brand_info.dart';
import 'package:car2godriver/models/api_responses/vehicle_details_response.dart';
import 'package:car2godriver/models/api_responses/vehicle_elements_data_response.dart';
import 'package:car2godriver/models/api_responses/vehicle_model_info.dart';
import 'package:car2godriver/models/api_responses/vehicle_online_offline_response.dart';
import 'package:car2godriver/models/api_responses/vehicle_types_info.dart';
import 'package:car2godriver/models/api_responses/wallet_details.dart';
import 'package:car2godriver/models/api_responses/wallet_history_response.dart';
import 'package:car2godriver/models/api_responses/wallet_withdraw_response.dart';
import 'package:car2godriver/models/enums/api/api_request_content_type.dart';
import 'package:car2godriver/models/enums/api/api_rest_method.dart';
import 'package:car2godriver/utils/api_client.dart';
import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:get/get_connect/http/src/http.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class APIRepo {
  /*<--------Get routes polylines from google API------->*/
  static Future<GoogleMapPolyLinesResponse?> getRoutesPolyLines(
      double originLatitude,
      double originLongitude,
      double targetLatitude,
      double targetLongitude) async {
    try {
      await APIHelper.preAPICallCheck();
      // final GetHttpClient apiHttpClient = APIClient.instance.googleMapsAPIClient();
      final Map<String, dynamic> queries = {
        'origin': '$originLatitude,$originLongitude',
        'destination': '$targetLatitude,$targetLongitude',
        'sensor': 'false',
        'key': AppConstants.googleAPIKey,
      };
      final Response response =
          // await apiHttpClient.get('/maps/api/directions/json', query: queries);
          await APIClient.instance.requestGetMapMethod(
              url: '/maps/api/directions/json', queries: queries);
      APIHelper.postAPICallCheck(response);
      final GoogleMapPolyLinesResponse responseModel =
          GoogleMapPolyLinesResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get nearest cars list from API-------->*/
  static Future<NearestCarsListResponse?> getNearestCarsList(
      {double lat = 0,
      double lng = 0,
      double destLat = 0,
      double destLng = 0,
      String? categoryId,
      int? limit}) async {
    try {
      final Map<String, dynamic> queries = {
        "lat": lat.toString(),
        "lng": lng.toString(),
        "destination": '$destLat,$destLng'
      };
      if (categoryId != null) {
        queries["category"] = categoryId;
      }
      if (limit != null) {
        queries['limit'] = limit.toString();
      }
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/ride/nearest',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final NearestCarsListResponse responseModel =
          NearestCarsListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Ride payment -------->*/
  static Future<RawAPIResponse?> onPaymentTap(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/ride/payment',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<GetWithdrawSavedMethodsResponse?> getWithdrawMethod() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response =
          await apiHttpClient.get('/api/withdraw-method/list',
              // query: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final GetWithdrawSavedMethodsResponse responseModel =
          GetWithdrawSavedMethodsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> deleteCard(String id) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        '_id': id,
      };
      final Response response = await APIClient.instance
          .requestDeleteMethodAsJSONEncoded(
              url: '/api/withdraw-method',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> withdrawRequest(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/withdraw',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<GetWithdrawSavedMethodsDetailsResponse?>
      getWithdrawMethodDetails(String id) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        '_id': id,
      };

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('/api/withdraw-method',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final GetWithdrawSavedMethodsDetailsResponse responseModel =
          GetWithdrawSavedMethodsDetailsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateInfo(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPatchMethodAsJSONEncoded(
              url: '/api/withdraw-method',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> addMethodInfo(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/withdraw-method',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Trip Permit payment -------->*/
  static Future<PaymentAPIResponse?> onPackageBuyPaymentTap(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/payment',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final PaymentAPIResponse responseModel =
          PaymentAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Submit review -------->*/
  static Future<RawAPIResponse?> submitReviews(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/review',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Top up wallet -------->*/
  static Future<RawAPIResponse?> topUpWallet(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/wallet/add',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<TopUpResponse>?> topUpWalletUpdated(
      {required Map<String, dynamic> requestBody}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/payment/request',
      body: requestBody,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<TopUpResponse>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: TopUpResponse(),
        dataFromJson: TopUpResponse.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<WalletWithdrawResponse>?> walletWithdraw(
      {required Map<String, dynamic> requestBody}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/withdraw/driver/request',
      body: requestBody,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<WalletWithdrawResponse>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: WalletWithdrawResponse.empty(),
        dataFromJson: WalletWithdrawResponse.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  /*<------- Update share ride request -------->*/
  static Future<RawAPIResponse?> updateShareRideRequest(
      {required String requestId,
      String action = 'accepted',
      String? reason}) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, String> requestBody = {
        '_id': requestId,
        'status': action
      };
      if (reason != null && reason.isNotEmpty) {
        requestBody['cancel_reason'] = reason;
      }
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/pulling/request/status',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  /*<-------Get ride history from API-------->*/
  static Future<RideHistoryResponse?> getRideHistoryList(
      int currentPageNumber, String key) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
        'status': key,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/ride/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RideHistoryResponse responseModel =
          RideHistoryResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<-------Get faq item list from API-------->*/
  static Future<FaqResponse?> getFaqItemList(int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/faq/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final FaqResponse responseModel =
          FaqResponse.getSafeObject(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<-------Get Package item list from API-------->*/
  static Future<PackageListResponse?> getPackageList() async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/package/list', headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final PackageListResponse responseModel =
          PackageListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<-------Get id user details from API-------->*/
  static Future<GetUserDataResponse?> getIdUserDetails(String id) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        '_id': id,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/user/details',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final GetUserDataResponse responseModel =
          GetUserDataResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<-------Get transaction history from API-------->*/
  static Future<WalletTransactionHistoryResponse?> getTransactionHistory(
      int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {'page': '$currentPageNumber'};
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/wallet/history',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final WalletTransactionHistoryResponse responseModel =
          WalletTransactionHistoryResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<PaginatedDataResponse<WalletTransaction>>?>
      getWalletTransactionHistoryUpdated(
          {required Map<String, String> queries}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/wallet/driver-transactions',
      queries: queries,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<PaginatedDataResponse<WalletTransaction>>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: PaginatedDataResponse.empty(),
        dataFromJson: (data) => PaginatedDataResponse.getSafeObject(
          data,
          docFromJson: (item) => WalletTransaction.getSafeObject(item),
        ),
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  /*<-------Get wallet details from API-------->*/
  static Future<GetWalletDetailsResponse?> getWalletDetails() async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/wallet', headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final GetWalletDetailsResponse responseModel =
          GetWalletDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<WalletDetails>?> getWalletDetailsUpdated() async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/wallet/driver-transaction/summary',
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<WalletDetails>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: WalletDetails.empty(),
        dataFromJson: WalletDetails.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  /*<------- Find account from API-------->*/
/*   static Future<FindAccountResponse?> findAccount(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.apiClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          // await apiHttpClient.post('/api/user/find', body: requestBody, contentType: AppConstants.apiContentTypeFormURLEncoded);
          await APIClient.instance.requestPostMethodAsURLEncoded(
        url: '/api/user/find',
        requestBody: requestBody,
      );
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final FindAccountResponse responseModel =
          FindAccountResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }

    //fetchLanguages
  } */

  static Future<APIResponse<FindAccountDataRefactored>?> findAccountUpdated(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/auth/identification/check',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIResponse<FindAccountDataRefactored>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: FindAccountDataRefactored(),
        dataFromJson: FindAccountDataRefactored.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

  /*<-------Get contact us details from API-------->*/
  static Future<ContactUsResponse?> getContactUsDetails() async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'slug': 'contact_us',
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/page',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ContactUsResponse responseModel =
          ContactUsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> postContactUsMessage(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/contact',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Remove vahicle from API-------->*/
  static Future<RawAPIResponse?> removeVehicle(
      {required String vehicleId}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Map<String, String> requestBody = {
        '_id': vehicleId,
      };

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response =
          await APIClient.instance.requestDeleteMethodAsURLEncoded(
        url: '/api/vehicle',
        queries: requestBody,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Payment accept car rent request -------->*/
  static Future<RawAPIResponse?> paymentAcceptCarRentRequest(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/pulling/payment',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get support text from API -------->*/
  static Future<SupportTextResponse?> getSupportText(
      {required String slug}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'slug': slug};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/page',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SupportTextResponse responseModel =
          SupportTextResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get about us reponse from API -------->*/
  static Future<AboutUsResponse?> getAboutUsText() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'slug': 'about_us'};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/page',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final AboutUsResponse responseModel =
          AboutUsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get share ride history from API -------->*/
  static Future<ShareRideHistoryResponse?> getShareRideHistory(
      {int page = 1, String filter = '', String action = ''}) async {
    try {
      await APIHelper.preAPICallCheck();
      Map<String, String> queries = {'page': '$page'};
      if (filter.isNotEmpty) {
        queries['status'] = filter;
      }
      if (action.isNotEmpty) {
        queries['action'] = action;
      }
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/pulling/history',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ShareRideHistoryResponse responseModel =
          ShareRideHistoryResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  /*<------- Complete ride -------->*/
  static Future<RawAPIResponse?> completeRide(String rideId) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> requestBody = {
        '_id': rideId,
        'status': 'completed'
      };
      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/pulling/offer',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get pulling offer details from API -------->*/
  static Future<PullingOfferDetailsResponse?> getPullingOfferDetails(
      String requestId) async {
    try {
      await APIHelper.preAPICallCheck();
      Map<String, String> queries = {'_id': requestId};
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/pulling/offer',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final PullingOfferDetailsResponse responseModel =
          PullingOfferDetailsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  /*<------- request ride from API -------->*/
  static Future<RawAPIResponse?> requestRide(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      String requestBodyJson = jsonEncode(requestBody);
      final Response response =
          await APIClient.instance.requestPostMethodAsJSONEncoded(
        url: '/api/pulling/request',
        requestBody: requestBodyJson,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get all categories from API -------->*/
  static Future<AllCategoriesResponse?> getAllCategories() async {
    try {
      await APIHelper.preAPICallCheck();
      Map<String, String> queries = {'limit': '100'};
      final Response response =
          await APIClient.instance.requestGetMethodAsJSONEncoded(
        url: '/api/category/list',
        queries: queries,
      );
      APIHelper.postAPICallCheck(response);
      final AllCategoriesResponse responseModel =
          AllCategoriesResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  /*<------- Get nearest requests from API -------->*/
  static Future<NearestPullingRequestsResponse?> getNearestRequests(
      Map<String, String> params, int page) async {
    try {
      await APIHelper.preAPICallCheck();
      if (page > 0) {
        params['page'] = '$page';
      }
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/pulling/nearest',
              queries: params,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final NearestPullingRequestsResponse responseModel =
          NearestPullingRequestsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  /*<------- Read all notification -------->*/
  static Future<RawAPIResponse?> readAllNotification(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/notification/read/all',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Create new request -------->*/
  static Future<PostPullingRequestResponse?> createNewRequest(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/pulling/offer',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final PostPullingRequestResponse responseModel =
          PostPullingRequestResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  /*<------- Get pending ride request response from API -------->*/
  static Future<RideRequestResponse?> getPendingRideRequestResponse() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/ride/requests', headers: APIHelper.getAuthHeaderMap());
      /* await apiHttpClient.get('/api/user/',
          headers: token != null
              ? {'Authorization': 'Bearer $token'}
              : APIHelper.getAuthHeaderMap()); */

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RideRequestResponse responseModel =
          RideRequestResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get vehicle details from API -------->*/
  static Future<VehicleDetailsResponse?> getVehicleDetails(
      {required String productId}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': productId};

      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/vehicle',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final VehicleDetailsResponse responseModel =
          VehicleDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get car categories from API -------->*/
  static Future<CarCategoriesResponse?> getCarCategories() async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/vehicle/elements',
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final CarCategoriesResponse responseModel =
          CarCategoriesResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get ride details from API -------->*/
  static Future<RideDetailsResponse?> getRideDetails(String rideId) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        '_id': rideId,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/ride',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RideDetailsResponse responseModel =
          RideDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Read notification -------->*/
  static Future<RawAPIResponse?> readNotification(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/notification/read',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Start ride with submit OTP -------->*/
  static Future<RawAPIResponse?> startRideWithSubmitOtp(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/ride',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<LanguageTranslationsResponse?>
      fetchLanguageTranslations() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
        '/api/language/translations',
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final LanguageTranslationsResponse responseModel =
          LanguageTranslationsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Update user profile from API -------->*/
  static Future<RawAPIResponse?> updateUserProfile(dynamic requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      String contentType = 'multipart/form-data';
      if (requestBody is String) {
        contentType = 'application/json';
      }
      final Response response = await APIClient.instance.apiClient.patch(
          '/api/user/',
          body: requestBody,
          contentType: contentType,
          headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<ProfileDetails>?> updateProfileDetails(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.patchMethod,
      url: '/user/driver/profile-update',
      body: requestBody,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<ProfileDetails>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: ProfileDetails.empty(),
        dataFromJson: ProfileDetails.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  /*<------- Get notification list from API -------->*/
  static Future<NotificationListResponse?> getNotificationList(
      int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/notification/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final NotificationListResponse responseModel =
          NotificationListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get Dashboard emergency data details from API -------->*/
  static Future<DashboardPoliceResponse?>
      getDashBoardEmergencyDataDetails() async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/settings', headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final DashboardPoliceResponse responseModel =
          DashboardPoliceResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get dashboard details from API -------->*/
  static Future<DashboardApiResponse?> getDashBoardDetails(String? type) async {
    try {
      await APIHelper.preAPICallCheck();
      Map<String, String> queries = {'type': '$type'};

      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/user/dashboard',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final DashboardApiResponse responseModel =
          DashboardApiResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Update request -------->*/
  static Future<RawAPIResponse?> updateRequest(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/driver/hire',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- FcmUpdate request -------->*/
  static Future<RawAPIResponse?> fcmUpdate(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/user/',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Update trip status -------->*/
  static Future<RawAPIResponse?> updateTripStatus(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/ride',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Update ride status from API -------->*/
  static Future<RawAPIResponse?> updateRideStatus(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/ride',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Send message -------->*/
  static Future<ChatMessageListSendResponse?> sendMessage(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/message',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ChatMessageListSendResponse responseModel =
          ChatMessageListSendResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get chat message list from API -------->*/
  static Future<ChatMessageListResponse?> getChatMessageList(
      int currentPageNumber, String id) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
        'with': id,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/message/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ChatMessageListResponse responseModel =
          ChatMessageListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Update driver status from API -------->*/
  static Future<RawAPIResponse?> updateDriverStatus(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/ride/driver/status',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  /*<------- Read message -------->*/
  static Future<RawAPIResponse?> readMessage(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/message',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Accept reject ride request -------->*/
  static Future<RawAPIResponse?> acceptRejectRideRequest(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/ride/request/status',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }
  /*<-------- Google Login API ------->*/

  static Future<SocialGoogleLoginResponse?> socialGoogleLoginVerify(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient
          .post('/api/user/verify-google-user', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SocialGoogleLoginResponse responseModel =
          SocialGoogleLoginResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Fetch language -------->*/
  static Future<LanguagesResponse?> fetchLanguages() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
        '/api/languages',
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final LanguagesResponse responseModel =
          LanguagesResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<EarningsResponse?> getEarningHistory(
      String? start, String? end) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {'start': start, 'end': end};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
        '/api/user/earnings',
        query: queries,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final EarningsResponse responseModel =
          EarningsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Get country list from API -------->*/
  static Future<CountryListResponse?> getCountryList() async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/countries', headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final CountryListResponse responseModel =
          CountryListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RegistrationResponse?> registration(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.apiClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          // await apiHttpClient.post( '/api/user/registration', body: requestBody, contentType: AppConstants.apiContentTypeFormURLEncoded);
          await APIClient.instance.requestPostMethodAsURLEncoded(
              url: '/api/user/registration', requestBody: requestBody);
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RegistrationResponse responseModel =
          RegistrationResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<RegistrationDataUpdated>?> registrationUpdated(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/user/register',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIResponse<RegistrationDataUpdated>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: RegistrationDataUpdated(),
        dataFromJson: RegistrationDataUpdated.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

  /*<------- Request OTP -------->*/
  static Future<OtpRequestResponse?> requestOTP(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.apiClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          // await apiHttpClient.post('/api/user/send-otp', body: requestBody, contentType: AppConstants.apiContentTypeFormURLEncoded);
          await APIClient.instance.requestPostMethodAsURLEncoded(
              url: '/api/user/send-otp', requestBody: requestBody);
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final OtpRequestResponse responseModel =
          OtpRequestResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Request OTP Updated-------->*/

  static Future<APIResponse<SendOtp>?> requestOTPUpdated(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/otp/send',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) => APIResponse<SendOtp>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: SendOtp(),
        dataFromJson: SendOtp.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

  static Future<APIResponse<RequestOtp>?> requestForgotPasswordOTPUpdated(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/auth/forget-password/send-otp',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) => APIResponse<RequestOtp>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: RequestOtp(),
        dataFromJson: RequestOtp.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

  /*<------- Create new password -------->*/
  static Future<RawAPIResponse?> createNewPassword(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.apiClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          // await apiHttpClient.post( '/api/user/reset-password', body: requestBody, contentType: AppConstants.apiContentTypeFormURLEncoded);
          await APIClient.instance.requestPostMethodAsURLEncoded(
              url: '/api/user/reset-password', requestBody: requestBody);
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<void>?> createNewPasswordUpdated(
      Map<String, dynamic> requestBody,
      {required String token}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/auth/forget-password/submit',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(token: token),
      parseResponseToModel: (response) => APIResponse<void>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: null,
        dataFromJson: (data) {},
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

  /*<------- Update Password -------->*/
  static Future<RawAPIResponse?> updatePassword(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/user/password',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<APIResponse<ForgetPasswordResponse>?> forgetPasswordUpdated(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/auth/forget-password/send-otp',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIResponse<ForgetPasswordResponse>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: ForgetPasswordResponse(),
        dataFromJson: ForgetPasswordResponse.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

  /*<------- Update vehicle details -------->*/
  static Future<RawAPIResponse?> updateVehicleDetails(
      FormData requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response
          response = /* await APIClient.instance.requestPostMethod(
          url: '/api/vehicle',
          requestBody: requestBody,
          headers: APIHelper.getAuthHeaderMap()); */
          await APIClient.instance.apiClient.patch('/api/vehicle',
              body: requestBody,
              contentType: 'multipart/form-data',
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<------- Vehicle status online -------->*/
  static Future<RawAPIResponse?> vehicleStatusOnline(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/ride/driver/status',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<VehicleOnlineOfflineResponse>?>
      updateVehicleStatusOnlineOffline(
          {Map<String, dynamic>? requestBody}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/vehicle/online-office',
      body: requestBody,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<VehicleOnlineOfflineResponse>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: VehicleOnlineOfflineResponse.empty(),
        dataFromJson: VehicleOnlineOfflineResponse.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  /*<------- Verify OTP -------->*/
  static Future<OtpVerificationResponse?> verifyOTP(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.apiClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          // await apiHttpClient.post('/api/user/verify-otp', body: requestBody, contentType: AppConstants.apiContentTypeFormURLEncoded);
          await APIClient.instance.requestPostMethodAsURLEncoded(
              url: '/api/user/verify-otp', requestBody: requestBody);
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final OtpVerificationResponse responseModel =
          OtpVerificationResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<ForgotPasswordVerifyOTP>?> forgotPasswordVerifyOTP(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/auth/forget-password/verify-otp',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIResponse<ForgotPasswordVerifyOTP>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: ForgotPasswordVerifyOTP(),
        dataFromJson: ForgotPasswordVerifyOTP.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

  static Future<RawAPIResponse?> addVehicle(FormData requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response
          response = /* await APIClient.instance.requestPostMethod(
          url: '/api/vehicle',
          requestBody: requestBody,
          headers: APIHelper.getAuthHeaderMap()); */
          await APIClient.instance.apiClient.post('/api/vehicle',
              body: requestBody,
              contentType: 'multipart/form-data',
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<LoginResponse?> login(Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.apiClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          // await apiHttpClient.post('/api/user/login', body: requestBody, contentType: AppConstants.apiContentTypeFormURLEncoded);
          await APIClient.instance.requestPostMethodAsURLEncoded(
              url: '/api/user/login', requestBody: requestBody);
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final LoginResponse responseModel =
          LoginResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<LoginDataUpdated>?> loginUpdated(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/auth/login',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIResponse<LoginDataUpdated>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: LoginDataUpdated.empty(),
        dataFromJson: LoginDataUpdated.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

  /*<------- Get vehicle category list from API -------->*/
  static Future<VehicleElementsDataResponse?> getVehicleCategoryList() async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/vehicle/elements',
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final VehicleElementsDataResponse responseModel =
          VehicleElementsDataResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIListResponse<VehicleTypeInfo>?> getVehicleTypes() async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/vehicle/type/list',
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIListResponse<VehicleTypeInfo>.getSafeObject(
        unsafeObject: response.body,
        dataFromJson: VehicleTypeInfo.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<UserDetailsResponse?> getUserDetails({String? token}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.apiClient();
      final Response response =
          // await apiHttpClient.get('/api/user/', headers: token != null ? {'Authorization': 'Bearer $token'} : APIHelper.getAuthHeaderMap());
          await APIClient.instance.requestGetMethodAsJSONEncoded(
              url: '/api/user/',
              headers: token != null
                  ? {'Authorization': 'Bearer $token'}
                  : APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final UserDetailsResponse responseModel =
          UserDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<ProfileDetails>?> getProfileUpdated(
      {String? authToken}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/user/profile',
      apiClient: APIClient.instance.apiClient,
      headers: APIHelper.getAuthHeaderMap(token: authToken),
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIResponse<ProfileDetails>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: ProfileDetails.empty(),
        dataFromJson: ProfileDetails.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

  /*<------- Get vehicle list from API -------->*/
  static getVehicleList({required int page, required String key}) {}

  static Future<PullingRequestDetailsResponse?> getPullingRequestDetails(
      String requestId) async {
    try {
      await APIHelper.preAPICallCheck();
      Map<String, String> queries = {'_id': requestId};
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/pulling/request',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final PullingRequestDetailsResponse responseModel =
          PullingRequestDetailsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<APIResponse<PullingRequestDetailsData>?>
      getPullingRequestDetailsRefactored(String requestId) async {
    final response = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/api/pulling/request',
      queries: {'_id': requestId},
      headers: APIHelper.getAuthHeaderMap(),
      apiClient: APIClient.instance.apiClient,
      parseResponseToModel: (response) => APIResponse.getSafeObject(
        unsafeObject: response.body,
        emptyObject: PullingRequestDetailsData.empty(),
        dataFromJson: PullingRequestDetailsData.getAPIResponseObjectSafeValue,
      ),
    );
    final responseModel = response?.responseModel;
    final rawResponse = response?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = true;
    }
    return responseModel;
  }

  static Future<APIListResponse<FaqResponseUpdated>?> getFaqs() async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/faq/list',
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      queries: {'for': 'driver'},
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIListResponse<FaqResponseUpdated>.getSafeObject(
        unsafeObject: response.body,
        dataFromJson: FaqResponseUpdated.getAPIResponseObjectSafeValue,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

  static Future<APIResponse<DriverVehicleDynamicFields>?>
      getDynamicFields() async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/dynamic-field',
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIResponse<DriverVehicleDynamicFields>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: DriverVehicleDynamicFields(),
        dataFromJson: DriverVehicleDynamicFields.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
/*     final rawResponse = apiResponse?.rawResponse;
     if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    } */
    return responseModel;
  }

  static Future<APIResponse<SingleImageUploadData>?> uploadSingleImage(
      FormData requestBody,
      {String? token}) async {
    final apiResponse = await APIHelper.callPostOrPatchAPIMethodFormDataEncoded(
      method: APIRESTMethod.getMethod,
      url: '/file/single-file-upload',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      headers: APIHelper.getAuthHeaderMap(token: token),
      parseResponseToModel: (response) =>
          APIResponse<SingleImageUploadData>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: SingleImageUploadData(),
        dataFromJson: SingleImageUploadData.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<MultipleImageUploadData>?> uploadMultipleImage(
      FormData requestBody,
      {String? token}) async {
    final apiResponse = await APIHelper.callPostOrPatchAPIMethodFormDataEncoded(
      method: APIRESTMethod.getMethod,
      url: '/file/multiple-file-upload',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      headers: APIHelper.getAuthHeaderMap(token: token),
      parseResponseToModel: (response) =>
          APIResponse<MultipleImageUploadData>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: MultipleImageUploadData(),
        dataFromJson: MultipleImageUploadData.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<MyVehiclesData>?> getMyVehicles(
      Map<String, String> queries) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/vehicle/driver/list',
      queries: queries,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<MyVehiclesData>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: MyVehiclesData(),
        dataFromJson: MyVehiclesData.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIListResponse<VehicleBrandInfo>?> getVehicleBrands(
      {required String vehicleTypeID}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/vehicle-attribute/all',
      queries: <String, String>{
        'attribute_type': 'brand',
        'vehicle_type': vehicleTypeID
      },
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIListResponse<VehicleBrandInfo>.getSafeObject(
        unsafeObject: response.body,
        dataFromJson: VehicleBrandInfo.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIListResponse<VehicleModelInfo>?> getVehicleModels(
      {required String vehicleTypeID, required String brandID}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/vehicle-attribute/all',
      queries: <String, String>{
        'attribute_type': 'model',
        'brand': brandID,
        'vehicle_type': vehicleTypeID
      },
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIListResponse<VehicleModelInfo>.getSafeObject(
        unsafeObject: response.body,
        dataFromJson: VehicleModelInfo.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<void>?> createVehicle(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/vehicle/register-with-driver/information',
      body: requestBody,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) => APIResponse<void>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: null,
        dataFromJson: (data) {},
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<void>?> updateVehicle(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.patchMethod,
      url: '/vehicle/update-submitted/information',
      body: requestBody,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) => APIResponse<void>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: null,
        dataFromJson: (data) {},
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<void>?> activeToggleVehicle(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.patchMethod,
      url: '/vehicle/switch/active-inactive',
      body: requestBody,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) => APIResponse<void>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: null,
        dataFromJson: (data) {},
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<MyVehicleDetails>?> getMyVehicleDetails(
      {required Map<String, String> queries}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/vehicle/driver/list',
      queries: queries,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<MyVehicleDetails>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: MyVehicleDetails.empty(),
        dataFromJson: MyVehicleDetails.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<void>?> deleteVehicle(
      Map<String, String> queries) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.deleteMethod,
      url: '/vehicle/delete',
      queries: queries,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) => APIResponse<void>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: null,
        dataFromJson: (data) {},
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<SiteSettings>?> getSiteSettings() async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/settings/site',
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIResponse<SiteSettings>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: SiteSettings(),
        dataFromJson: SiteSettings.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<TripPermitListDetails>?>
      getTripPermitListData() async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/subscription/driver/list',
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<TripPermitListDetails>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: TripPermitListDetails.empty(),
        dataFromJson: TripPermitListDetails.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<TripPermitDetails>?> getTripPermitDetails(
      {required Map<String, String> queries}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/subscription/details',
      apiClient: APIClient.instance.apiClient,
      queries: queries,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<TripPermitDetails>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: TripPermitDetails.empty(),
        dataFromJson: TripPermitDetails.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<void>?> payTripPermit(
      {required Map<String, dynamic> requestBody}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/subscription/order',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) => APIResponse<void>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: null,
        dataFromJson: (data) {},
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<MyTripPermitDetails>?> getMyTripPermitDetails(
      {Map<String, String>? queries}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/subscription/driver/order-list',
      apiClient: APIClient.instance.apiClient,
      queries: queries,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<MyTripPermitDetails>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: MyTripPermitDetails.empty(),
        dataFromJson: MyTripPermitDetails.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<void>?> updateTripPermitSubscriptionAutoRenew(
      {required Map<String, dynamic> requestBody}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.patchMethod,
      url: '/subscription/driver/renew',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) => APIResponse<void>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: null,
        dataFromJson: (data) {},
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<SendUserProfileUpdateOtpResponse>?>
      sendUserProfileOTP({Map<String, dynamic>? requestBody}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/otp/send/user-profile-update',
      body: requestBody,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<SendUserProfileUpdateOtpResponse>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: SendUserProfileUpdateOtpResponse(),
        dataFromJson: SendUserProfileUpdateOtpResponse.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<ProfileDetails>?> veryUserProfileOTP(
      {Map<String, dynamic>? requestBody}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/otp/verify/profile-update',
      body: requestBody,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<ProfileDetails>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: ProfileDetails.empty(),
        dataFromJson: ProfileDetails.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }
}
