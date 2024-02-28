import 'dart:convert';

import 'package:get/get.dart';
import 'package:rawabi/model/baseResponse.dart';

import '../model/homeResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class HomeController extends GetxController {
  var grpTypeImage = "1";
  var grpTypeCategory = "2";
  var grpTypeProduct = "3";

  var isExpress = true.obs;
  var categoryList = <Category>[].obs;
  var bannerList = <Slider>[].obs;
  var itemGroupList = <ItemGroup>[].obs;

  var bannerList2 = [
    'assets/images/apple.png',
    'assets/images/banner.png',
    'assets/images/banner.png'
  ].obs;

  // var bannerList3 = [
  //   'assets/images/ads3.png',
  //   'assets/images/banner.png',
  //   'assets/images/banner.png'
  // ].obs;

  var isHomeLoaded = false;
  var loading = false.obs;

  Future<void> getHomeData() async {
    try {
      if (!isHomeLoaded) loading.value = true;
      var response = await BaseClient().get(home);
      loading.value = false;
      if (response != null) {
        var responseData =
            HomeResponse.fromJson(json.decode(response.toString()));
        categoryList.clear();
        bannerList.clear();
        itemGroupList.clear();

        if (responseData.code == "200") {
          categoryList.addAll(responseData.res!.category as List<Category>);
          bannerList.addAll(responseData.res!.slider as List<Slider>);
          itemGroupList.addAll(responseData.res!.itemGroup as List<ItemGroup>);

          isHomeLoaded = true;
        } else {
          isHomeLoaded = false;
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        isHomeLoaded = false;
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      isHomeLoaded = false;
      CommonUtils.showErrorDialog(error.toString());
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
          CommonUtils().messageBox(responseData.message.toString());
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
