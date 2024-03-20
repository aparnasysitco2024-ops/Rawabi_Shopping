import 'dart:convert';

import 'package:get/get.dart';
import 'package:rawabi/model/categoryResponse.dart';

import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class CategoryController extends GetxController {
  var categoryList = <Category>[].obs;

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

}
