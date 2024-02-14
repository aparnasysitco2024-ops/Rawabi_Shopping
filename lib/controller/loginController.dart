import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rawabi/model/baseResponse.dart';

import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

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
            BaseResponse.fromJson(json.decode(response.toString()));

        if (responseData.code == "200") {
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
