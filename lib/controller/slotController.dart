import 'dart:convert';

import 'package:get/get.dart';
import 'package:rawabi/controller/storePickupController.dart';

import '../model/response/slotResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';
import '../utils/storage_manager.dart';

class SlotController extends GetxController {
  var loading = false.obs;

  SlotController();

  var slots = <Slot>[].obs;
  var storeId;
  var storeLat;

  var storeLng;
  final storePickupController = Get.put(StorePickupController());

  @override
  onInit() async {
    super.onInit();
    storePickupController.getStore();
  }

  Future<void> getStoreData() async {
    storeId = await StorageManager.readData(StorageManager.keyStoreID);
    storePickupController.storeList.forEach((element) {
      if (element.storeId == storeId) {
        storeLat = element.latitude;
        storeLng = element.longitude;
      }
    });
    await getSlot(storeLat, storeLng);
  }

  Future<void> getSlot(String latitude, String longitude) async {
    try {
      loading.value = true;
      var request = {"latitude": latitude, "longitude": longitude};

      var response = await BaseClient().post(slotList, request);
      loading.value = false;

      if (response != null) {
        var responseData =
            SlotResponse.fromJson(json.decode(response.toString()));
        slots.clear();
        if (responseData.code == "200") {
          if (responseData.res == null) {
            slots.value = [];
          } else {
            slots.addAll(responseData.res?[0]?.slots as Iterable<Slot>);
          }
        } else {
          CommonUtils.showErrorDialog(response.message);
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
