import 'dart:convert';

import 'package:get/get.dart';

import '../model/storeResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class StorePickupController extends GetxController {
  var loading = false.obs;

  StorePickupController();

  var storeList = <StoreList>[].obs;

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> getStore() async {
    try {
      loading.value = true;
      var response = await BaseClient().get(storeListUrl);
      loading.value = false;
      if (response != null) {
        storeList.clear();
        var responseData =
            StoreResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          storeList.addAll(responseData.res! as Iterable<StoreList>);
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
