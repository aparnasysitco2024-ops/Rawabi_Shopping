import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/signupScreen.dart';
import 'package:rawabi/screen/verification_code_screen.dart';
import 'package:rawabi/utils/app_utils.dart';

import '../model/response/loginResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';
import '../utils/http_client/base_controller.dart';
import '../utils/storage_manager.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>(debugLabel: 'formKey');
  var loading = false.obs;
  var mobileController = TextEditingController();

  Future<void> checkUser() async {
    try {
      CommonUtils.showLoader();
      var requestBody = {
        "phone": mobileController.text,
      };

      var response = await BaseClient().post(check_user, requestBody);
      CommonUtils.hideLoader();
      if (response != null) {
        var responseData =
        LoginResponse.fromJson(json.decode(response.toString()));

        if (responseData.code == "200") {
          StorageManager.saveData(StorageManager.keyUserMobile, mobileController.text);
          StorageManager.saveData(StorageManager.keyUserID, responseData.userid);
          AppUtils.navigateToPageReplace(const VerificationCode());
        } else if (responseData.code == "404") {
          AppUtils.navigateToPageReplace(
              SignupScreen());
        } else {
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      CommonUtils.hideLoader();
      BaseController().handleError(error);
      // CommonUtils.showErrorDialog(error.toString());
    }
    // loading.value = false;
  }
}
