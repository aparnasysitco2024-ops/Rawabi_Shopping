import 'dart:convert';

import 'package:get/get.dart';
import 'package:rawabi/model/response/myorder/myOrderResponse.dart';

import '../model/response/couponsModel.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';
import '../utils/storage_manager.dart';

class CouponsController extends GetxController {

  CouponsController();
  var loading = false.obs;
  List<Coupon?>? coupons=<Coupon?>[].obs;

  Future<void> getCoupons()  async {
    try {
      loading.value = true;
      var response = await BaseClient().get(couponList);
      loading.value = false;
      if (response != null) {
        coupons?.clear();
        var responseData =
        CouponsResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          coupons?.addAll(responseData.res!);
          print(coupons);
        }
      } else {
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
       CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
  }
}
