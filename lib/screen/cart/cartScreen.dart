// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/address/myAddressesScreen.dart';
import 'package:rawabi/screen/loginScreen.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/widget/commonwidget/reusable_button1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/cartController.dart';
import '../../controller/homeController.dart';
import '../../utils/colors.dart';
import '../../widget/commonwidget/cart_items_details.dart';
import '../../widget/commonwidget/reusable_text.dart';
import '../../widget/commonwidget/round_card.dart';
import 'coupons_screen.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final cartController = Get.put(CartController());

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    cartController.getCartList();
    cartController.calculateDeliveryFee();

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
                      title: homeController.languageParam.value.cart,
                      size: 18,
                      weight: FontWeight.bold),
                ),
                cartController.cartProducts.isNotEmpty &&
                        !homeController.isPickup.value
                    ? Container(
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
                          ReusableText(
                            title:
                                "Deliver to" +
                                    "${homeController.defaultAddress.value}",
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
                            child: InkWell(
                              onTap: () =>
                                  AppUtils.navigateToPage(MyAddressesScreen()),
                              child: ReusableText(
                                title:
                                    homeController.languageParam.value.change,
                                size: 8,
                                color: blue,
                              ),
                            ),
                          )
                        ]),
                      )
                    : SizedBox(),
                cartController.loading.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height - 280,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      )
                    : cartController.cartProducts.isNotEmpty
                        ? Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 2),
                                          child: ReusableText(
                                              title: homeController
                                                  .languageParam
                                                  .value
                                                  .yourOrders,
                                              size: 14,
                                              weight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 2),
                                          child: ReusableText(
                                            title: cartController
                                                    .cartProducts.length
                                                    .toString() +
                                                " " +
                                                homeController
                                                    .languageParam.value.items
                                                    .toString(),
                                            size: 10,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      color: lightGreyColor,
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(0),
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: cartController
                                              .cartProducts.length,
                                          itemBuilder: (context, index) =>
                                              CartItemDetails(
                                                products: cartController
                                                    .cartProducts[index],
                                              ))),
                                  homeController.isPickup.value
                                      ? SizedBox()
                                      : Container(
                                          height: 76,
                                          width: double.maxFinite,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  blue,
                                                  lightBlue,
                                                  pink
                                                ]),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 10),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          primaryColor,
                                                      child: ClipOval(
                                                        child: SvgPicture.asset(
                                                          "assets/icons/blue_home.svg",
                                                          height: 30,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ReusableText(
                                                          title:
                                                          homeController.languageParam.value.contactlessDelivery,
                                                          size: 12,
                                                          weight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                        ReusableText(
                                                          title:
                                                              "We will ring the bell and leave the delivery on \n your doorstep"
                                                                  .tr,
                                                          size: 10,
                                                          weight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Transform.scale(
                                                      scale: 0.7,
                                                      child: Switch(
                                                        activeColor:
                                                            primaryColor,
                                                        value: cartController
                                                            .isContactless
                                                            .value,
                                                        onChanged: (value) {
                                                          cartController
                                                              .isContactless
                                                              .value = value;
                                                        },
                                                      ),
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        ),
                                  Container(
                                    width: double.maxFinite,
                                    color: white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ReusableText(
                                          title: homeController.languageParam.value.selectPaymentMethod,
                                          size: 16,
                                          weight: FontWeight.bold,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // Row(
                                        //   children: [
                                        //     const RoundCard(
                                        //         image:
                                        //             'assets/icons/mastercard.svg'),
                                        //     const SizedBox(
                                        //       width: 10,
                                        //     ),
                                        //     const ReusableText(
                                        //       title: "Card ending in 6785",
                                        //       weight: FontWeight.w400,
                                        //     ),
                                        //     const Spacer(),
                                        //     Radio(
                                        //         value:
                                        //             cartController.masterCard,
                                        //         groupValue: cartController
                                        //             .groupValue.value,
                                        //         activeColor: MaterialStateColor
                                        //             .resolveWith((states) =>
                                        //                 primaryColor),
                                        //         onChanged: (v) {
                                        //           cartController
                                        //               .groupValue.value = v!;
                                        //         })
                                        //   ],
                                        // ),
                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     const RoundCard(
                                        //       image:
                                        //           'assets/icons/visacard.svg',
                                        //     ),
                                        //     const SizedBox(
                                        //       width: 10,
                                        //     ),
                                        //     const ReusableText(
                                        //       title: "Card ending in 2314",
                                        //       weight: FontWeight.w400,
                                        //     ),
                                        //     const Spacer(),
                                        //     Radio(
                                        //         value: cartController.visa,
                                        //         groupValue: cartController
                                        //             .groupValue.value,
                                        //         activeColor: MaterialStateColor
                                        //             .resolveWith((states) =>
                                        //                 primaryColor),
                                        //         onChanged: (v) {
                                        //           cartController
                                        //               .groupValue.value = v!;
                                        //         })
                                        //   ],
                                        // ),
                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                        Row(
                                          children: [
                                            const RoundCard(
                                              image: 'assets/icons/plus.svg',
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            ReusableText(
                                              title: homeController.languageParam.value.addNewCard,
                                              weight: FontWeight.w400,
                                            ),
                                            const Spacer(),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: grey,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Divider(),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const RoundCard(
                                              image: 'assets/icons/money.svg',
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            ReusableText(
                                              title: homeController.languageParam.value.cashOnDelivery,
                                              weight: FontWeight.w400,
                                            ),
                                            const Spacer(),
                                            Radio(
                                                value: cartController.cash,
                                                groupValue: cartController
                                                    .groupValue.value,
                                                activeColor: MaterialStateColor
                                                    .resolveWith((states) =>
                                                        primaryColor),
                                                onChanged: (v) {
                                                  cartController
                                                      .groupValue.value = v!;
                                                })
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: silver,
                                    height: 5,
                                    width: double.maxFinite,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 18),
                                    height: 36,
                                    width: double.maxFinite,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/Verified.svg",
                                            height: 18,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          ReusableText(
                                            title: homeController.languageParam.value.applyCoupon,
                                            size: 14,
                                            weight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: (){
                                              AppUtils.navigateToPage(ApplyCoupons());
                                            },
                                            child: Container(
                                              height: 22,
                                              width: 48,
                                              margin: const EdgeInsets.only(
                                                  right: 16),
                                              padding: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(3))),
                                              child: Center(
                                                child: ReusableText(
                                                  title: homeController.languageParam.value.apply,
                                                  size: 10,
                                                  color: white,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          )
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    color: silver,
                                    height: 5,
                                    width: double.maxFinite,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 6.0),
                                    child: ReusableText(
                                      title: homeController.languageParam.value.orderSummary,
                                      size: 14,
                                      weight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.only(
                                        left: 18,
                                        right: 18,
                                        top: 6,
                                        bottom: 1.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ReusableText(
                                              title: homeController.languageParam.value.cartTotal,
                                              size: 12,
                                              weight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                            const Spacer(),
                                            ReusableText(
                                              title:
                                                  "QAR- ${cartController.subTotal.value}",
                                              size: 10,
                                              weight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        homeController.isPickup.value
                                            ? SizedBox()
                                            : Row(
                                                children: [
                                                  ReusableText(
                                                    title: homeController.languageParam.value.delivery,
                                                    size: 12,
                                                    weight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                  const Spacer(),
                                                  ReusableText(
                                                    title:
                                                        "QAR- ${cartController.delivery.value}",
                                                    size: 10,
                                                    weight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                        Row(
                                          children: [
                                            ReusableText(
                                              title: homeController.languageParam.value.bagFee,
                                              size: 12,
                                              weight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                            const Spacer(),
                                            ReusableText(
                                              title:
                                                  "QAR- ${cartController.bagFee.value}",
                                              size: 10,
                                              weight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          thickness: 1,
                                        ),
                                        Row(
                                          children: [
                                            ReusableText(
                                              title: homeController.languageParam.value.grandTotal,
                                              size: 12,
                                              weight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            const Spacer(),
                                            ReusableText(
                                              title:
                                                  "QAR- ${cartController.grandTotal.value}",
                                              size: 10,
                                              weight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 18.0),
                                    child: ReusableText(
                                      title: homeController.languageParam.value.inclusiveOfAllTaxes,
                                      size: 10,
                                      weight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    color: silver,
                                    height: 5,
                                    width: double.maxFinite,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 6),
                                    height: 64,
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ReusableText(
                                              title:
                                                  "QAR- ${cartController.grandTotal.value}",
                                              size: 14,
                                              weight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            ReusableText(
                                              title: homeController.languageParam.value.totalAmount,
                                              size: 10,
                                              weight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Flexible(
                                          child: SizedBox(
                                            height: 40,
                                            child: ReusableButton1(
                                              title: homeController.languageParam.value.placeOrder,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              onPressed: () {
                                                if (homeController
                                                        .userID.value ==
                                                    "0") {
                                                  AppUtils.navigateToPage(
                                                      LoginScreen());
                                                } else {
                                                  !homeController
                                                              .isPickup.value &&
                                                          homeController
                                                              .defaultAddressId
                                                              .isEmpty
                                                      ? AppUtils.navigateToPage(
                                                          MyAddressesScreen())
                                                      : cartController
                                                          .checkSlotAvailability();
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/icons/logo.svg"),
                                    ReusableText(
                                      title: "Your cart is empty!!".tr,
                                    )
                                  ]),
                            ),
                          ),
              ])),
    );
  }
}
