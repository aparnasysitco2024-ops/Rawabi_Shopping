import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/homeController.dart';
import 'package:rawabi/controller/wishlistController.dart';
import 'package:rawabi/model/response/baseResponse.dart';
import 'package:rawabi/model/response/checkoutResponse.dart';
import 'package:rawabi/screen/home/selectSlotScreen.dart';
import 'package:rawabi/screen/orderPlacedScreen.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:vibration/vibration.dart';

import '../model/response/calculateFeeResponse.dart';
import '../model/response/cartListResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';
import '../utils/storage_manager.dart';

class CartController extends GetxController {
  var isLoadedFirst = false.obs;
  var loading = false.obs;
  var isContactless = false.obs;
  var paymentValue = "cod".obs;

  var cartProducts = <Products>[].obs;
  String masterCard = "Master Card";
  String online = "online";
  String cash = "cod";
  String card = "card";
  var subTotal = 0.00.obs;
  var delivery = 0.00.obs;
  var bagFee = 0.00.obs;
  var discount = 0.00.obs;
  var grandTotal = 0.00.obs;
  var totalItemCount = 0.obs;
  var couponID = 0.obs;
  var selectedPickupSlot = "".obs;
  var noteTextController = TextEditingController();

  CartController();

  final homeController = Get.put(HomeController());

  // @override
  // onInit() async {
  //   super.onInit();
  // }

  Future<void> getCartList() async {
    try {
      if (isLoadedFirst.value) {
        loading.value = true;
        isLoadedFirst.value = true;
      }
      var response = await BaseClient().get(cartList);
      loading.value = false;
      subTotal.value = 0.00;
      cartProducts.clear();
      if (response != null) {
        var responseData =
            CartListResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          cartProducts.addAll(responseData.products as Iterable<Products>);
          // cartProducts = responseData.products;
          totalItemCount.value = cartProducts.length;

          delivery.value = homeController.isPickup.value
              ? 0.0
              : double.parse(responseData.deliveryFee.toString());
          bagFee.value = double.parse(responseData.bagFee.toString());

          for (var element in cartProducts) {
            subTotal.value =
                subTotal.value + double.parse(element.subtotal.toString());
          }

          grandTotal.value =
              subTotal.value + delivery.value + bagFee.value - discount.value;
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

  Future<void> calculateDeliveryFee() async {
    try {
      if (isLoadedFirst.value) {
        loading.value = true;
        isLoadedFirst.value = true;
      }
      await StorageManager.readData(StorageManager.keyDefaultAddressId);
      var request = {
        "lat1":
            await StorageManager.readData(StorageManager.keyDefaultAddressLat),
        "lon1":
            await StorageManager.readData(StorageManager.keyDefaultAddressLng),
        "type": homeController.isExpress.value ? "2" : "1"
      };

      var response = await BaseClient().post(calculate, request);
      loading.value = false;
      if (response != null) {
        var responseData =
            CalculateFeeResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          if (responseData.fee != null) {
            delivery.value = double.parse(responseData.fee.toString());
          }
        } else {
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      error.printError();
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

  Future<void> updateQty(var id, var qty) async {
    try {
      Vibration.vibrate(duration: 5);
      loading.value = true;
      var request = {"id": id, "qty": qty};
      var response = await BaseClient().post(update_qty, request);
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
        "address_id":
            await StorageManager.readData(StorageManager.keyDefaultAddressId),
        "subtotal": subTotal.value,
        "discount": "0",
        "payable": grandTotal.value,
        "order_type": homeController.isPickup.value ? "pickup" : "delivery",
        "delivery_type": homeController.isExpress.value ? "Express" : "Normal",
        "start_time": homeController.selectedStartTime.value,
        "end_time": homeController.selectedEndTime.value,
        "date": homeController.selectedSlotDate.value,
        "coupon": couponID.value,
        "payment_method": paymentValue.value,
        "order_note": noteTextController.text
      };
      var response = await BaseClient().post(checkout, request);
      loading.value = false;
      if (response != null) {
        var responseData =
            CheckoutResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          getCartList();
          AppUtils.navigateToPage(OrderPlacedScreen(
            orderId: responseData.orderId,
          ));
        } else {
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      print(error.toString());
      // CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
  }

  Future<void> addToCart(String itemID, String storeID, String? itemPrice,
      String itemQty, String note) async {
    // if (await Vibration.hasCustomVibrationsSupport()) {
    Vibration.vibrate(duration: 5);
    // } else {
    //   Vibration.vibrate();
    //   await Future.delayed(Duration(milliseconds: 500));
    //   Vibration.vibrate();
    // }
    try {
      loading.value = true;
      var request = {
        "item_id": itemID,
        "store_id": storeID,
        "item_price": itemPrice,
        "item_qty": itemQty,
        "item_note": note
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
      error.printError();
      // CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
  }

  Future<void> addToWishList(var id) async {
    try {
      loading.value = true;
      var request = {"item_id": id};
      var response = await BaseClient().post(addtowishUrl, request);
      loading.value = false;
      if (response != null) {
        var responseData =
            BaseResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
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

  Future<void> removeFromWishList(var id) async {
    try {
      loading.value = true;
      var request = {"id": id};
      var response = await BaseClient().post(deletewishUrl, request);
      loading.value = false;
      if (response != null) {
        var responseData =
            BaseResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          if (Get.isRegistered<WishListController>()) {
            final wishListController = Get.put(WishListController());
            wishListController.getWishList();
          }
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

  Future<void> checkSlotAvailability() async {
    try {
      loading.value = true;
      var request = {
        "type": homeController.isExpress.value ? "Express" : "Normal",
        "start": homeController.selectedStartTime.value,
        "end": homeController.selectedEndTime.value,
        "date": homeController.selectedSlotDate.value
      };
      var response = await BaseClient().post(slotAvail, request);
      loading.value = false;
      if (response != null) {
        var responseData =
            BaseResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          checkoutCart();
        } else {
          AppUtils.navigateToPage(SelectSlotScreen());
          // CommonUtils.showErrorDialog(responseData.slot);
        }
      } else {
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      print(error.toString());
      // CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
  }
}
