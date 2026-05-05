import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  var userName = "".obs;

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
          userName.value = myProfile.username!;
          nameController.value.text = userName.value;
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

  Future<void> editProfile() async {
    try {
      loading.value = true;
      await StorageManager.readData(StorageManager.keyDefaultAddressId);
      var request = {
        "name": nameController.value.text,
        "email": emailController.value.text,
        "phone": mobileController.value.text
      };

      var response = await BaseClient().post(profile_update, request);
      loading.value = false;
      if (response != null) {
        var responseData = BaseResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          _showLogoutDialog();
        } else {
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      error.printError();
    }
    loading.value = false;
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: Text("Details Updated Successfully"),
        content: Text("We kindly request you to log out and log back in to continue."),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              _logout();
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }

  void _logout() {
    StorageManager.clearData();
    Get.deleteAll();
    AppUtils.navigateToPageRemoveUntil(SplashScreen());
  }
}
