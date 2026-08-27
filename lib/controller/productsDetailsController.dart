import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rawabi/model/response/products.dart';

import '../model/response/productDetailsResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';
import '../utils/storage_manager.dart';

class ProductDetailsController extends GetxController {
  var loading = false.obs;
  var isKeyboardRefresh = false.obs;
  var productDetails = ProductDetails().obs;
  var similarProducts = <Products>[].obs;
  String productID="";

  // ProductDetails? productDetails;
  var noteTextController = TextEditingController();

  ProductDetailsController();

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> getProductDetails(String productID) async {
    this.productID = productID;
    if (!isKeyboardRefresh.value) {
      try {
        // if (!isKeyboardRefresh.value) {
        loading.value = true;
        // }
        var storeName = await StorageManager.readData(StorageManager.keyStoreName);
        isKeyboardRefresh.value = false;
        var request = {"id": productID};
        var response = await BaseClient().post(product_details, request);
        loading.value = false;
        if (response != null) {
          var responseData =
              ProductDetailsResponse.fromJson(json.decode(response.toString()));
          if (responseData.code == "200") {
            productDetails.value = responseData.productDetails!;
            similarProducts.value =responseData.products!;
            print("Before view_item");
            try {
              await FirebaseAnalytics.instance.logEvent(
                name: "view_item",
                parameters: {
                  "item_id": productDetails.value.productId.toString(),
                  "item_name": productDetails.value.productName.toString(),
                  "store_id": productDetails.value.storeId.toString(),
                  "store_name": storeName,
                },
              );

              print("After view_item");
            } catch (e, s) {
              print("Analytics Error: $e");
              print(s);
            }
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
