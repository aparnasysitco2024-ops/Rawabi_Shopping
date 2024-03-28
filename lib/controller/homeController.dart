import 'dart:convert';

import 'package:get/get.dart';

import '../model/homeResponse.dart';
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

  var isExpress = true.obs;
  var categoryList = <Category>[].obs;
  var bannerList = <Slider>[].obs;
  var itemGroupList = <ItemGroup>[].obs;
  var barcodeScannerText = "".obs;

  var bannerList2 = [
    'assets/images/apple.png',
    'assets/images/banner.png',
    'assets/images/banner.png'
  ].obs;

  var defaultAddressId = "".obs;
  var defaultAddress = "".obs;
  var storeAddress = "".obs;
  var userID = "0".obs;

  var isHomeLoaded = false;
  var loading = false.obs;



  Future<void> getDefaultAddress() async {
    storeAddress.value =
        await StorageManager.readData(StorageManager.keyStoreAddress);
    defaultAddressId.value =
        await StorageManager.readData(StorageManager.keyDefaultAddressId);
    defaultAddress.value =
        await StorageManager.readData(StorageManager.keyDefaultAddress);

    userID.value = await StorageManager.getUserID();
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
        bannerList.clear();
        itemGroupList.clear();

        if (responseData.code == "200") {
          categoryList.addAll(responseData.res!.category as List<Category>);
          bannerList.addAll(responseData.res!.slider as List<Slider>);
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
}
