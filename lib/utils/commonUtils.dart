import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../widget/commonwidget/reusable_button1.dart';
import '../widget/commonwidget/reusable_text.dart';
import 'colors.dart';

class CommonUtils {
  static showLoader() {
    Get.dialog(
        const Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
        barrierColor: Colors.black26,
        barrierDismissible: false);
  }

  static hideLoader() {
    Get.back();
  }

  static void showErrorDialog(message) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)), //this right here
            child: SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/cross.svg"),
                    const SizedBox(
                      height: 15,
                    ),
                    ReusableText(
                      title: 'Error'.tr,
                      weight: FontWeight.w700,
                      size: 14,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ReusableText(
                      maxLine: 2,
                      title: message,
                      weight: FontWeight.w400,
                      size: 14,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 250.0,
                      height: 45,
                      child: ReusableButton1(
                        backgroundColor: Colors.red,
                        onPressed: () {
                          Get.back();
                        },
                        title: "OK".tr,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  static void showSuccessDialog(title, message) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)), //this right here
            child: SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/tick.svg"),
                    const SizedBox(
                      height: 15,
                    ),
                    ReusableText(
                      title: title,
                      maxLine: 1,
                      weight: FontWeight.w700,
                      size: 14,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ReusableText(
                      maxLine: 2,
                      title: message,
                      weight: FontWeight.w400,
                      size: 14,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 250.0,
                      height: 45,
                      child: ReusableButton1(
                        backgroundColor: Colors.green,
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                        title: "OK",
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void messageBox(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      content: Text(message),
      duration: Durations.extralong1,
    ));
  }
}
