import 'dart:convert';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/response/languageParamResponse.dart';
import '../model/response/slotResponse.dart';
import '../model/response/storeResponse.dart';
import '../screen/navigator/bottomNavBar.dart';
import '../utils/app_utils.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';
import '../utils/storage_manager.dart';
import 'homeController.dart';

class StorePickupController extends GetxController {
  var loading = false.obs;

  StorePickupController();

  var storeList = <StoreList>[].obs;
  var languageParam = LanguageParam().obs;
  var languageParamString = "";

  @override
  onInit() async {
    super.onInit();
    getLanguageData();
  }

  Future<void> getLanguageData() async {
    languageParamString =
        await StorageManager.readData(StorageManager.keyLanguageParams);
    if (languageParamString.isNotEmpty)
      languageParam.value =
          LanguageParam.fromJson(json.decode(languageParamString));
  }

  Future<void> getStore() async {
    try {
      loading.value = true;
      var response = await BaseClient().get(storeListUrl);
      loading.value = false;
      if (response != null) {
        storeList.clear();
        var responseData =
            StoreResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          storeList.addAll(responseData.res! as Iterable<StoreList>);
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

  Future<void> launchGoogleMaps(double lat, double lng) async {
    double destinationLatitude = lat;
    double destinationLongitude = lng;
    final uri = Uri(
        scheme: "google.navigation",
        // host: '"0,0"',  {here we can put host}
        queryParameters: {'q': '$destinationLatitude, $destinationLongitude'});
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('An error occurred');
    }
  }

  Future<void> getSlot(
      String latitude, String longitude, String address) async {
    // latitude = "25.179864";
    // longitude = "51.5678239";
    try {
      loading.value = true;
      var request = {"latitude": latitude, "longitude": longitude};

      var response = await BaseClient().post(slotList, request);
      loading.value = false;

      if (response != null) {
        var responseData =
            SlotResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          StorageManager.saveData(StorageManager.keyStoreLat, latitude);
          StorageManager.saveData(StorageManager.keyStoreLng, longitude);

          if (responseData.res != null && responseData.res!.isNotEmpty) {
            StorageManager.saveData(
                StorageManager.keyStoreID, responseData.res?.first?.storeid);

            StorageManager.saveData(
                StorageManager.keyStoreID, responseData.res?.first?.storeid);
            StorageManager.saveData(StorageManager.keyStoreAddress, address);
            StorageManager.saveData(StorageManager.keyIsPickup, false);

            if (Get.isRegistered<HomeController>()) {
              final homeController = Get.put(HomeController());
              homeController.storeAddress.value = address;
              homeController.storeID.value = responseData.res!.first!.storeid!;
              homeController.isPickup.value = false;
              homeController.getHomeData();
              Get.back();
              // Navigator.pop(Get!.context);
            } else {
              AppUtils.navigateToPageRemoveUntil(BottomNavBar());
            }
          } else {
            // StorageManager.saveData(
            //     StorageManager.keyStoreID, responseData.res?.first?.storeid);

            StorageManager.saveData(StorageManager.keyStoreID, "10");
            StorageManager.saveData(StorageManager.keyStoreAddress, address);
            StorageManager.saveData(StorageManager.keyIsPickup, false);

            if (Get.isRegistered<HomeController>()) {
              final homeController = Get.put(HomeController());
              homeController.storeAddress.value = address;
              homeController.storeID.value = "10";
              homeController.isPickup.value = false;
              homeController.getHomeData();
              Get.back();
              // Navigator.pop(Get!.context);
            } else {
              AppUtils.navigateToPageRemoveUntil(BottomNavBar());
            }
          }
        } else {
          CommonUtils.showErrorDialog(response.message);
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
