import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rawabi/screen/changePasswordScreen.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/ReusableBorderContainer.dart';
import 'package:rawabi/widget/commonwidget/profile_tile.dart';
import 'package:rawabi/widget/commonwidget/reusable_button1.dart';
import '../utils/app_utils.dart';
import '../widget/commonwidget/reusable_text.dart';
import '../widget/commonwidget/reusable_textformfield.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: silver,
      body: SizedBox(
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
                            title: "My Profile".tr,
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
            Container(
              height: 225,
              width: double.maxFinite,
              color: white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
                child: Column(
                  children: [
                    const ReusableBorderContainer(
                      borderColor: silver,
                      height: 46,
                      child: ReusableTextForm(
                        hintText: "Ilyas",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ReusableBorderContainer(
                      borderColor: silver,
                      height: 46,
                      child: ReusableTextForm(
                        hintText: "Doodler",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.maxFinite,
                      child: Stack(children: [
                        Expanded(
                          child: IntlPhoneField(
                            onChanged: (phone) {
                              // mobile = phone.completeNumber.split("+").last;
                              //mobile = phone.number;
                            },
                            //controller: mobileController,
                            initialCountryCode: "QA",
                            disableLengthCheck: true,
                            showDropdownIcon: true,
                            dropdownIconPosition: IconPosition.trailing,
                            decoration:  InputDecoration(
                              fillColor: white,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              hintText: '564266125',
                              border: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide(color: lightGreyColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide:
                                    const BorderSide(color: silver)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color: silver, width: 1)),
                            ),

                          ),

                          /*InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                            },
                            onInputValidated: (bool value) {
                              print(value);
                            },
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                              useBottomSheetSafeArea: true,
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: TextStyle(color: grey),

                            initialValue: PhoneNumber(
                                phoneNumber: "564266125", isoCode: "QA"),
                            hintText: '564266125',
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: grey,
                            ),
                            //textFieldController: controller,
                            formatInput: true,
                            keyboardType: TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(color: silver)),
                            inputDecoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide:
                                        const BorderSide(color: silver)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color: silver, width: 1))),
                            onSaved: (PhoneNumber number) {
                              print('On Saved: $number');
                            },
                          ),*/
                        ),
                        Expanded(
                          child: Positioned(
                            right: 15,
                            top: 10,
                            child: GestureDetector(
                              onTap: () {},
                              child: ReusableText(
                                title: "Verify".tr,
                                color: blue,
                                size: 16,
                                weight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      ]),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 74,
              width: double.maxFinite,
              color: white,
              padding: const EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 20),
              child: const ReusableButton1(
                title: "Save and Update",
              ),
            ),
            Container(color: silver,height: 3,),
            Container(
              alignment: Alignment.bottomCenter,
              //height: 130,
              width: double.maxFinite,
              color: white,
              padding: const EdgeInsets.only(left: 18,right: 18,top: 1,bottom: 5),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        AppUtils.navigateToPage(const ChangePasswordScreen());
                      },
                      child: const ProfileTile(image: "assets/icons/lock.svg", title: "Change Password")),
                  const Divider(thickness: 1,),
                  const ProfileTile(image: "assets/icons/delete.svg", title: "Delete Account"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
