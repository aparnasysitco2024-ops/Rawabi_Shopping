import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/signUpController.dart';
import 'package:rawabi/screen/splashScreen.dart';
import 'package:rawabi/utils/commonUtils.dart';
import 'package:rawabi/widget/commonwidget/reusable_button.dart';

import '../utils/app_utils.dart';
import '../utils/colors.dart';
import '../widget/commonwidget/reusable_textformfieldbox.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final signupController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
                                AppUtils.navigateToPageReplace(
                                     SplashScreen());
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
                      controller: signupController.nameController,
                      fillColor: silver,
                      keyboardType: TextInputType.name,
                      hintText: "Enter Your Name".tr,
                      validator: (value) {
                        value!.isEmpty ? "Please Enter Your Name".tr : null;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ReusableTextFormBox(
                      controller: signupController.mobileController,
                      fillColor: silver,
                      keyboardType: TextInputType.phone,
                      hintText: "Enter Mobile number".tr,
                      validator: (value) {
                        value!.isEmpty ? "Please enter Mobile number".tr : null;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ReusableTextFormBox(
                      controller: signupController.emailController,
                      fillColor: silver,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Enter Email".tr,
                      validator: (value) {
                        value!.isEmpty ? "Please enter Email".tr : null;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ReusableButton(
                      onTap: () {
                        if (signupController.nameController.text.isEmpty) {
                          CommonUtils().messageBox("Please enter your name".tr);
                        }else if (signupController.mobileController.text.isEmpty) {
                          CommonUtils().messageBox("Please enter your mobile number".tr);
                        }else if (signupController.emailController.text.isEmpty) {
                          CommonUtils().messageBox("Please enter your email".tr);
                        } else {
                          signupController.signupApi();
                        }
                      },
                      title: "Sign Up".tr,
                      borderRadius: 7.0,
                    )
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
