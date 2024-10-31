import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/response/languageParamResponse.dart';
import '../model/response/storeResponse.dart';
import '../screen/navigator/bottomNavBar.dart';
import '../utils/app_utils.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';
import '../utils/storage_manager.dart';
import '../widget/Commonwidget/reusable_text.dart';
import '../widget/storeTile.dart';
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
    getStore();
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
      CommonUtils.showErrorDialog(error.toString());
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

  Future<void> getStoreList(
      String latitude, String longitude, String address) async {
    try {
      loading.value = true;
      var request = {"latitude": latitude, "longitude": longitude};

      var response = await BaseClient().post(storeListUrl, request);
      loading.value = false;

      if (response != null) {
        var responseData =
            StoreResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          chooseNearStore(responseData.res, address);
          // if (Get.isRegistered<HomeController>()) {
          //   final homeController = Get.put(HomeController());
          //   if (homeController.storeID != responseData.res?.first.storeId) {
          //     showCartClearDialog(latitude, longitude, address, responseData);
          //   } else
          //     slotSuccess(latitude, longitude, address, responseData);
          // } else
          //   slotSuccess(latitude, longitude, address, responseData);
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

  void slotSuccess(StoreList storeList, String address) {
    StorageManager.saveData(
        StorageManager.keyStoreLat, storeList.latitude.toString());
    StorageManager.saveData(
        StorageManager.keyStoreLng, storeList.longitude.toString());

    // if (responseData.res != null && responseData.res!.isNotEmpty) {
    StorageManager.saveData(
        StorageManager.keyStoreID, storeList.storeId.toString());

    StorageManager.saveData(
        StorageManager.keyStoreName, storeList.storeName.toString());
    StorageManager.saveData(StorageManager.keyStoreAddress, address);
    StorageManager.saveData(StorageManager.keyIsPickup, false);

    if (Get.isRegistered<HomeController>()) {
      final homeController = Get.put(HomeController());
      homeController.storeAddress.value = address;
      if (homeController.storeID.value != storeList.storeId) {
        homeController.clearCart();
      }
      homeController.storeID.value = storeList.storeId!;
      homeController.storeName.value = storeList.storeName!;
      homeController.isPickup.value = false;
      homeController.getHomeData();
      Get.back();
      // Navigator.pop(Get!.context);
    } else {
      AppUtils.navigateToPageRemoveUntil(BottomNavBar());
    }
    // } else {
    // StorageManager.saveData(
    //     StorageManager.keyStoreID, responseData.res?.first?.storeid);

    // StorageManager.saveData(StorageManager.keyStoreID, "10");
    // StorageManager.saveData(
    //     StorageManager.keyStoreAddress, storeList.address.toString());
    // StorageManager.saveData(StorageManager.keyIsPickup, false);

    // if (Get.isRegistered<HomeController>()) {
    //   final homeController = Get.put(HomeController());
    //   homeController.storeAddress.value = storeList.address.toString();
    //   if (homeController.storeID.value != "10") {
    //     homeController.clearCart();
    //   }
    //   homeController.storeID.value = "10";
    //   StorageManager.saveData(
    //       StorageManager.keyStoreName, "Rawabi HyperMarket Izghawa.");
    //   homeController.storeName.value = "Rawabi HyperMarket Izghawa.";
    //   homeController.isPickup.value = false;
    //   homeController.getHomeData();
    //   Get.back();
    //   // Navigator.pop(Get!.context);
    // }
    // else {
    //   AppUtils.navigateToPageRemoveUntil(BottomNavBar());
    // }
  }

  Future<bool> showCartClearDialog(StoreList storeList, String address) async {
    return (await showDialog(
          context: Get.context!,
          builder: (context) => AlertDialog(
            content: Text(
                'This action may clear your cart. Do you want to continue?'.tr),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                //<-- SEE HERE
                child: Text('No'.tr),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                  slotSuccess(storeList, address);
                }, // <-- SEE HERE
                child: Text('Yes'.tr),
              ),
            ],
          ),
        )) ??
        false;
  }

  void chooseNearStore(List<StoreList>? storeList, String address) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)), //this right here
            child: SizedBox(
              height: 185,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ReusableText(
                      title: "Select a store",
                      weight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: storeList!.length > 2 ? 2 : storeList.length,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                if (Get.isRegistered<HomeController>()) {
                                  final homeController =
                                      Get.put(HomeController());
                                  if (homeController.storeID !=
                                      storeList[index].storeId) {
                                    Get.back();
                                    showCartClearDialog(
                                        storeList[index], address);
                                  } else {
                                    Get.back();
                                    slotSuccess(storeList[index], address);
                                  }
                                } else {
                                  Get.back();
                                  slotSuccess(storeList[index], address);
                                }
                              },
                              child: StoreTile(
                                  title: storeList[index].storeName.toString()),
                            ),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                              height: 5,
                            ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
