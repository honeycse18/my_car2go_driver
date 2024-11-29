import 'package:car2godriver/models/enums/api/api_request_content_type.dart';
import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:get/get.dart';

// class APIClient extends GetConnect {
class APIClient {
  static APIClient? _instance;
  GetHttpClient _appAPIClient = GetHttpClient();
  GetHttpClient _updatedAppAPIClient = GetHttpClient();
  GetHttpClient _appGoogleMapAPIClient = GetHttpClient();

  APIClient._() {
    _appAPIClient = GetHttpClient(
      timeout: const Duration(minutes: 1),
      baseUrl: AppConstants.appBaseURL,
    );
    _updatedAppAPIClient = GetHttpClient(
      timeout: const Duration(minutes: 1),
      baseUrl: '${AppConstants.appBaseURL}/api/${AppConstants.apiVersionCode}',
    );
    _appGoogleMapAPIClient = GetHttpClient(
      timeout: const Duration(seconds: 40),
      baseUrl: AppConstants.googleMapBaseURL,
    );
  }

  static APIClient get instance => _instance ??= APIClient._();

  GetHttpClient get apiClient => _updatedAppAPIClient;
  GetHttpClient get googleMapsAPIClient => _appGoogleMapAPIClient;
  Future<Response<dynamic>> requestGetMapMethod({
    required String url,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
  }) async =>
      await googleMapsAPIClient.get(url,
          query: queries,
          contentType: AppConstants.apiContentTypeFormURLEncoded,
          headers: headers);

  Future<Response<dynamic>> requestGetMethodAsURLEncoded({
    required String url,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
  }) async =>
      await apiClient.get(url,
          query: queries,
          // contentType: AppConstants.apiContentTypeFormURLEncoded,
          contentType: APIRequestContentType.urlEncoded.stringValue,
          headers: headers);

  Future<Response<dynamic>> requestPostMethodAsURLEncoded({
    required String url,
    Map<String, dynamic>? queries,
    required dynamic requestBody,
    Map<String, String>? headers,
    // String? contentType,
  }) async =>
      await apiClient.post(url,
          query: queries,
          body: requestBody,
          // contentType: contentType ?? AppConstants.apiContentTypeFormURLEncoded,
          contentType: APIRequestContentType.urlEncoded.stringValue,
          headers: headers);
  Future<Response<dynamic>> requestPatchMethodAsURLEncoded({
    required String url,
    Map<String, dynamic>? queries,
    required dynamic requestBody,
    Map<String, String>? headers,
    // String? contentType,
  }) async =>
      await apiClient.patch(url,
          query: queries,
          body: requestBody,
          // contentType: contentType ?? AppConstants.apiContentTypeFormURLEncoded,
          contentType: APIRequestContentType.urlEncoded.stringValue,
          headers: headers);
  Future<Response<dynamic>> requestDeleteMethodAsURLEncoded({
    required String url,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
    // String? contentType,
  }) async =>
      await apiClient.delete(url,
          query: queries,
          // contentType: contentType ?? AppConstants.apiContentTypeFormURLEncoded,
          contentType: APIRequestContentType.urlEncoded.stringValue,
          headers: headers);

  Future<Response<dynamic>> requestGetMethodAsJSONEncoded({
    required String url,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
  }) async =>
      await apiClient.get(url,
          query: queries,
          // contentType: AppConstants.apiContentTypeJSON,
          contentType: APIRequestContentType.json.stringValue,
          headers: headers);

  Future<Response<dynamic>> requestPostMethodAsJSONEncoded({
    required String url,
    Map<String, dynamic>? queries,
    required dynamic requestBody,
    Map<String, String>? headers,
    // String? contentType,
  }) async =>
      await apiClient.post(url,
          query: queries,
          body: requestBody,
          // contentType: contentType ?? AppConstants.apiContentTypeJSON,
          contentType: APIRequestContentType.json.stringValue,
          headers: headers);

  Future<Response<dynamic>> requestPatchMethodAsJSONEncoded({
    required String url,
    Map<String, dynamic>? queries,
    required dynamic requestBody,
    Map<String, String>? headers,
    // String? contentType,
  }) async =>
      await apiClient.patch(url,
          query: queries,
          body: requestBody,
          // contentType: contentType ?? AppConstants.apiContentTypeJSON,
          contentType: APIRequestContentType.json.stringValue,
          headers: headers);
  Future<Response<dynamic>> requestDeleteMethodAsJSONEncoded({
    required String url,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
    // String? contentType,
  }) async =>
      await apiClient.delete(url,
          query: queries,
          // contentType: contentType ?? AppConstants.apiContentTypeJSON,
          contentType: APIRequestContentType.json.stringValue,
          headers: headers);

  Future<Response<dynamic>> requestPostMethodAsFormData({
    required String url,
    Map<String, dynamic>? queries,
    required FormData requestBody,
    Map<String, String>? headers,
  }) async =>
      await apiClient.post(url,
          query: queries,
          body: requestBody,
          contentType: APIRequestContentType.formData.stringValue,
          headers: headers);

  Future<Response<dynamic>> requestPatchMethodAsFormData({
    required String url,
    Map<String, dynamic>? queries,
    required FormData requestBody,
    Map<String, String>? headers,
  }) async =>
      await apiClient.patch(url,
          query: queries,
          body: requestBody,
          contentType: APIRequestContentType.formData.stringValue,
          headers: headers);

  GetHttpClient getAPIClient() => _appAPIClient;
}
