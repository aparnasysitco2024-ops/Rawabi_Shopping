import 'dart:convert';

import 'package:get/get.dart';
import 'package:rawabi/model/response/notificationListResponse.dart';

import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class NotificationListController extends GetxController {
  var loading = false.obs;
  var defaultAddressId = "".obs;

  NotificationListController();

  var notifications = <Notifications>[].obs;

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> getNotificationList() async {
    try {
      loading.value = true;

      var response = await BaseClient().get(notificationList);
      loading.value = false;
      if (response != null) {
        notifications.clear();
        var responseData =
            NotificationListResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          notifications.addAll(responseData.res! as Iterable<Notifications>);
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
