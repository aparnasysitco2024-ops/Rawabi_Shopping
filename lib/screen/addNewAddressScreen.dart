import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rawabi/utils/colors.dart';
import '../widget/commonwidget/reusable_button1.dart';
import '../widget/commonwidget/reusable_text.dart';
import '../widget/commonwidget/reusable_textformfield.dart';

class AddNewAddressesScreen extends StatelessWidget {
  const AddNewAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedOption = 1;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: white,
              padding: const EdgeInsets.all(0),
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
                  SizedBox(
                    height: 45,
                    child: ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -3),
                      leading: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: blackLight,
                          size: 24,
                        ),
                      ),
                      title: ReusableText(
                        title: "Add New Address".tr,
                        size: 18,
                        weight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    color: lightGreyColor,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 12),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableTextForm(
                          fillColor: lightGreyColor,
                          borderRadius: 6,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          hintText: "Mr.".tr,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReusableTextForm(
                          fillColor: lightGreyColor,
                          borderRadius: 6,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          hintText: "Surname".tr,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReusableTextForm(
                          fillColor: lightGreyColor,
                          borderRadius: 6,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          hintText: "Name".tr,

                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        IntlPhoneField(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReusableTextForm(
                          fillColor: lightGreyColor,
                          borderRadius: 6,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          hintText: "Flat/House Number".tr,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReusableTextForm(
                          fillColor: lightGreyColor,
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
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          hintText: "Place".tr,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReusableTextForm(
                          fillColor: lightGreyColor,
                          borderRadius: 6,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          hintText: "City".tr,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReusableTextForm(
                          fillColor: lightGreyColor,
                          borderRadius: 6,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          hintText: "Landmark(Optional)".tr,
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
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    selectedOption = value!;
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              child: ListTile(
                                title: const Text('Home'),
                                leading: Radio<int>(
                                  value: 2,
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    selectedOption = value!;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 80,),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              height: 87,
                              color: white,
                              padding: const EdgeInsets.only(
                                  left: 18, top: 10, right: 18, bottom: 33),
                              child: ReusableButton1(
                                onPressed: () {

                                },
                                title: "Add Address",
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
