import 'dart:developer';

import 'package:car2godriver/models/api_responses/chat_message_list_response.dart';
import 'package:car2godriver/models/api_responses/new_driver_socket_response.dart';
import 'package:car2godriver/models/api_responses/new_hire_socket_response.dart';
import 'package:car2godriver/models/api_responses/pulling_new_request_socket_response.dart';
import 'package:car2godriver/models/api_responses/pulling_request_status_socket_response.dart';
import 'package:car2godriver/models/api_responses/ride_details_response.dart';
import 'package:car2godriver/models/api_responses/ride_request_socket_update_status.dart';
import 'package:car2godriver/models/api_responses/ride_share_request_socket_response.dart';
import 'package:car2godriver/utils/constants/app_constants.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  Rx<RideShareRequestSocketResponse> rideShareRequest =
      RideShareRequestSocketResponse.empty().obs;
  Rx<ChatMessageListItem> newMessageData = ChatMessageListItem.empty().obs;
  Rx<ChatMessageListItem> updatedMessageData = ChatMessageListItem.empty().obs;
  Rx<RideDetailsData> rideDetails = RideDetailsData.empty().obs;

  Rx<PullingNewRequestSocketResponse> pullingRequestResponseData =
      PullingNewRequestSocketResponse().obs;
  Rx<PullingRequestStatusSocketResponse> pullingRequestStatusResponseData =
      PullingRequestStatusSocketResponse().obs;
  Rx<HireSocketResponse> newHireSocketResponseData =
      HireSocketResponse.empty().obs;
  Rx<HireSocketResponse> hireUpdateSocketResponseData =
      HireSocketResponse.empty().obs;

  Rx<NewDriverSocketResponse> newDriverSocketData =
      NewDriverSocketResponse.empty().obs;

  /*<-----------Socket initialize ----------->*/
  IO.Socket socket = IO.io(
      AppConstants.appBaseURL,
      IO.OptionBuilder()
          // .setAuth(Helper.getAuthHeaderMap())
          .setAuth(<String, String>{
        'token': Helper.getUserToken()
      }).setTransports(['websocket']) // for Flutter or Dart VM
          .build());

  /*<-----------Get socket response for ride request status ----------->*/
  dynamic onNewRideRequest(dynamic data) {
    log('data socket');
    final RideShareRequestSocketResponse mapData =
        RideShareRequestSocketResponse.getAPIResponseObjectSafeValue(data);
    rideShareRequest.value = mapData;
    update();
  }

  /*<-----------Get socket response for ride request status update ----------->*/
  dynamic onRideRequestUpdate(dynamic data) {
    log('request is updated');
    RideRequestUpdateSocketResponse? response =
        RideRequestUpdateSocketResponse.fromJson(data);
    log(response.toJson().toString());
    if (response.status == 'rejected') {
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .requestHasBeenCancelledByUserTranskey.toCurrentLanguage);
    }
  }

  dynamic onRideUpdate(dynamic data) {
    log('ride is updated');
    RideDetailsData? response = RideDetailsData.fromJson(data);
    if (response.status == 'cancelled') {
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
      AppDialogs.showErrorDialog(
          messageText:
              '${AppLanguageTranslation.rideHasBeenCancelledReasonTranskey.toCurrentLanguage} ${response.cancelReason}');
    }
  }

  /*<-----------Get socket response for new messages ----------->*/
  dynamic onNewMessages(dynamic data) {
    log(data.toString());
    final ChatMessageListItem mapData =
        ChatMessageListItem.getAPIResponseObjectSafeValue(data);
    newMessageData.value = mapData;
    update();
  }

