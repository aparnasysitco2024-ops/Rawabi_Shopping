import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:rawabi/model/searchResponse.dart';
import 'package:rawabi/utils/constants.dart';
import '../model/products.dart';
import '../utils/commonUtils.dart';
import '../utils/http_client/base_client.dart';

class SearchResutController extends GetxController {
  var isLoaded = false;
  var loading = false.obs;
  var searchType="word".obs;
  var searchString="Search".obs;
  var searchProductList = <Products>[].obs;
  var searchTextController = TextEditingController();


  SearchResutController();
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
      barcodeScanRes = 'Failed to get platform version.';
    }
    searchType.value="barcode";
    searchString.value=barcodeScanRes;

  }

  Future<void> getProductsByWordSearch() async {
    try {
      var request;
      var response;

      if (!isLoaded) loading.value = true;
      request = {"word": searchString.value,};
      response = await BaseClient().post(searchWord, request);
      loading.value = false;
      if (response != null) {
        var responseData =
        SearchResponse.fromJson(json.decode(response.toString()));
        print(responseData.products.toString());
        searchProductList.clear();

        if (responseData.code == "200") {

          if (responseData.products != null) {
            searchProductList.addAll(responseData.products as List<Products>);
          }
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
  }

  Future<void> getProductsByBarcodeSearch() async {
    try {

      var request = {
        "barcode": searchString.value,
      };
      if (!isLoaded) loading.value = true;
      print("loading barcode result");
      var response = await BaseClient().post(searchBarcode, request);
      loading.value = false;
      if (response != null) {
        var responseData =
        SearchResponse.fromJson(json.decode(response.toString()));
        searchProductList.clear();

        if (responseData.code == "200") {

          if (responseData.products != null) {
            searchProductList.addAll(responseData.products as List<Products>);
          }
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
  }

}
