import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rawabi/model/baseResponse.dart';
import 'package:rawabi/model/request/addAddressRequest.dart';

import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';
import 'myAddressController.dart';

class AddAddressController extends GetxController {
  var loading = false.obs;

  AddAddressController();

  final myAddressController = Get.put(MyAddressController());

  var addressNameController = TextEditingController();
  var mobileController = TextEditingController();
  var zoneController = TextEditingController();
  var buildingController = TextEditingController();
  var apartmentController = TextEditingController();
  var floorController = TextEditingController();
  var addressController = TextEditingController();
  var typeController = TextEditingController();
  var selectedOption = 2.obs;

  @override
  onInit() async {
    super.onInit();
  }

  Future<void> saveAddressList() async {
    try {
      loading.value = true;
      AddAddressRequest addAddressRequest = AddAddressRequest();
      addAddressRequest.addressName = addressNameController.text;
      addAddressRequest.phone = mobileController.text;
      addAddressRequest.zone = zoneController.text;
      addAddressRequest.houseBuilding = buildingController.text;
      addAddressRequest.apartmentOffice = apartmentController.text;
      addAddressRequest.floor = floorController.text;
      addAddressRequest.addressInstruction = addressController.text;
      addAddressRequest.address = addressController.text;
      addAddressRequest.type = selectedOption.value == 1 ? "Work" : "Home";

      var response = await BaseClient().post(addaddressUrl, addAddressRequest);
      loading.value = false;
      if (response != null) {
        var responseData =
            BaseResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          myAddressController.getAddressList();
          CommonUtils().messageBox(responseData.message.toString());
          Navigator.pop(Get.context!);
          Get.delete<AddAddressController>();
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
}
