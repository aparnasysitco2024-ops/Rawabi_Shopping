import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/storage_manager.dart';

import '../model/response/signupResponse.dart';
import '../screen/verification_code_screen.dart';
import '../utils/app_utils.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class SignUpController extends GetxController {
  var loading = false.obs;
  var nameController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();

  Future<void> signupApi() async {
    try {
      CommonUtils.showLoader();
      var requestBody = {
        "name": nameController.text,
        "phone": mobileController.text,
        "email": emailController.text,
      };

      var response = await BaseClient().post(signup, requestBody);
      CommonUtils.hideLoader();
      if (response != null) {
        var responseData =
            SignupResponse.fromJson(json.decode(response.toString()));

        if (responseData.code == "300") {
          StorageManager.saveData(StorageManager.keyUserName, nameController.text);
          StorageManager.saveData(StorageManager.keyUserEmail, emailController.text);
          StorageManager.saveData(StorageManager.keyUserMobile, mobileController.text);
          StorageManager.saveData(StorageManager.keyUserID, responseData.id);
          AppUtils.navigateToPageReplace(const VerificationCode());

        } else {
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      CommonUtils.hideLoader();
      CommonUtils.showErrorDialog(error.toString());
    }
    // loading.value = false;
  }
}
