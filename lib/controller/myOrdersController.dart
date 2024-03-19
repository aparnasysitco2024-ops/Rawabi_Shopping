import 'dart:convert';

import 'package:get/get.dart';
import 'package:rawabi/model/myOrderResponse.dart';

import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';
import '../utils/storage_manager.dart';

class MyOrdersController extends GetxController {
  var loading = false.obs;
  var defaultAddressId = "".obs;

  MyOrdersController();

  var myOrderList = <MyOrder>[].obs;

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> getMyOrder() async {
    try {
      defaultAddressId.value =
          await StorageManager.readData(StorageManager.keyDefaultAddressId);
      loading.value = true;
      var response = await BaseClient().get(myorders);
      loading.value = false;
      if (response != null) {
        myOrderList.clear();
        var responseData =
            MyOrderResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          myOrderList.addAll(responseData.myOrder as Iterable<MyOrder>);
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
