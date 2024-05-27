import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rawabi/model/response/baseResponse.dart';
import 'package:rawabi/utils/storage_manager.dart';

import '../model/response/myProfileResponse.dart';
import '../screen/splashScreen.dart';
import '../utils/app_utils.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  MyProfile myProfile = MyProfile();
  var nameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var mobileController = TextEditingController().obs;

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> getMyProfile() async {
    try {
      loading.value = true;
      var response = await BaseClient().get(myProfileUrl);
      loading.value = false;
      if (response != null) {
        var responseData =
            MyProfileResponse.fromJson(json.decode(response.toString()));

        if (responseData.code == "200") {
          myProfile = responseData.res!;
          nameController.value.text = myProfile.username!;
          emailController.value.text = myProfile.email!;
          mobileController.value.text = myProfile.phone!;
        } else {
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      error.printError();
      // CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
  }

  Future<void> deleteAccount() async {
    try {
      loading.value = true;
      var response = await BaseClient().get(deleteAccountUrl);
      loading.value = false;
      if (response != null) {
        var responseData =
            BaseResponse.fromJson(json.decode(response.toString()));

        if (responseData.code == "200") {
          StorageManager.clearData();
          Get.deleteAll();
          AppUtils.navigateToPageRemoveUntil(SplashScreen());
        } else {
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      error.printError();
      // CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
  }
}
