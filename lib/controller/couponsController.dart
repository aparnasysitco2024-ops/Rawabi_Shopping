import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/response/couponsModel.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class CouponsController extends GetxController {

  CouponsController();
  var loading = false.obs;
  var codeController=TextEditingController();
  List<Coupon?>? coupons=<Coupon?>[].obs;
var couponType ="".obs;
var couponValue=0.00.obs;
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

  Future<bool> validateCoupon(String couponCode,String amount)  async {
    try {
      loading.value = true;
      var request = {"coupon_code": couponCode,"amount":amount};
      var response = await BaseClient().post(couponValidate,request);
      loading.value = false;
      if (response!=null) {
        var responseData = CouponValidateResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200"&&responseData.res=="Valid") {
          couponType.value=responseData.type!;
          couponValue.value=double.parse(responseData.value.toString());
          CommonUtils().messageBox("Coupon applied successfully!");
          return true;
        }
        else{
          CommonUtils().messageBox(responseData.res.toString());
          return false;
        }
      } else {
        CommonUtils().messageBox("Something wrong! Please try later!");
        return false;
      }
    } catch (error) {
      CommonUtils().messageBox("Something wrong! Please try later!");

    }
    loading.value = false;
    return false;
  }

}
