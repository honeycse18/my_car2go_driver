import 'dart:async';
import 'dart:developer';

import 'package:car2godriver/controller/socket_controller.dart';
import 'package:car2godriver/models/api_responses/carpolling/pulling_offer_details_response.dart';
import 'package:car2godriver/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:car2godriver/models/api_responses/pulling_new_request_socket_response.dart';

import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/api_helper.dart';
import 'package:car2godriver/utils/helpers/api_repo.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:get/get.dart';

class ViewRequestsScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  String test = 'View Requests Screen Controller is connected!';
  PullingNewRequestSocketResponse newRequestOfferId =
      PullingNewRequestSocketResponse();

  String requestId = '';
  String type = 'vehicle';
  PullingOfferDetailsData requestDetails = PullingOfferDetailsData.empty();
  List<PullingOfferDetailsRequest> pendingRequests = [];

  /*<----------- Get request details from API ----------->*/
  Future<void> getRequestDetails() async {
    PullingOfferDetailsResponse? response =
        await APIRepo.getPullingOfferDetails(requestId);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForRideDetailsTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingRequestDetails(response);
  }

  onSuccessRetrievingRequestDetails(PullingOfferDetailsResponse response) {
    requestDetails = response.data;
    pendingRequests = response.data.pending;
    update();
  }

  /*<----------- Accept button tap ----------->*/
  void onAcceptButtonTap(String requestId) {
    log('Accepted');
    acceptTheRequest(requestId);
  }

/*<----------- Reject button tap ----------->*/
  void onRejectButtonTap(String requestId) {
    log('Rejected');
    rejectTheRequest(requestId);
  }

  /*<----------- Accept request from API----------->*/
  Future<void> acceptTheRequest(String requestId) async {
    RawAPIResponse? response = await APIRepo.updateShareRideRequest(
        requestId: requestId, action: 'accepted');
    if (response == null) {
      log('No response for accepting request!');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessAcceptingRequest(response);
  }

  onSuccessAcceptingRequest(RawAPIResponse response) {
    getRequestDetails();
    update();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  /*<----------- Reject request from API----------->*/
  Future<void> rejectTheRequest(String requestId) async {
    RawAPIResponse? response = await APIRepo.updateShareRideRequest(
        requestId: requestId, action: 'reject');
    if (response == null) {
      log('No response for rejecting request!');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRejectingRequest(response);
  }

  onSuccessRejectingRequest(RawAPIResponse response) {
    getRequestDetails();
    update();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  /*<----------- Fetch screen navigation argument----------->*/
  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      requestId = params;
      update();
      if (requestId.isNotEmpty) {
        getRequestDetails();
      }
    }
  }

  /*<-----------Get socket response for new pooling request ----------->*/
  dynamic onNewPullingRequest(dynamic data) async {
    if (data is PullingNewRequestSocketResponse) {
      newRequestOfferId = data;
      update();
      if (newRequestOfferId.offer.isNotEmpty) {
        getRequestDetails();
      }
    }
  }

  StreamSubscription<PullingNewRequestSocketResponse>? listen;
/* <---- Initial state ----> */
  @override
  void onInit() {
    _getScreenParameters();
    SocketController socketController = Get.find<SocketController>();

    listen = socketController.pullingRequestResponseData.listen((p0) {
      onNewPullingRequest(p0);
    });
    super.onInit();
  }

  void popScope() {
    listen?.cancel();
  }

  @override
  void onClose() {
    listen?.cancel();
    super.onClose();
  }
}
