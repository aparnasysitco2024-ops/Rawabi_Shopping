import 'dart:convert';

import 'package:get/get.dart';
import 'package:rawabi/model/response/offerListResponse.dart';

import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class OfferListController extends GetxController {
  var allList = <OfferCategory>[].obs;
  var offerList = <OfferCategory>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  var loading = false.obs;

  Future<void> getOffers() async {
    try {
      loading.value = true;
      var response = await BaseClient().get(discountProductsUrl);
      loading.value = false;
      if (response != null) {
        var responseData =
            OfferListResponse.fromJson(json.decode(response.toString()));
        offerList.clear();
        allList.clear();

        if (responseData.code == "200") {
          allList.addAll(responseData.category as List<OfferCategory>);

          allList.forEach(
            (element) {
              if (element.products!.isNotEmpty) offerList.add(element);
            },
          );
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
}
