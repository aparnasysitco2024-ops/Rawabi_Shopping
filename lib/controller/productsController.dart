import 'dart:convert';

import 'package:get/get.dart';

import '../model/response/categoryResponse.dart';
import '../model/response/products.dart';
import '../model/response/productsResponse.dart';
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
  var sort = "0".obs;
  final homeController = Get.put(HomeController());
  final cartController = Get.put(CartController());
  var subCategoryList = <Category>[].obs;
  var subSubSubCatID = "0".obs;

  Future<void> getProductsByCat(String catID, String subCatID,
      String subSubCatID, String subSubSubCatID) async {
    try {
      if (!isLoaded) loading.value = true;
      var request = {
        "catid": catID,
        "subcatid": subCatID,
        "sub-subcatid": subSubCatID,
        "sub-sub-subcatid": subSubSubCatID,
        "sort": sort.value
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

  Future<void> getSubCategory(String catId, subCatID, subSubCatID) async {
    try {
      // loading.value = true;
      subCategoryList.clear();

      var request = {"catid": subSubCatID};
      var response = await BaseClient().post(subcategoryUrl, request);
      if (response != null) {
        var responseData =
            CategoryResponse.fromJson(json.decode(response.toString()));

        if (responseData.code == "200") {
          subCategoryList.addAll(responseData.res!.category as List<Category>);

          if (subCategoryList.isNotEmpty) {
            subSubSubCatID.value = subCategoryList[0].catId.toString();
          }

          getProductsByCat(catId, subCatID, subSubCatID, subSubSubCatID.value);
          // subCategoryList.refresh();
        } else {
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      error.printError();
      // CommonUtils.showErrorDialog(error.toString());
    }
    // loading.value = false;
  }
}
