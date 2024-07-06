import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/response/baseResponse.dart';
import '../model/response/slotResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';
import '../utils/storage_manager.dart';
import 'homeController.dart';

class SlotController extends GetxController {
  var loading = false.obs;

  SlotController();

  final homeController = Get.put(HomeController());

  var allSlots = <Slot>[].obs;
  var availableSlots = <Slot>[].obs;
  var selectedSlot = Slot().obs;
  var storeId;
  var storeLat;

  var storeLng;

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> getStoreData() async {
    storeId = await StorageManager.readData(StorageManager.keyStoreID);
    // storeLat = await StorageManager.readData(StorageManager.keyStoreLat);
    storeLat = await StorageManager.getStoreLat();
    storeLng = await StorageManager.readData(StorageManager.keyStoreLng);
    getSlot(storeLat.toString(), storeLng.toString());
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
        allSlots.clear();
        availableSlots.clear();
        if (responseData.code == "200") {
          if (responseData.res == null) {
            allSlots.value = [];
            availableSlots.value = [];
          } else {
            allSlots.addAll(responseData.res?[0]?.slots as Iterable<Slot>);

            allSlots.forEach(
              (element) {
                if (element.available!) {
                  availableSlots.add(element);
                }
              },
            );
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

  Future<void> checkSlotAvailability(
      int selectedSlotIndex, int selectedDateIndex) async {
    try {
      homeController.selectedSlotDate.value = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().add(Duration(days: selectedDateIndex)));
      loading.value = true;
      var request = {
        "type": homeController.isExpress.value ? "Express" : "Normal",
        "start": selectedSlot.value.starttime,
        "end": selectedSlot.value.endtime,
        "date": homeController.selectedSlotDate.value
      };
      var response = await BaseClient().post(slotAvail, request);
      loading.value = false;
      if (response != null) {
        var responseData =
            BaseResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          homeController.selectedSlotID.value = selectedSlot.value.slotid!;
          homeController.selectedStartTime.value =
              selectedSlot.value.starttime!;
          homeController.selectedEndTime.value = selectedSlot.value.endtime!;

          CommonUtils().messageBox("Slot Updated Successfully");
          Get.back();
        } else {
          CommonUtils.showErrorDialog(responseData.slot);
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
