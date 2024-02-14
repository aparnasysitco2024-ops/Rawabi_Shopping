import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/bottomNavBar.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/widget/commomwidget/reusable_button.dart';

import '../utils/colors.dart';
import '../widget/commomwidget/reusable_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer(const Duration(seconds: 1), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (_) => const LoginScreen(),
    //     ),
    //   );
    // });
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
            ReusableButton(
                width: 200.0,
                onTap: () {
                  AppUtils.navigateToPageReplace(const BottomNavBar());
                },
                title: "Shop now".tr)
          ],
        ),
      ),
    );
  }
}
