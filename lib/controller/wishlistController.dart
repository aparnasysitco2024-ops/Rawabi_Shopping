import 'dart:convert';

import 'package:get/get.dart';

import '../model/products.dart';
import '../model/wishListResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class WishListController extends GetxController {
  var loading = false.obs;

  WishListController();

  var productList = <Products>[].obs;

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> getWishList() async {
    try {
      loading.value = true;
      var response = await BaseClient().get(wishListUrl);
      loading.value = false;
      if (response != null) {
        productList.clear();
        var responseData =
        WishListResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          productList.addAll(responseData.res as Iterable<Products>);
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
