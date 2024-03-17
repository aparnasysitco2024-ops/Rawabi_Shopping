import 'dart:convert';

import 'package:get/get.dart';

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
      if (response != null) {
        var responseData =
        CartListResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          products= responseData.products;

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
