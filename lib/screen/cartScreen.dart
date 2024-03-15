// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/homeController.dart';

import '../controller/cartController.dart';
import '../utils/colors.dart';
import '../widget/commonwidget/reusable_text.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final cartController = Get.put(CartController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    cartController.getCartList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ReusableText(
                      title: "Cart".tr, size: 18, weight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 30,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [blue, lightBlue, pink]),
                  ),
                  child: Row(children: [
                    SvgPicture.asset(
                      "assets/icons/location.svg",
                      height: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const ReusableText(
                      title: "deliver to: al wakra, doha, qatar",
                      size: 12,
                      weight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                      child: ReusableText(
                        title: "Change".tr,
                        size: 8,
                        color: blue,
                      ),
                    )
                  ]),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: cartController.loading.value
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height - 180,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                  title: "Your orders".tr,
                                  size: 14,
                                  weight: FontWeight.w600),
                              ReusableText(
                                title: "items".tr,
                                size: 10,
                              ),
                              const Divider(
                                color: lightGreyColor,
                                thickness: 2,
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                ))
              ])),
    );
  }
}
