import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:rawabi/model/response/searchResponse.dart';
import 'package:rawabi/utils/constants.dart';
import '../model/response/products.dart';
import '../utils/commonUtils.dart';
import '../utils/http_client/base_client.dart';

class SearchResultController extends GetxController {
  var isLoaded = false;
  var loading = false.obs;
  var searchType = "word".obs;
  var searchString = "Search".obs;
  var searchProductList = <Products>[].obs;
  var searchTextController = TextEditingController();

  SearchResultController();

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.'.tr;
    }
    searchType.value = "barcode";
    searchString.value = barcodeScanRes;
    await getProductsByBarcodeSearch();
  }

  Future<void> getProductsByWordSearch(String query, catID) async {
    if (query.isNotEmpty) {
      try {
        loading.value = true;
        var request = {"word": query, "catid": catID};
        var response = await BaseClient().post(searchWord, request);
        //loading.value = false;
        searchProductList.clear();
        if (response != null) {
          var responseData =
              SearchResponse.fromJson(json.decode(response.toString()));
          // print(responseData.res?.products.toString());
          //searchProductList.clear();

          if (responseData.code == "200") {
            if (responseData.res?.products != null) {
              searchProductList
                  .addAll(responseData.res?.products as List<Products>);
            }
            loading.value = false;
            isLoaded = true;
          } else {
            isLoaded = false;
            CommonUtils.showErrorDialog(responseData.toString());
          }
        } else {
          isLoaded = false;
        }
      } catch (error) {
        isLoaded = false;
        error.printError();
        // CommonUtils.showErrorDialog(error.toString());
      }
      loading.value = false;
    } else {
      searchProductList.clear();
    }
  }

  Future<void> getProductsByBarcodeSearch() async {
    try {
      if (searchString.value != "-1") {
        var request = {
          "barcode": searchString.value,
        };
        if (!isLoaded) loading.value = true;
        searchProductList.clear();
        print("loading barcode result");
        var response = await BaseClient().post(searchBarcode, request);
        loading.value = false;
        if (response != null) {
          var responseData =
              SearchBarcodeResponse.fromJson(json.decode(response.toString()));

          if (responseData.code == "200") {
            if (responseData.products != null) {
              searchProductList.addAll(responseData.products as List<Products>);
              print("printing $searchProductList");
              print(searchProductList.length);
            }
            isLoaded = true;
          } else {
            isLoaded = false;
            CommonUtils.showErrorDialog(responseData.toString());
          }
        } else {
          isLoaded = false;
        }
      } else {
        searchProductList.clear();
      }
    } catch (error) {
      isLoaded = false;
      error.printError();
      // CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
  }
}
