import 'dart:convert';

import 'package:get/get.dart';

import '../model/products.dart';
import '../model/productsResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';
import 'cartController.dart';
import 'homeController.dart';

class ProductController extends GetxController {
  var isLoaded = false;
  var loading = false.obs;
  var productList = <Products>[].obs;
  var catName = "".obs;
  final homeController = Get.put(HomeController());
  final cartController = Get.put(CartController());

  Future<void> getProductsByCat(String catID, String subCatID,
      String subSubCatID, String subSubSubCatID) async {
    try {
      if (!isLoaded) loading.value = true;
      var request = {
        "catid": catID,
        "subcatid": subCatID,
        "sub-subcatid": subSubCatID,
        "sub-sub-subcatid": subSubSubCatID
      };
      var response = await BaseClient().post(products, request);
      loading.value = false;
      if (response != null) {
        var responseData =
            ProductsResponse.fromJson(json.decode(response.toString()));
        productList.clear();

        if (responseData.code == "200") {
          catName.value = responseData.res!.category!.catName!;
          if (responseData.res?.products != null) {
            productList.addAll(responseData.res?.products as List<Products>);

            cartController.cartProducts.forEach((cartElement) {
              productList.forEach((element) {
                if (element.productId == cartElement.productId) {
                  element.qty = int.parse(cartElement.quantity.toString());
                }
              });
            });
          }

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
      error.printError();
      // CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
  }
}
