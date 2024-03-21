import 'dart:convert';

import 'package:get/get.dart';
import 'package:rawabi/model/categoryResponse.dart';

import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class CategoryController extends GetxController {
  var categoryList = <Category>[].obs;
  var subCategoryList = <Category>[].obs;
  var subSubCategoryList = <Category>[].obs;
  var subSubSubCategoryList = <Category>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  var loading = false.obs;

  Future<void> getCategory() async {
    try {
      loading.value = true;
      var response = await BaseClient().get(categoryUrl);
      loading.value = false;
      if (response != null) {
        var responseData =
            CategoryResponse.fromJson(json.decode(response.toString()));
        categoryList.clear();

        if (responseData.code == "200") {
          categoryList.addAll(responseData.res!.category as List<Category>);
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
    loading.value = false;
  }

  Future<void> getSubCategory(String catId, int subPosition) async {
    try {
      // loading.value = true;
      if (subPosition == 0) {
        subCategoryList.clear();
      } else if (subPosition == 1) {
        subSubCategoryList.clear();
      } else if (subPosition == 2) {
        subSubSubCategoryList.clear();
      }
      categoryList.refresh();

      var request = {"catid": catId};
      var response = await BaseClient().post(subcategoryUrl, request);
      if (response != null) {
        var responseData =
            CategoryResponse.fromJson(json.decode(response.toString()));

        if (responseData.code == "200") {
          if (subPosition == 0) {
            subCategoryList
                .addAll(responseData.res!.category as List<Category>);
            // subCategoryList.refresh();
          } else if (subPosition == 1) {
            subSubCategoryList
                .addAll(responseData.res!.category as List<Category>);
            // subSubCategoryList.refresh();
          } else if (subPosition == 2) {
            subSubSubCategoryList
                .addAll(responseData.res!.category as List<Category>);
            // subSubSubCategoryList.refresh();
          }

          categoryList.refresh();
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
