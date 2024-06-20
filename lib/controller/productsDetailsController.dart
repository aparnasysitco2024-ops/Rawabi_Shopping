import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/response/productDetailsResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class ProductDetailsController extends GetxController {
  var loading = false.obs;
  var isKeyboardRefresh = false.obs;
  var productDetails = ProductDetails().obs;

  // ProductDetails? productDetails;
  var noteTextController = TextEditingController();

  ProductDetailsController();

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> getProductDetails(String productID) async {
    if (!isKeyboardRefresh.value) {
      try {
        // if (!isKeyboardRefresh.value) {
        loading.value = true;
        // }
        isKeyboardRefresh.value = false;
        var request = {"id": productID};
        var response = await BaseClient().post(product_details, request);
        loading.value = false;
        if (response != null) {
          var responseData =
              ProductDetailsResponse.fromJson(json.decode(response.toString()));
          if (responseData.code == "200") {
            productDetails.value = responseData.productDetails!;
          } else {
            CommonUtils.showErrorDialog(responseData.message);
          }
        } else {
          CommonUtils.showErrorDialog(response.message);
        }
      } catch (error) {
        // CommonUtils.showErrorDialog(error.toString());
      }
    }
    // isKeyboardRefresh.value = false;
    loading.value = false;
  }
}
