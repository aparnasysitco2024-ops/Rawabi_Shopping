import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as Mateial;
import 'package:get/get.dart';
import 'package:rawabi/model/response/baseResponse.dart';
import 'package:rawabi/model/response/languageParamResponse.dart';
import 'package:rawabi/model/response/popupBannerResponse.dart';
import 'package:rawabi/widget/commonWidget/reusable_button1.dart';
import 'package:rawabi/widget/commonWidget/reusable_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/response/homeResponse.dart';
import '../model/response/slotResponse.dart';
import '../screen/navigator/bottomNavBar.dart';
import '../utils/app_utils.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';
import '../utils/storage_manager.dart';
import 'cartController.dart';

class HomeController extends GetxController {
  // final cartController = Get.put(CartController());

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
  var storeName = "".obs;
  var storeID = "".obs;
  var userID = "0".obs;

  var isHomeLoaded = false.obs;
  var loading = false.obs;
  var isPickup = false.obs;
  var languageParam = LanguageParam().obs;
  var languageParamString = "";
  var storeLat, storeLng;
  var popUpBannersList = <PopUpBanners>[].obs;
  bool isPopUpLoaded = false;
  bool isSavedAddressSlotLoaded = false;

  Future<void> getStorageData() async {
    userID.value = await StorageManager.getUserID();

    languageParamString =
        await StorageManager.readData(StorageManager.keyLanguageParams);
    if (languageParamString.isNotEmpty)
      languageParam.value =
          LanguageParam.fromJson(json.decode(languageParamString));

    isPickup.value =
        await StorageManager.readDataBool(StorageManager.keyIsPickup);

    if (!isPickup.value) {
      defaultAddressId.value =
          await StorageManager.readData(StorageManager.keyDefaultAddressId);
      defaultAddress.value =
          await StorageManager.readData(StorageManager.keyDefaultAddress);
      storeName.value =
          await StorageManager.readData(StorageManager.keyStoreName);
      // getSlot(
      //     await StorageManager.readData(StorageManager.keyDefaultAddressLat),
      //     await StorageManager.readData(StorageManager.keyDefaultAddressLng),
      //     defaultAddress.value);

      //   if (defaultAddressId.value.isEmpty) {
      //     storeAddress.value =
      //         await StorageManager.readData(StorageManager.keyStoreAddress);
      //     storeID.value =
      //     await StorageManager.readData(StorageManager.keyStoreID);
      //
      //     // storeLat = await StorageManager.readData(StorageManager.keyStoreLat)
      //     //     .toString();
      //     storeLat =await StorageManager.getStoreLat();
      //     storeLng = await StorageManager.getStoreLng();
      //     getSlot(storeLat, storeLng, storeAddress.value);
      //   } else {
      //     storeAddress.value =
      //         await StorageManager.readData(StorageManager.keyDefaultAddress);
      //     storeID.value =
      //     await StorageManager.readData(StorageManager.keyStoreID);
      //
      //     getSlot(
      //         await StorageManager.readData(StorageManager.keyDefaultAddressLat),
      //         await StorageManager.readData(StorageManager.keyDefaultAddressLng),
      //         await StorageManager.readData(StorageManager.keyDefaultAddress));
      //   }
      //
      //   defaultAddressId.value =
      //       await StorageManager.readData(StorageManager.keyDefaultAddressId);
      // }else{
      //   storeAddress.value =
      //   await StorageManager.readData(StorageManager.keyStoreAddress);
      //   storeID.value =
      //   await StorageManager.readData(StorageManager.keyStoreID);
    }
  }

  moveToProductList(BuildContext context, String catID, String subCatID,
      String subSubCatID, String subSubSubCatID, String brandID) {
    Navigator.pushNamed(
      context,
      '/ProductsByCategory',
      arguments: {
        'catId': catID,
        'subCatId': subCatID,
        'subSubCatId': subSubCatID,
        'subSubSubCatId': subSubSubCatID,
        'brandId': brandID,
      },
    );
  }

  moveToProductDetails(BuildContext context, String productID) {
    Navigator.pushNamed(
      context,
      '/ProductDetailsScreen',
      arguments: {
        'productID': productID,
      },
    );
  }

