import 'dart:convert';

import 'package:get/get.dart';

import '../model/productDetailsResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class ProductDetailsController extends GetxController {

  var loading = false.obs;
  ProductDetails? productDetails;

  ProductDetailsController();

  @override
  onInit() async {
    super.onInit();

  }

  Future<void> getProductDetails(String productID) async {
    try {
      loading.value = true;
      var request = {"id": productID};
      var response = await BaseClient().post(product_details, request);
      loading.value = false;
      if (response != null) {
        var responseData =
        ProductDetailsResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          productDetails= responseData.productDetails;

        } else {
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      // CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
  }
}
