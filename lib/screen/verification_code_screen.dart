import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/model/response/baseResponse.dart';
import 'package:rawabi/screen/navigator/bottomNavBar.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/utils/constants.dart';
import 'package:rawabi/widget/commonwidget/reusable_button1.dart';

import '../controller/verification_controller.dart';
import '../utils/commonUtils.dart';
import '../utils/http_client/base_client.dart';
import '../utils/storage_manager.dart';
import '../widget/commonwidget/otp_text_field.dart';
import '../widget/commonwidget/reusable_text.dart';

class VerificationCode extends StatelessWidget {
  const VerificationCode({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController value1 = TextEditingController();
    TextEditingController value2 = TextEditingController();
    TextEditingController value3 = TextEditingController();
    TextEditingController value4 = TextEditingController();

    final verificationController = Get.put(VerificationController());

    Future<void> verify() async {
      CommonUtils.showLoader();

      var requestBody = {
        "otp": value1.text.toString() +
            value2.text.toString() +
            value3.text.toString() +
            value4.text.toString(),
        "pushtoken":
            await StorageManager.readData(StorageManager.keyFirebaseToken)
      };

      try {
        var response = await BaseClient().post(signin, requestBody);
        CommonUtils.hideLoader();
        if (response != null) {
          var responseData =
              BaseResponse.fromJson(json.decode(response.toString()));
          if (responseData.code == "200") {
            AppUtils.navigateToPageRemoveUntil(BottomNavBar());
          } else {
            CommonUtils.showErrorDialog(responseData.message);
          }
        } else {
          CommonUtils.showErrorDialog(response.message);
        }
      } catch (error) {}
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ReusableText(
              title: "Verification Code".tr,
              size: 26,
              weight: FontWeight.w700,
              color: Colors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            ReusableText(
                title: "An 4 digit code has been sent to your phone number".tr +
                    "\n" +
                    verificationController.mobile.toString(),
                weight: FontWeight.w400,
                color: Colors.black),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                OtpTextField(
                  controller: value1,
                  onChanged: (v) {
                    if (v.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                OtpTextField(
                  controller: value2,
                  onChanged: (v) {
                    if (v.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                OtpTextField(
                  controller: value3,
                  onChanged: (v) {
                    if (v.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                OtpTextField(
                  controller: value4,
                  onChanged: (v) {
                    if (v.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
              ],
            ),
            Row(
              children: [
                ReusableText(
                  title: "Dont receive the OTP?".tr,
                  weight: FontWeight.w300,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: () {},
                  child: ReusableText(
                    title: "Resend OTP".tr,
                    weight: FontWeight.w400,
                    color: primaryColor,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ReusableButton1(
                onPressed: () {
                  verify();
                },
                title: "Submit".tr),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
