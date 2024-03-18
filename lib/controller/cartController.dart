import 'dart:convert';

import 'package:get/get.dart';
import 'package:rawabi/model/baseResponse.dart';
import 'package:rawabi/screen/orderPlacedScreen.dart';
import 'package:rawabi/utils/app_utils.dart';

import '../model/cartListResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class CartController extends GetxController {
  var loading = false.obs;
  var isContactless = false.obs;
  var groupValue = "Cash".obs;
  List<Products>? products;
  String masterCard = "Master Card";
  String visa = "Visa";
  String cash = "Cash";
  var subTotal = 0.00.obs;
  var delivery = 0.00.obs;
  var bagFee = 0.00.obs;
  var grandTotal = 0.00.obs;

  CartController();

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> getCartList() async {
    try {
      loading.value = true;
      var response = await BaseClient().get(cartList);
      loading.value = false;
      subTotal.value = 0.00;
      if (response != null) {
        var responseData =
            CartListResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          products = responseData.products;

          products?.forEach((element) {
            subTotal.value =
                subTotal.value + double.parse(element.subtotal.toString());
          });

          grandTotal.value = subTotal.value + delivery.value + bagFee.value;
        } else {
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
  }

  Future<void> removeCartItem(var id) async {
    try {
      loading.value = true;
      var request = {"id": id};
      var response = await BaseClient().post(deletecart, request);
      loading.value = false;
      if (response != null) {
        var responseData =
            BaseResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          getCartList();
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

  Future<void> checkoutCart() async {
    try {
      loading.value = true;
      var request = {
        "address_id": "4",
        "subtotal": subTotal.value,
        "discount": "0",
        "payable": grandTotal.value,
        "managed_by": "2"
      };
      var response = await BaseClient().post(checkout, request);
      loading.value = false;
      if (response != null) {
        var responseData =
            BaseResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          getCartList();
          AppUtils.navigateToPage(const OrderPlacedScreen());
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

  Future<void> addToCart(
      String itemID, String storeID, String? itemPrice, String itemQty) async {
    try {
      loading.value = true;
      var request = {
        "item_id": itemID,
        "store_id": storeID,
        "item_price": itemPrice,
        "item_qty": itemQty
      };
      var response = await BaseClient().post(addtocart, request);
      loading.value = false;
      if (response != null) {
        var responseData =
        BaseResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          getCartList();
        } else {
          CommonUtils.showErrorDialog(responseData.message);
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
