import 'dart:convert';

import 'package:get/get.dart';
import 'package:rawabi/model/request/filterRequest.dart';

import '../model/response/categoryResponse.dart';
import '../model/response/products.dart';
import '../model/response/productsResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';
import 'cartController.dart';
import 'homeController.dart';

class ProductController extends GetxController {
  var isLoaded = false;
  var loading = false.obs;
  var isLoadMoreLoading = false.obs;
  var productList = <Products>[].obs;
  var catName = "".obs;
  var sort = "0".obs;
  final homeController = Get.put(HomeController());
  final cartController = Get.put(CartController());
  var subCategoryList = <Category>[].obs;
  var brandId = "0".obs;
  var catID = "0".obs;
  var subCatID = "0".obs;
  var subSubCatID = "0".obs;
  var subSubSubCatID = "0".obs;
  var brandsList = <Brands>[].obs;
  var subCategoryListFilter = <Subcategory>[].obs;
  var price = Price().obs;
  var pageNumber = 1.obs;
  bool isOffer = false;
  var topSelectedCatId = "0".obs;
  var topSelectedCategoryTypeID = category;
  List<String> selectedBrands = [];
  bool isFiltered = false;
  FilterRequest? filterRequest;

  ProductController({this.isOffer = false});

  Future<void> getProductsByCat() async {
    try {
      isFiltered = false;
      if (!isLoaded)
        loading.value = true;
      else
        isLoadMoreLoading.value = true;
      var request = {
        "catid": catID.value,
        "subcatid": subCatID.value,
        "sub-subcatid": subSubCatID.value,
        "sub-sub-subcatid": subSubSubCatID.value,
        "sort": sort.value,
        "page": pageNumber.value.toString()
      };
      var response = await BaseClient()
          .post(isOffer ? discount_products : products, request);
      loading.value = false;
      isLoadMoreLoading.value = false;
      if (response != null) {
        var responseData =
            ProductsResponse.fromJson(json.decode(response.toString()));
        if (pageNumber.value == 1) productList.clear();
        brandsList.clear();
        subCategoryListFilter.clear();

        if (responseData.code == "200") {
          catName.value = responseData.res!.category!.catName!;
          if (responseData.res?.products != null) {
            productList.addAll(responseData.res?.products as List<Products>);
            if (responseData.res?.brands != null)
              brandsList.addAll(responseData.res?.brands as List<Brands>);
            if (responseData.res?.subcategory != null)
              subCategoryListFilter.addAll(
                  responseData.res?.subcategory as Iterable<Subcategory>);

            if (responseData.res?.price != null)
              price.value = responseData.res!.price!;
          }

          isLoaded = true;
        } else {
          isLoaded = false;
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        isLoaded = false;
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      isLoaded = false;
      error.printError();
      // CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
    isLoadMoreLoading.value = false;
  }

  Future<void> getProductsByBrand() async {
    try {
      if (!isLoaded) loading.value = true; else isLoadMoreLoading.value = true;
      var request = {
        "brandid": brandId.value,
        "sort": sort.value,
        "page": pageNumber.value.toString()
      };
      var response = await BaseClient().post(products_byBrandUrl, request);
      loading.value = false;
      isLoadMoreLoading.value = false;
      if (response != null) {
        var responseData =
            ProductsResponse.fromJson(json.decode(response.toString()));
        if (pageNumber.value == 1) productList.clear();
        brandsList.clear();
        subCategoryListFilter.clear();

        if (responseData.code == "200") {
          // catName.value = responseData.res!.category!.catName!;
          if (responseData.res?.products != null) {
            productList.addAll(responseData.res?.products as List<Products>);
            if (responseData.res?.brands != null)
              brandsList.addAll(responseData.res?.brands as List<Brands>);
            if (responseData.res?.subcategory != null)
              subCategoryListFilter.addAll(
                  responseData.res?.subcategory as Iterable<Subcategory>);

            if (responseData.res?.price != null)
              price.value = responseData.res!.price!;
          }

          isLoaded = true;
        } else {
          isLoaded = false;
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        isLoaded = false;
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      isLoaded = false;
      error.printError();
      // CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
    isLoadMoreLoading.value = false;
  }

  Future<void> getSubCategory() async {
    try {
      // loading.value = true;
      subCategoryList.clear();
      String id = "";
      if (subSubSubCatID.value != "0")
        id = subSubSubCatID.value;
      else if (subSubCatID.value != "0")
        id = subSubCatID.value;
      else if (subCatID.value != "0")
        id = subCatID.value;
      else
        id = catID.value;

      var request = {"catid": id};
      var response = await BaseClient().post(subcategoryUrl, request);
      if (response != null) {
        var responseData =
            CategoryResponse.fromJson(json.decode(response.toString()));

        if (responseData.code == "200") {
          subCategoryList.addAll(responseData.res!.category as List<Category>);

          if (subCategoryList.isNotEmpty) {
            if (catID.value == "0") {
              catID.value = subCategoryList[0].catId.toString();
              topSelectedCatId.value = catID.value;
              topSelectedCategoryTypeID = category;
            } else if (subCatID.value == "0") {
              subCatID.value = subCategoryList[0].catId.toString();
              topSelectedCatId.value = subCatID.value;
              topSelectedCategoryTypeID = subCategory;
            } else if (subSubCatID.value == "0") {
              subSubCatID.value = subCategoryList[0].catId.toString();
              topSelectedCatId.value = subSubCatID.value;
              topSelectedCategoryTypeID = subSubCategory;
            } else if (subSubSubCatID.value == "0") {
              subSubSubCatID.value = subCategoryList[0].catId.toString();
              topSelectedCatId.value = subSubSubCatID.value;
              topSelectedCategoryTypeID = subSubSubCategory;
            }
          }

          getProductsByCat();
          // subCategoryList.refresh();
        } else {
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      error.printError();
      // CommonUtils.showErrorDialog(error.toString());
    }
    // loading.value = false;
  }

  Future<void> getFilterData(FilterRequest filterRequest) async {
    try {
      this.filterRequest = filterRequest;
      isFiltered = true;
      if (pageNumber.value == 1)
        loading.value = true;
      else
        isLoadMoreLoading.value = true;
      filterRequest.page = pageNumber.value.toString();
      filterRequest.sort = sort.value;
      var response = await BaseClient().post(filterUrl, filterRequest);
      loading.value = false;
      isLoadMoreLoading.value = false;
      if (response != null) {
        var responseData =
            ProductsResponse.fromJson(json.decode(response.toString()));
        if (pageNumber.value == 1) productList.clear();
        // brandsList.clear();

        if (responseData.code == "200") {
          // catName.value = responseData.res!.category!.catName!;
          if (responseData.res?.products != null &&
              responseData.res!.products!.isNotEmpty) {
            productList.addAll(responseData.res?.products as List<Products>);
            if (responseData.res?.brands != null)
              brandsList.addAll(responseData.res?.brands as List<Brands>);
          }

          isLoaded = true;
        } else {
          isLoaded = false;
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        isLoaded = false;
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      isLoaded = false;
      error.printError();
      // CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
    isLoadMoreLoading.value = false;
  }
}
