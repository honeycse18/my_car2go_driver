import 'package:car2godriver/models/api_responses/user_details_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocumentsScreenController extends GetxController {
  UserDetailsData userDetails = UserDetailsData.empty();
  final GlobalKey<FormState> documentFormKey = GlobalKey<FormState>();

  TextEditingController licenseNumberEditingController =
      TextEditingController();
  getUserDetails() {
    // userDetails = Helper.getUser() as UserDetailsData; // TODO: uncomment this line once ready to fix this page
    update();
  }

  @override
  void onInit() {
    getUserDetails();
    super.onInit();
  }
}
