import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rawabi/utils/colors.dart';

import '../../controller/addAddressController.dart';
import '../../controller/homeController.dart';
import '../../widget/commonwidget/reusable_button1.dart';
import '../../widget/commonwidget/reusable_text.dart';
import '../../widget/commonwidget/reusable_textformfield.dart';

// ignore: must_be_immutable
class AddNewAddressesScreen extends StatelessWidget {
  var lat, lng;
  final homeController = Get.put(HomeController());

  AddNewAddressesScreen({super.key, this.lat, this.lng});

  final addAddressController = Get.put(AddAddressController());
  var _country = countries.firstWhere((element) => element.code == "QA");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 24,
            ),
          ),
          centerTitle: true,
          title: ReusableText(
            title: homeController.languageParam.value.addNewAddress,
            size: 18,
            weight: FontWeight.bold,
          ),
        ),
        body: Obx(
          () => addAddressController.loading.value
              ? SizedBox(
                  height: MediaQuery.of(context).size.height - 280,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    child: Form(
                      key: addAddressController.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          ReusableText(
                            title: homeController
                                    .languageParam.value.addressName ??
                                "",
                            size: 14,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ReusableTextForm(
                            fillColor: lightGreyColor,
                            controller:
                                addAddressController.addressNameController,
                            borderRadius: 6,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return homeController
                                    .languageParam.value.pleaseEnterAddress;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          IntlPhoneField(
                            controller: addAddressController.mobileController,
                            validator: (value) {
                              if (value == null) {
                                return homeController
                                    .languageParam.value.enterMobileNumber;
                              }
                              return null;
                            },
                            onCountryChanged: (country) => _country = country,
                            //autovalidateMode: AutovalidateMode.onUserInteraction,
                            //controller: mobileController,
                            initialCountryCode: "QA",
                            disableLengthCheck: false,
                            showDropdownIcon: true,
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            dropdownIconPosition: IconPosition.trailing,
                            decoration: InputDecoration(
                              fillColor: lightGreyColor,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              hintText: homeController
                                      .languageParam.value.mobileNumber ??
                                  "",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ReusableText(
                            title:
                                homeController.languageParam.value.zone ?? "",
                            size: 14,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ReusableTextForm(
                            fillColor: lightGreyColor,
                            controller: addAddressController.zoneController,
                            keyboardType: TextInputType.number,
                            borderRadius: 6,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return homeController
                                    .languageParam.value.pleaseEnterZone;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ReusableText(
                            title: homeController
                                    .languageParam.value.buildingNumber ??
                                "",
                            size: 14,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ReusableTextForm(
                            fillColor: lightGreyColor,
                            borderRadius: 6,
                            controller: addAddressController.buildingController,
                            keyboardType: TextInputType.number,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return homeController.languageParam.value
                                    .pleaseEnterBuildingNumber;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ReusableText(
                            title: homeController.languageParam.value
                                    .apartmentBuildingBlock ??
                                "",
                            size: 14,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ReusableTextForm(
                            fillColor: lightGreyColor,
                            controller:
                                addAddressController.apartmentController,
                            borderRadius: 6,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            validator: (value) {
                              if (value == null) {
                                return homeController.languageParam.value
                                    .pleaseEnterApartmentBuildingBlock;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ReusableText(
                            title:
                                homeController.languageParam.value.floor ?? "",
                            size: 14,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ReusableTextForm(
                            fillColor: lightGreyColor,
                            borderRadius: 6,
                            controller: addAddressController.floorController,
                            keyboardType: TextInputType.text,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ReusableText(
                            title: homeController.languageParam.value.address ??
                                "",
                            size: 14,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ReusableTextForm(
                            fillColor: lightGreyColor,
                            controller: addAddressController.addressController,
                            borderRadius: 6,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return homeController
                                    .languageParam.value.pleaseEnterAddress;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ReusableText(
                            title:
                                homeController.languageParam.value.locationType,
                            size: 14,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: ListTile(
                                  title: Text(homeController
                                      .languageParam.value.work
                                      .toString()),
                                  leading: Radio<int>(
                                    value: 1,
                                    activeColor: primaryColor,
                                    groupValue: addAddressController
                                        .selectedOption.value,
                                    onChanged: (value) {
                                      addAddressController
                                          .selectedOption.value = value!;
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                child: ListTile(
                                  title: Text(homeController
                                      .languageParam.value.home
                                      .toString()),
                                  leading: Radio<int>(
                                    value: 2,
                                    activeColor: primaryColor,
                                    groupValue: addAddressController
                                        .selectedOption.value,
                                    onChanged: (value) {
                                      addAddressController
                                          .selectedOption.value = value!;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 45,
                            child: ReusableButton1(
                                title: homeController
                                    .languageParam.value.addNewAddress,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                onPressed: () {
                                  if (addAddressController.formKey.currentState!
                                      .validate()) {
                                    addAddressController.saveAddressList(
                                        lat, lng);
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ));
  }
}
