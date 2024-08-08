import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/ReusableBorderContainer.dart';
import 'package:rawabi/widget/commonwidget/profile_tile.dart';
import 'package:rawabi/widget/commonwidget/reusable_button1.dart';

import '../controller/homeController.dart';
import '../controller/profileController.dart';
import '../widget/commonwidget/reusable_text.dart';
import '../widget/commonwidget/reusable_textformfield.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({super.key});

  final profileController = Get.put(ProfileController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // profileController.getMyProfile();
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
            Obx(() => profileController.loading.value
                ? SizedBox(
                    height: 100,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.maxFinite,
                        color: white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                title: homeController
                                        .languageParam.value.name ??
                                    "",
                                size: 14,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ReusableBorderContainer(
                                borderColor: silver,
                                child: ReusableTextForm(
                                  controller:
                                      profileController.nameController.value,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ReusableText(
                                title: homeController
                                    .languageParam.value.email ??
                                    "",
                                size: 14,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ReusableBorderContainer(
                                borderColor: silver,
                                child: ReusableTextForm(
                                  controller:
                                      profileController.emailController.value,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ReusableText(
                                title: homeController
                                    .languageParam.value.mobileNumber ??
                                    "",
                                size: 14,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ReusableBorderContainer(
                                borderColor: silver,
                                child: ReusableTextForm(
                                  controller:
                                      profileController.mobileController.value,
                                ),
                              ),
                              // SizedBox(
                              //   height: 50,
                              //   width: double.maxFinite,
                              //   child: Stack(children: [
                              //     IntlPhoneField(
                              //       onChanged: (phone) {
                              //         // mobile = phone.completeNumber.split("+").last;
                              //         //mobile = phone.number;
                              //       },
                              //       //controller: mobileController,
                              //       initialCountryCode: "QA",
                              //       disableLengthCheck: true,
                              //       showDropdownIcon: true,
                              //       dropdownIconPosition: IconPosition.trailing,
                              //       decoration: InputDecoration(
                              //         fillColor: white,
                              //         filled: true,
                              //         contentPadding:
                              //             const EdgeInsets.symmetric(
                              //                 horizontal: 20, vertical: 5),
                              //         hintText: '',
                              //
                              //         border: const OutlineInputBorder(
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(6)),
                              //             borderSide: BorderSide(
                              //                 color: lightGreyColor)),
                              //         enabledBorder: OutlineInputBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(6),
                              //             borderSide:
                              //                 const BorderSide(color: silver)),
                              //         focusedBorder: OutlineInputBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(6),
                              //             borderSide: const BorderSide(
                              //                 color: silver, width: 1)),
                              //       ),
                              //     ),
                              //     Positioned(
                              //       right: 15,
                              //       top: 10,
                              //       child: GestureDetector(
                              //         onTap: () {},
                              //         child: ReusableText(
                              //           title: "Verify".tr,
                              //           color: blue,
                              //           size: 16,
                              //           weight: FontWeight.w400,
                              //         ),
                              //       ),
                              //     )
                              //   ]),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            Container(
              height: 74,
              width: double.maxFinite,
              color: white,
              padding: const EdgeInsets.only(
                  left: 18, right: 18, top: 10, bottom: 20),
              child: ReusableButton1(
                title: homeController.languageParam.value.saveAndUpdate,
                onPressed: () {

                },
              ),
            ),
            Container(
              color: silver,
              height: 3,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              //height: 130,
              width: double.maxFinite,
              color: white,
              padding:
                  const EdgeInsets.only(left: 18, right: 18, top: 1, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // GestureDetector(
                  //     onTap: () {
                  //       AppUtils.navigateToPage( ChangePasswordScreen());
                  //     },
                  //     child:  ProfileTile(
                  //         image: "assets/icons/lock.svg",
                  //         title: homeController.languageParam.value.changePassword.toString())),
                  // const Divider(
                  //   thickness: 1,
                  // ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: Get.context!,
                        builder: (context) => AlertDialog(
                          title: Text(homeController
                              .languageParam.value.rawabiShopping
                              .toString()),
                          content: Text(
                              'Are you sure you would like to Delete account ?'
                                  .tr),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text(homeController.languageParam.value.no
                                  .toString()),
                            ),
                            TextButton(
                              onPressed: () {
                                profileController.deleteAccount();
                              }, // <-- SEE HERE
                              child: Text(homeController.languageParam.value.yes
                                  .toString()),
                            ),
                          ],
                        ),
                      );
                    },
                    child: ProfileTile(
                        image: "assets/icons/delete.svg",
                        title: homeController.languageParam.value.deleteAccount
                            .toString()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
