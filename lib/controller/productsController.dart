import 'dart:convert';

import 'package:get/get.dart';

import '../model/products.dart';
import '../model/productsResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class ProductController extends GetxController {

  var isLoaded = false;
  var loading = false.obs;
  var productList = <Products>[].obs;
  var catName = "".obs;

  Future<void> getProductsByCat(String catID) async {
    try {
      if (!isLoaded) loading.value = true;
      var request = {"catid": catID, "subcatid": "0", "sub-subcatid": "0"};
      var response = await BaseClient().post(products, request);
      loading.value = false;
      if (response != null) {
        var responseData =
            ProductsResponse.fromJson(json.decode(response.toString()));
        productList.clear();

        if (responseData.code == "200") {
          catName.value = responseData.res!.category!.catName!;
          productList.addAll(responseData.res!.products as List<Products>);

          isLoaded = true;
        } else {
          isLoaded = false;
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        isLoaded = false;
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      isLoaded = false;
      CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
  }
}
