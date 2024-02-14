import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUtils {
  static navigateToPage(Widget page) {
    Navigator.push(Get.context!,
        MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  static navigateToPageReplace(Widget page) {
    Navigator.pushReplacement(Get.context!,
        MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  static navigateToPageRemoveUntil(Widget page) {
    Navigator.of(Get.context!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
        (Route<dynamic> route) => false);
  }

}
