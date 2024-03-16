// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/homeController.dart';
import 'package:rawabi/widget/commonwidget/card_widget.dart';

import '../controller/cartController.dart';
import '../utils/colors.dart';
import '../widget/commonwidget/cart_items_details.dart';
import '../widget/commonwidget/reusable_text.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final cartController = Get.put(CartController());
  final homeController = Get.put(HomeController());
  String masterCard = "Master Card";
  String visa = "Visa";
  String cash = "Cash";

  @override
  Widget build(BuildContext context) {
    cartController.getCartList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => Expanded(
        flex: 1,
        child: Column(
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
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 30,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [blue, lightBlue, pink]),
                      ),
                      child: Row(
                          children: [
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3))),
                          child: ReusableText(
                            title: "Change".tr,
                            size: 8,
                            color: blue,
                          ),
                        )
                      ]),
                    ),
                  ),
                  cartController.loading.value
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height - 180,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          ),
                        )
                      : Expanded(
                    flex: 9,
                          child: Container(
                            width: double.maxFinite,
                            color: silver,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: white,
                                    ),
                                    height: 45,
                                    width: double.maxFinite,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 2),
                                          child: ReusableText(
                                              title: "Your orders".tr,
                                              size: 14,
                                              weight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 2),
                                          child: ReusableText(
                                            title: "3 items".tr,
                                            size: 10,
                                          ),
                                        ),
                                        const Divider(
                                          color: lightGreyColor,
                                          thickness: 2,
                                          height: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        color: lightGreyColor,
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Column(
                                          children: [
                                            CartItemDetails(
                                                imageName:
                                                    "assets/images/casina.png"),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            CartItemDetails(
                                                imageName:
                                                    "assets/images/casina.png"),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            CartItemDetails(
                                              imageName:
                                                  "assets/images/casina.png",
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 76,
                                    width: double.maxFinite,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [blue, lightBlue, pink]),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 10),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: primaryColor,
                                                child: ClipOval(
                                                  child: SvgPicture.asset(
                                                    "assets/images/home.svg",
                                                    height: 30,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ReusableText(
                                                    title:
                                                        "Contactless Delivery".tr,
                                                    size: 12,
                                                    weight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                  ReusableText(
                                                    title:
                                                        "We will ring the bell and leave the delivery on \n your doorstep"
                                                            .tr,
                                                    size: 10,
                                                    weight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Transform.scale(
                                                scale: 0.7,
                                                child: Switch(
                                                  activeColor: primaryColor,
                                                  value: cartController
                                                      .isContactless.value,
                                                  onChanged: (value) {
                                                    cartController.isContactless
                                                        .value = value;
                                                  },
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: white,
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ReusableText(
                                          title: "Select Payment Method".tr,
                                          size: 16,
                                          weight: FontWeight.bold,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [

                                            const RoundCard(image: 'assets/images/mastercard.svg'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const ReusableText(
                                              title: "Card ending in 6785",
                                              weight: FontWeight.w400,
                                            ),
                                            const Spacer(),
                                            Radio(
                                                value: masterCard,
                                                groupValue:
                                                    cartController.groupValue,
                                                onChanged: (v) {
                                                  cartController.groupValue = v;
                                                })
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const RoundCard(image: 'assets/images/visacard.svg',),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const ReusableText(
                                              title: "Card ending in 2314",
                                              weight: FontWeight.w400,
                                            ),
                                            const Spacer(),
                                            Radio(
                                                value: visa,
                                                groupValue:
                                                    cartController.groupValue,
                                                onChanged: (v) {
                                                  cartController.groupValue = v;
                                                })
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.055,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: silver, width: 1),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                color: silver,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            ReusableText(
                                              title: "Add new Card".tr,
                                              weight: FontWeight.w400,
                                            ),
                                            const Spacer(),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              color: silver,
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Divider(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Card(
                                              child: SvgPicture.asset(
                                                  'assets/images/money.svg'),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            ReusableText(
                                              title: "Cash on Delivery".tr,
                                              weight: FontWeight.w400,
                                            ),
                                            const Spacer(),
                                            Radio(
                                                value: cash,
                                                groupValue:
                                                    cartController.groupValue,
                                                onChanged: (v) {
                                                  cartController.groupValue = v;
                                                })
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                ]),
      )),
    );
  }
}
