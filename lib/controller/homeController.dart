import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:rawabi/model/response/languageParamResponse.dart';

import '../model/response/homeResponse.dart';
import '../model/response/slotResponse.dart';
import '../screen/navigator/bottomNavBar.dart';
import '../utils/app_utils.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';
import '../utils/storage_manager.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  var grpTypeImage = "1";
  var grpTypeCategory = "2";
  var grpTypeProduct = "3";

  var isExpress = false.obs;
  var selectedSlotID = "".obs;
  var selectedSlotDate = "".obs;
  var selectedStartTime = "".obs;
  var selectedEndTime = "".obs;
  var categoryList = <Category>[].obs;
  var bannerListTop = <Slider>[].obs;
  var bannerListTop2 = <Slider>[].obs;
  var itemGroupList = <ItemGroup>[].obs;
  var barcodeScannerText = "".obs;

  var defaultAddressId = "".obs;
  var defaultAddress = "".obs;
  var storeAddress = "".obs;
  var userID = "0".obs;

  var isHomeLoaded = false;
  var loading = false.obs;
  var isPickup = false.obs;
  var languageParam = LanguageParam().obs;
  var languageParamString = "";
  var storeLat, storeLng;

  Future<void> getStorageData() async {
    defaultAddressId.value =
        await StorageManager.readData(StorageManager.keyDefaultAddressId);
    if (defaultAddressId.value.isEmpty) {
      storeAddress.value =
          await StorageManager.readData(StorageManager.keyStoreAddress);
      storeLat =
          await StorageManager.readData(StorageManager.keyStoreLat).toString();
      storeLng =
          await StorageManager.readData(StorageManager.keyStoreLng).toString();
      getSlot(storeLat, storeLng, storeAddress.value);
    } else {
      storeAddress.value =
          await StorageManager.readData(StorageManager.keyDefaultAddress);

      getSlot(
          await StorageManager.readData(StorageManager.keyDefaultAddressLat),
          await StorageManager.readData(StorageManager.keyDefaultAddressLng),
          await StorageManager.readData(StorageManager.keyDefaultAddress));
    }

    defaultAddressId.value =
        await StorageManager.readData(StorageManager.keyDefaultAddressId);

    userID.value = await StorageManager.getUserID();
    isPickup.value =
        await StorageManager.readDataBool(StorageManager.keyIsPickup);
    languageParamString =
        await StorageManager.readData(StorageManager.keyLanguageParams);
    if (languageParamString.isNotEmpty)
      languageParam.value =
          LanguageParam.fromJson(json.decode(languageParamString));
  }

  Future<void> getHomeData() async {
    try {
      if (!isHomeLoaded) loading.value = true;
      var response = await BaseClient().get(home);
      loading.value = false;
      if (response != null) {
        var responseData =
            HomeResponse.fromJson(json.decode(response.toString()));
        categoryList.clear();
        bannerListTop.clear();
        bannerListTop2.clear();
        itemGroupList.clear();

        if (responseData.code == "200") {
          categoryList.addAll(responseData.res!.category as List<Category>);

          responseData.res!.slider!.forEach((element) {
            if (element.banner_type == "Top")
              bannerListTop.add(element);
            else if (element.banner_type == "Below Slider")
              bannerListTop2.add(element);
          });

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
      error.printError();
      isHomeLoaded = false;
      // CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
  }

  Future<void> getLanguageParam(String language, String id) async {
    try {
      var params = {"id": id};
      var response = await BaseClient().post(lang_paramsUrl, params);
      if (response != null) {
        var responseData =
            LanguageParamResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          languageParam.value = responseData.res!.first;

          StorageManager.saveData(StorageManager.keyLanguageParams,
              json.encode(languageParam.value));

          if (language == "Arabic")
            updateLanguage(Locale('ar', 'SA'));
          else
            updateLanguage(Locale('en', 'US'));

          Get.deleteAll();
        }
      }
    } catch (error) {
      error.printError();
    }
  }

  updateLanguage(Locale locale) {
    Get.updateLocale(locale);
    AppUtils.navigateToPageRemoveUntil(BottomNavBar());
  }

  Future<void> getSlot(
      String latitude, String longitude, String address) async {
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

            storeAddress.value = address;
            isPickup.value = false;
            getHomeData();
            // Navigator.pop(Get!.context);
          } else {
            StorageManager.saveData(
                StorageManager.keyStoreID, responseData.res?.first?.storeid);

            StorageManager.saveData(StorageManager.keyStoreID, "10");
            StorageManager.saveData(StorageManager.keyStoreAddress, address);
            StorageManager.saveData(StorageManager.keyIsPickup, false);

            storeAddress.value = address;
            isPickup.value = false;
            getHomeData();
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
