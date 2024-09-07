import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/cartController.dart';
import 'package:rawabi/model/response/baseResponse.dart';
import 'package:rawabi/model/response/myorder/myOrderResponse.dart';
import 'package:rawabi/screen/myOrder/myOrdersTabScreen.dart';
import 'package:rawabi/utils/app_utils.dart';

import '../model/response/myorder/items.dart';
import '../model/response/myorder/orderDetailResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class MyOrderDetailController extends GetxController {
  var loading = false.obs;

  MyOrderDetailController();

  var myOrderList = <Items>[].obs;
  Orders myOrder = Orders();
  var reasonController = TextEditingController();
  var returnReasonController = TextEditingController();

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> getMyOrderDetail(String id) async {
    try {
      loading.value = true;
      var request = {"id": id};
      var response = await BaseClient().post(orderDetailUrl, request);
      loading.value = false;
      if (response != null) {
        myOrderList.clear();
        var responseData =
            OrderDetailResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          myOrder = responseData.res!.first;
          myOrderList.addAll(responseData.res?.first.items! as Iterable<Items>);
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

  Future<void> getMyOrderDetailPreOrder(String id) async {
    try {
      loading.value = true;
      var request = {"id": id};
      var response = await BaseClient().post(order_detail_preUrl, request);
      loading.value = false;
      if (response != null) {
        myOrderList.clear();
        var responseData =
        OrderDetailResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          myOrder = responseData.res!.first;
          myOrderList.addAll(responseData.res?.first.items! as Iterable<Items>);
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

  Future<void> cancelOrder() async {
    try {
      loading.value = true;
      var request = {
        "order_id": myOrder.orderid,
        "reason": reasonController.text,
      };
      var response = await BaseClient().post(order_cancelUrl, request);
      loading.value = false;
      if (response != null) {
        var responseData =
            BaseResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          CommonUtils().messageBox(responseData.message.toString());
          // getMyOrderDetail("Processing");
          AppUtils.navigateToPageReplace(MyOrdersTabScreen());
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

  Future<void> reOrder() async {
    try {
      loading.value = true;
      var request = {
        "order_id": myOrder.orderid,
      };
      var response = await BaseClient().post(reOrderUrl, request);
      loading.value = false;
      if (response != null) {
        var responseData =
            BaseResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          CommonUtils().messageBox(responseData.message.toString());
          final cartController = Get.put(CartController());
          cartController.getCartList();
          Get.back();
          Get.back();
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

  Future<void> returnItem(
      String item_id, String detail_id, String reason) async {
    try {
      loading.value = true;
      var request = {
        "order_id": myOrder.orderid,
        "detail_id": detail_id,
        "item_id": item_id,
        "reason": reason
      };
      var response = await BaseClient().post(returnUrl, request);
      loading.value = false;
      if (response != null) {
        var responseData =
            BaseResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          CommonUtils().messageBox(responseData.message.toString());
          getMyOrderDetail(myOrder.orderid.toString());
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

  Future<void> rating(String item_id, String rate, String review) async {
    try {
      loading.value = true;
      var request = {"item_id": item_id, "rate": rate, "review": review};
      var response = await BaseClient().post(ratingUrl, request);
      loading.value = false;
      if (response != null) {
        var responseData =
            BaseResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          CommonUtils().messageBox(responseData.message.toString());
          getMyOrderDetail(myOrder.orderid.toString());
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
