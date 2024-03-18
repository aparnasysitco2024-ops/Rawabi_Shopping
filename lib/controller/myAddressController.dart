import 'dart:convert';

import 'package:get/get.dart';
import 'package:rawabi/model/baseResponse.dart';

import '../model/addressListResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class MyAddressController extends GetxController {
  var loading = false.obs;

  MyAddressController();

  var addressListData = <AddressList>[].obs;

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> getAddressList() async {
    try {
      loading.value = true;
      var response = await BaseClient().get(addressList);
      loading.value = false;
      if (response != null) {
        addressListData.clear();
        var responseData =
            AddressListResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          addressListData.addAll(responseData.res as Iterable<AddressList>);
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

  Future<void> deleteAddress(var addressId) async {
    try {
      loading.value = true;
      var request = {"address_id": addressId};

      var response = await BaseClient().post(deleteaddress, request);
      loading.value = false;
      if (response != null) {
        var responseData =
            BaseResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          getAddressList();
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
}