  Future<void> getSavedAddressSlot() async {
    isSavedAddressSlotLoaded = true;
    isPickup.value =
        await StorageManager.readDataBool(StorageManager.keyIsPickup);

    if (!isPickup.value) {
      defaultAddressId.value =
          await StorageManager.readData(StorageManager.keyDefaultAddressId);
      if (defaultAddressId.value.isEmpty) {
        storeAddress.value =
            await StorageManager.readData(StorageManager.keyStoreAddress);
        storeID.value =
            await StorageManager.readData(StorageManager.keyStoreID);
        storeName.value =
            await StorageManager.readData(StorageManager.keyStoreName);

        // storeLat = await StorageManager.readData(StorageManager.keyStoreLat)
        //     .toString();
        storeLat = await StorageManager.getStoreLat();
        storeLng = await StorageManager.getStoreLng();
        getSlot(storeLat, storeLng, storeAddress.value);
      } else {
        storeAddress.value =
            await StorageManager.readData(StorageManager.keyDefaultAddress);
        storeID.value =
            await StorageManager.readData(StorageManager.keyStoreID);
        storeName.value =
            await StorageManager.readData(StorageManager.keyStoreName);

        getSlot(
            await StorageManager.readData(StorageManager.keyDefaultAddressLat),
            await StorageManager.readData(StorageManager.keyDefaultAddressLng),
            await StorageManager.readData(StorageManager.keyDefaultAddress));
      }

      defaultAddressId.value =
          await StorageManager.readData(StorageManager.keyDefaultAddressId);
    } else {
      storeAddress.value =
          await StorageManager.readData(StorageManager.keyStoreAddress);
      storeID.value = await StorageManager.readData(StorageManager.keyStoreID);
      storeName.value =
          await StorageManager.readData(StorageManager.keyStoreName);
    }
  }

  Future<void> getHomeData() async {
    try {
      if (!isHomeLoaded.value) loading.value = true;
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

          isHomeLoaded.value = true;
        } else {
          isHomeLoaded.value = false;
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        isHomeLoaded.value = false;
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      error.printError();
      isHomeLoaded.value = false;
      // CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
  }

  Future<void> clearCart() async {
    StorageManager.saveData(StorageManager.keyDefaultAddressId, "");
    StorageManager.saveData(StorageManager.keyDefaultAddress, "");

    try {
      var response = await BaseClient().get(clearCartUrl);
      if (response != null) {
        var responseData =
            BaseResponse.fromJson(json.decode(response.toString()));

        if (responseData.code == "200") {
          final cartController = Get.put(CartController());
          cartController.getCartList();
        } else {}
      }
    } catch (error) {
      error.printError();
      // CommonUtils.showErrorDialog(error.toString());
    }
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
            if (storeID.value != responseData.res?.first?.storeid) {
              clearCart();
            }
            StorageManager.saveData(
                StorageManager.keyStoreID, responseData.res?.first?.storeid);

            StorageManager.saveData(StorageManager.keyStoreName,
                responseData.res?.first?.storename);
            StorageManager.saveData(StorageManager.keyStoreAddress, address);
            StorageManager.saveData(StorageManager.keyIsPickup, false);

            storeAddress.value = address;
            storeID.value =
                await StorageManager.readData(StorageManager.keyStoreID);
            storeName.value =
                await StorageManager.readData(StorageManager.keyStoreName);
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

  Future<void> showUpdateVersionDialog(BuildContext context) async {
    Mateial.showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PopScope(
            onPopInvoked: (didPop) => Future.value(false),
            canPop: false,
            child: Mateial.AlertDialog(
              title: new Text("New version available"),
              content: new SingleChildScrollView(
                child: ReusableText(
                  title: "Please update to the latest version of the app.",
                  textAlign: TextAlign.center,
                ),
              ),
              actions: <Widget>[
                new ReusableButton1(
                  title: "Update",
                  onPressed: () {
                    _launchAppOrPlayStore();
                  },
                ),
              ],
            ));
      },
    );

    // return Mateial.showDialog<void>(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return Mateial.AlertDialog(
    //       title: const Text("New version available"),
    //       content: SingleChildScrollView(
    //         child: ListBody(
    //           children: <Widget>[
    //             Text("Please update to the latest version of the app."),
    //           ],
    //         ),
    //       ),
    //       actions: <Widget>[
    //         // A "skip" button is only shown if it's a recommended upgrade
    //         isSkippable
    //             ? Mateial.TextButton(
    //           child: const Text('Skip'),
    //           onPressed: () {
    //           },
    //         )
    //             : Container(),
    //         Mateial.TextButton(
    //           child: const Text('Update'),
    //           onPressed: () {
    //             _launchAppOrPlayStore();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  void _launchAppOrPlayStore() {
    final appId = Platform.isAndroid ? 'com.app.rawabi' : 'com.app.alrawabi';
    final url = Uri.parse(
      Platform.isAndroid
          ? "market://details?id=$appId"
          : "https://apps.apple.com/app/id$appId",
    );
    launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}
