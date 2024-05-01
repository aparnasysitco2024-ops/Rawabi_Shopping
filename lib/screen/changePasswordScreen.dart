import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/ReusableBorderContainer.dart';
import 'package:rawabi/widget/commonwidget/reusable_button1.dart';
import '../controller/homeController.dart';
import '../widget/commonwidget/reusable_text.dart';

class ChangePasswordScreen extends StatelessWidget {
   ChangePasswordScreen({super.key});
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    TextEditingController _passwordController = new TextEditingController();
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
                            title: homeController.languageParam.value.changePassword,
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
              // height: 225,
              width: double.maxFinite,
              color: white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     ReusableBorderContainer(
                      borderColor: blue,
                      height: 46,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          labelText:  homeController.languageParam.value.enterCurrentPassword,
                        ),
                        onChanged: (value) {},
                      ),

                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ReusableBorderContainer(
                      borderColor: silver,
                      fillColor: silver,
                      height: 46,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          labelText: homeController.languageParam.value.enterNewPassword,
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LinearProgressIndicator(
                      backgroundColor: skyBlue,
                      value: 0,

                    ),

                    const SizedBox(
                      height: 15,
                    ),
                     ReusableText(
                      title: "The password must be between 6 to 20".tr +" \n"+
                          "characters and must contain at least".tr+"\n"+
                          "one lowercase, one uppercase, one".tr+"\n"+
                          "special character, and one number.".tr,
                      size: 12,
                      weight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ReusableBorderContainer(
                      borderColor: silver,
                      fillColor: silver,
                      height: 46,
                      child: TextField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          labelText: homeController.languageParam.value.confirmPassword,
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     ReusableButton1(
                      title: homeController.languageParam.value.reset,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
