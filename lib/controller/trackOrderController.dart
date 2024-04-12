import 'dart:convert';

import 'package:get/get.dart';

import '../model/response/myorder/orderStatusResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class TrackOrderController extends GetxController {
  var loading = false.obs;

  TrackOrderController();

  var status = Status().obs;

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> getStatus(String id) async {
    try {
      loading.value = true;
      var request = {"orderid": id};

      var response = await BaseClient().postDriver(orderStatusLogUrl, request);
      loading.value = false;

      if (response != null) {
        var responseData =
            OrderStatusResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          status.value = responseData.status!.first;
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
