import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rawabi/utils/colors.dart';

import '../../controller/addAddressController.dart';
import '../../widget/commonwidget/reusable_button1.dart';
import '../../widget/commonwidget/reusable_text.dart';
import '../../widget/commonwidget/reusable_textformfield.dart';

class AddNewAddressesScreen extends StatelessWidget {
  AddNewAddressesScreen({super.key});

  final addAddressController = Get.put(AddAddressController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      body: Obx(() => SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: white,
                  padding: const EdgeInsets.only(bottom: 0),
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Divider(
                        thickness: 1,
                        color: lightGreyColor,
                      ),
                      Container(
                        height: 40,
                        width: double.maxFinite,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Stack(
                          children: [
                            Center(
                              child: ReusableText(
                                title: "Add New Address".tr,
                                size: 18,
                                weight: FontWeight.bold,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 0,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: blackLight,
                                  size: 24,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        color: lightGreyColor,
                      ),
                    ],
                  ),
                ),
                addAddressController.loading.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height - 280,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Form(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ReusableTextForm(
                                    fillColor: lightGreyColor,
                                    controller: addAddressController
                                        .addressNameController,
                                    borderRadius: 6,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    hintText: "Address Name".tr,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  IntlPhoneField(
                                    controller:
                                        addAddressController.mobileController,
                                    onChanged: (phone) {
                                      // mobile = phone.completeNumber.split("+").last;
                                      //mobile = phone.number;
                                    },
                                    //controller: mobileController,
                                    initialCountryCode: "QA",
                                    disableLengthCheck: true,
                                    showDropdownIcon: true,
                                    dropdownIconPosition: IconPosition.trailing,
                                    decoration: const InputDecoration(
                                      fillColor: lightGreyColor,
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      hintText: "Mobile Number",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ReusableTextForm(
                                    fillColor: lightGreyColor,
                                    controller:
                                        addAddressController.zoneController,
                                    keyboardType: TextInputType.number,
                                    borderRadius: 6,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    hintText: "Zone".tr,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ReusableTextForm(
                                    fillColor: lightGreyColor,
                                    borderRadius: 6,
                                    controller:
                                        addAddressController.buildingController,
                                    keyboardType: TextInputType.number,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    hintText: "Building Number".tr,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ReusableTextForm(
                                    fillColor: lightGreyColor,
                                    controller: addAddressController
                                        .apartmentController,
                                    borderRadius: 6,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    hintText: "Apartment/Building/Block".tr,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ReusableTextForm(
                                    fillColor: lightGreyColor,
                                    borderRadius: 6,
                                    controller:
                                        addAddressController.floorController,
                                    keyboardType: TextInputType.number,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    hintText: "Floor".tr,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ReusableTextForm(
                                    fillColor: lightGreyColor,
                                    controller:
                                        addAddressController.addressController,
                                    borderRadius: 6,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    hintText: "Address ".tr,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ReusableText(
                                    title: "Location Type".tr,
                                    size: 14,
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: ListTile(
                                          title: const Text('Work'),
                                          leading: Radio<int>(
                                            value: 1,
                                            activeColor: primaryColor,
                                            groupValue: addAddressController
                                                .selectedOption.value,
                                            onChanged: (value) {
                                              addAddressController
                                                  .selectedOption
                                                  .value = value!;
                                            },
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: ListTile(
                                          title: const Text('Home'),
                                          leading: Radio<int>(
                                            value: 2,
                                            activeColor: primaryColor,
                                            groupValue: addAddressController
                                                .selectedOption.value,
                                            onChanged: (value) {
                                              addAddressController
                                                  .selectedOption
                                                  .value = value!;
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
                                      title: "Add Address".tr,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      onPressed: () {
                                        addAddressController.saveAddressList();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          )),
    );
  }
}
