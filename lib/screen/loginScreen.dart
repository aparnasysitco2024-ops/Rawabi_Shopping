import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/loginController.dart';
import 'package:rawabi/utils/commonUtils.dart';
import 'package:rawabi/widget/commonwidget/reusable_button.dart';

import '../utils/colors.dart';
import '../widget/commonwidget/reusable_textformfieldbox.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginController.formKey,
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/splash.png"),
                        fit: BoxFit.cover),
                  ),
                  child: Column(children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: SizedBox(
                            height: 30,
                            child: ReusableButton(
                                padding: 8.0,
                                textSize: 9.0,
                                buttonColor: Colors.white,
                                textColor: Colors.black,
                                width: 70.0,
                                onTap: () {
                                  // AppUtils.navigateToPageReplace(
                                  //      BottomNavBar());
                                  Navigator.pop(context);
                                },
                                title: "Skip".tr),
                          ),
                        )),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 70,
                          ),
                          SvgPicture.asset("assets/icons/logo.svg"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ]),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ReusableTextFormBox(
                        controller: loginController.mobileController,
                        fillColor: silver,
                        hintText: "Enter Mobile number".tr,
                        validator: (value) {
                          value!.isEmpty
                              ? "Please enter Mobile number or Email".tr
                              : null;
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ReusableButton(
                        onTap: () {
                          if (loginController.mobileController.text.isEmpty) {
                            CommonUtils().messageBox(
                                "Please Enter Mobile number or Email".tr);
                          } else {
                            loginController.checkUser();
                          }
                        },
                        title: "Proceed".tr,
                        borderRadius: 7.0,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
