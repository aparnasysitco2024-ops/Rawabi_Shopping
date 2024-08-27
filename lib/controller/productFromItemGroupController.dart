import 'dart:convert';

import 'package:get/get.dart';
import 'package:rawabi/model/response/products.dart';

import '../model/response/itemGroupDetailsResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class ProductFromItemGroupController extends GetxController {
  var loading = false.obs;
  var productList = <Products>[].obs;

  ProductFromItemGroupController();

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> getItemGroupDetails(String grp_id) async {
    try {
      loading.value = true;
      var request = {"grp_id": grp_id};

      var response = await BaseClient().post(itemgroup_details, request);
      loading.value = false;
      productList.clear();

      if (response != null) {
        var responseData =
            ItemGroupDetailsResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          productList.addAll(
              responseData.itemGroup![0].grpItems as Iterable<Products>);
        } else {
          CommonUtils.showErrorDialog(response.message);
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