/*<-----------Get socket response for update messages ----------->*/
  dynamic onUpdateMessages(dynamic data) {
    log(data.toString());
    final ChatMessageListItem mapData =
        ChatMessageListItem.getAPIResponseObjectSafeValue(data);
    updatedMessageData.value = mapData;
    update();
  }

  /*<-----------Get socket response for new pooling request ----------->*/
  dynamic onNewPullingRequest(dynamic data) {
    log(data.toString());
    final PullingNewRequestSocketResponse mapData =
        PullingNewRequestSocketResponse.getAPIResponseObjectSafeValue(data);
    pullingRequestResponseData.value = mapData;
    update();
  }

  /*<-----------Get socket response for new pooling request status update ----------->*/
  dynamic onPullingRequestStatusUpdate(dynamic data) {
    log(data.toString());
    final PullingRequestStatusSocketResponse mapData =
        PullingRequestStatusSocketResponse.getAPIResponseObjectSafeValue(data);
    pullingRequestStatusResponseData.value = mapData;
    update();
  }

  /*<-----------Get socket response for new hire ----------->*/
  dynamic onNewHireTrigger(dynamic data) {
    log(data.toString());
    final HireSocketResponse mapData =
        HireSocketResponse.getAPIResponseObjectSafeValue(data);
    newHireSocketResponseData.value = mapData;
    update();
  }

  /*<-----------Get socket response for hire update ----------->*/
  dynamic onHireUpdateTrigger(dynamic data) {
    log(data.toString());
    final HireSocketResponse mapData =
        HireSocketResponse.getAPIResponseObjectSafeValue(data);
    hireUpdateSocketResponseData.value = mapData;
    update();
  }

  /*<-----------Get socket response for new driver request ----------->*/
  dynamic onNewDriverRequest(dynamic data) {
    log(data.toString());
    final NewDriverSocketResponse mapData =
        NewDriverSocketResponse.getAPIResponseObjectSafeValue(data);
    newDriverSocketData.value = mapData;
    update;
  }

  void initSocket() {
    IO.Socket socket = IO.io(
        AppConstants.appBaseURL,
        IO.OptionBuilder()
            // .setAuth(Helper.getAuthHeaderMap())
            .setAuth(<String, String>{
          'token': Helper.getUserToken()
        }).setTransports(['websocket']) // for Flutter or Dart VM
            .build());
    if (socket.connected == false) {
      socket = socket.connect();
    }
    socket.on('new_ride', onNewRideRequest);
    socket.on('ride_request_status', onRideRequestUpdate);
    socket.on('ride_update', onRideUpdate);
    socket.on('new_message', onNewMessages);
    socket.on('update_message', onUpdateMessages);
    socket.on('new_admin_message', onNewMessages);
    socket.on('update_admin_message', onUpdateMessages);
    socket.on('pulling_request', onNewPullingRequest);
    socket.on('pulling_request_status', onPullingRequestStatusUpdate);
    socket.on('new_hire', onNewHireTrigger);
    socket.on('hire_update', onHireUpdateTrigger);
    socket.on('new_driver', onNewDriverRequest);
    socket.onConnect((data) {
      log('data');
      // socket.emit('load_message', <String, dynamic>{'user': chatUser.id});
    });
    /* socket.onConnect((_) {
      print('Connection established');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err)); */
    socket.onConnectError((data) {
      log('data'.toString());
    });
    socket.onConnecting((data) {
      log('data'.toString());
    });
    socket.onConnectTimeout((data) {
      log('data');
    });
    socket.onReconnectAttempt((data) {
      log('data');
    });
    socket.onReconnect((data) {
      log('data');
    });
    socket.onReconnectFailed((data) {
      log('data');
    });
    socket.onReconnectError((data) {
      log('data');
    });
    socket.onError((data) {
      log('data');
    });
    socket.onDisconnect((data) {
      log('data');
    });
    socket.onPing((data) {
      log('data');
    });
    socket.onPong((data) {
      log('data');
    });
  }

  void disposeSocket() {
    if (socket.connected) {
      socket.disconnect();
    }
    socket.dispose();
    super.onClose();
  }

/* <---- Initial state ----> */
  @override
  void onInit() {
    if (!socket.connected) {
      // initSocket();
    }
    super.onInit();
  }

  @override
  void onClose() {
    // socket.disconnect();
    // socket.dispose();
    disposeSocket();
    super.onClose();
  }
}
