import 'dart:convert';

import 'package:get/get.dart';
import 'package:radio_group_v2/widgets/view_models/radio_group_controller.dart';
import 'package:rawabi/model/response/baseResponse.dart';

import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class ReviewController extends GetxController {
  var loading = false.obs;

  RadioGroupController radioController = RadioGroupController();

  List<String> reportList = [
    "App experience",
    "Promotions",
    "App search",
    "App cart",
    "Checkout",
    "Delivery",
    "Returns",
    "Customer care service",
    "Other"
  ];

  List<String>? selectedChoices = [];

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> submitReview() async {
    try {
      loading.value = true;
      var request = {
        "feel": radioController.value,
        "problem": selectedChoices?.join(","),
      };
      print(json.encode(request));
      var response = await BaseClient().post(commonreviewUrl, request);
      loading.value = false;
      if (response != null) {
        var responseData =
            BaseResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          CommonUtils.showSuccessDialog(responseData.message);
        } else {
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      print(error.toString());
      // CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
  }
}
