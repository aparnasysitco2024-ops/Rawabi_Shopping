import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:rawabi/model/response/searchResponse.dart';
import 'package:rawabi/utils/constants.dart';
import 'package:rawabi/utils/storage_manager.dart';

import '../model/response/autoSuggestionResponse.dart';
import '../model/response/products.dart';
import '../utils/commonUtils.dart';
import '../utils/http_client/base_client.dart';

class SearchResultController extends GetxController {
  var isLoaded = false;
  var loading = false.obs;
  var searchType = "word".obs;
  var searchString = "Search".obs;
  var searchProductList = <Products>[].obs;
  var searchSuggestionList = <Words>[].obs;
  var searchSuggestionCategoryList = <Categories>[].obs;
  var searchTextController = TextEditingController();
  var recentSearch = <String>[].obs;

  SearchResultController();

  @override
  onInit() async {
    super.onInit();

    var recentSearchData =
        await StorageManager.readData(StorageManager.keyRecentSearch);

    if (recentSearchData.isNotEmpty) recentSearch.clear();
    recentSearchData.split(",").forEach(
      (element) {
        recentSearch.add(element);
      },
    );
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

  Future<void> getProductsByWordSearch(String query, String catID) async {
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

  Future<void> getAutoSuggestion(String query, String catID) async {
    if (query.length > 2) {
      try {
        loading.value = true;
        var request = {"word": query, "catid": catID};
        var response = await BaseClient().post(autoSuggestUrl, request);
        //loading.value = false;
        searchSuggestionList.clear();
        searchSuggestionCategoryList.clear();
        if (response != null) {
          var responseData =
              AutoSuggestionResponse.fromJson(json.decode(response.toString()));
          // print(responseData.res?.products.toString());
          //searchProductList.clear();

          if (responseData.code == "200") {
            if (responseData.words != null) {
              searchSuggestionList.addAll(responseData.words as List<Words>);
            }
            if (responseData.categories != null) {
              searchSuggestionCategoryList
                  .addAll(responseData.categories as List<Categories>);
            }
            if (responseData.recentWords != null) {
              StorageManager.saveData(
                  StorageManager.keyRecentSearch, responseData.recentWords);

              var splitList = responseData.recentWords!.split(",");
              recentSearch.clear();
              splitList.forEach(
                (element) {
                  recentSearch.add(element);
                },
              );
            }
            loading.value = false;
            isLoaded = true;
          } else {
            searchSuggestionList.clear;
            searchSuggestionCategoryList.clear;
            isLoaded = false;
            // CommonUtils.showErrorDialog(responseData.toString());
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
      searchSuggestionList.clear;
      searchSuggestionCategoryList.clear();
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
