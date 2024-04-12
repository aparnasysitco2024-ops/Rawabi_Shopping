import 'dart:convert';

import 'package:get/get.dart';

import '../model/response/flayerListResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class FlayerListController extends GetxController {
  var loading = false.obs;

  var flayersList = <Flayers>[].obs;

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> getFlayers() async {
    try {
      loading.value = true;
      var response = await BaseClient().get(flyerListUrl);
      loading.value = false;
      if (response != null) {
        flayersList.clear();
        var responseData =
            FlayerListResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          flayersList.addAll(responseData.res! as Iterable<Flayers>);
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
