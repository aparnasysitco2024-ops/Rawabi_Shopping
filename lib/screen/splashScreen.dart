import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/app_utils.dart';
import '../model/response/languageParamResponse.dart';
import '../utils/colors.dart';
import '../utils/storage_manager.dart';
import '../widget/commonWidget/reusable_text.dart';
import 'deliverymode/deliveryModeScreen.dart';
import 'navigator/bottomNavBar.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  var languageParam = LanguageParam().obs;
  var languageParamString = "";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    getLanguageData();
  }

  moveToPage() {
    Timer(const Duration(seconds: 1), () async {
      // bool isLogin = await StorageManager.readDataBool(StorageManager.keyIsLogin);
      // if (isLogin) {
      String storeAddress =
          await StorageManager.readData(StorageManager.keyStoreAddress);
      if (storeAddress.isEmpty) {
        AppUtils.navigateToPage(DeliveryModeScreen());
      } else {
        // AppUtils.navigateToPage(TrackOrderMap());
        AppUtils.navigateToPageReplace(BottomNavBar());
      }
      // } else {
      //   AppUtils.navigateToPageReplace(LoginScreen());
      // }
    });
  }

  Future<void> getLanguageData() async {
    widget.languageParamString =
        await StorageManager.readData(StorageManager.keyLanguageParams);
    if (widget.languageParamString.isNotEmpty) {
      // widget.languageParam.value =
      //     LanguageParam.fromJson(json.decode(widget.languageParamString));
      moveToPage();
    } else
      readJsonLanguage();
  }

  Future<void> readJsonLanguage() async {
    final String response =
        await rootBundle.loadString('assets/json/englishLanguage.json');
    widget.languageParam.value = LanguageParam.fromJson(json.decode(response));
    StorageManager.saveData(StorageManager.keyLanguageParams,
        json.encode(widget.languageParam.value));
    moveToPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/splash.png"), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/logo.svg"),
            ReusableText(
                textAlign: TextAlign.center,
                title: "Get your groceries delivered to your home".tr,
                size: 28,
                color: blackLight,
                weight: FontWeight.bold),
            const SizedBox(
              height: 10,
            ),
            ReusableText(
                textAlign: TextAlign.center,
                title:
                    "The best delivery app in town for delivering your daily fresh groceries"
                        .tr,
                size: 16,
                color: grey,
                weight: FontWeight.w400),
            const SizedBox(
              height: 30,
            ),
            // ReusableButton(
            //     width: 200.0,
            //     onTap: () {
            //       AppUtils.navigateToPageReplace(const BottomNavBar());
            //     },
            //     title: "Shop now".tr)
          ],
        ),
      ),
    );
  }
}
