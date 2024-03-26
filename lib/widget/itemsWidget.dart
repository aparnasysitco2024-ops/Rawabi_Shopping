// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_button.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';
import '../controller/cartController.dart';
import '../model/products.dart';

class ItemsWidget extends StatefulWidget {
  String? title;
  List<Products>? products;
  bool hideViewAll;
  final cartController = Get.put(CartController());

  ItemsWidget({super.key, this.title, this.products, this.hideViewAll = false});

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      color: Colors.white,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.hideViewAll
              ? const SizedBox(
                  width: double.infinity,
                )
              : Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    ReusableText(
                      title: widget.title,
                      weight: FontWeight.bold,
                    ),
                    const Spacer(),
                    ReusableText(
                      title: "See All".tr,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              height: 247,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.products?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                      child: Container(
                        width: 155,
                        margin: const EdgeInsets.only(left: 10, bottom: 5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: silver)),
                        child: Column(children: [
                          Row(
                            children: [
                              ReusableButton(
                                onTap: () {},
                                title: "35% OFF",
                                width: 70.0,
                                borderRadius: 5.0,
                                padding: 5.0,
                                textSize: 12.0,
                                buttonColor: pink,
                              ),
                              const Spacer(),
                              InkWell(
                                  onTap: () {

                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/heart.svg"))
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 120,
                            child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/logo.png',
                                image: widget.products![index].productImage
                                    .toString()),
                          ),
                          SizedBox(
                            height: 40,
                            child: ReusableText(
                              title: widget.products![index].productName,
                              maxLine: 2,
                              size: 12,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReusableText(
                                      title:
                                          "QAR ${widget.products![index].sellingPrice}",
                                      maxLine: 1,
                                      size: 10,
                                      textAlign: TextAlign.center,
                                      strike: true,
                                    ),
                                    ReusableText(
                                      title:
                                          "QAR ${widget.products![index].offerPrice}",
                                      maxLine: 1,
                                      weight: FontWeight.bold,
                                      size: 11,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              // SizedBox(
                              //   width: 55.0,
                              //   height: 25,
                              //   child: ReusableButton1(
                              //     fontSize: 11.0,
                              //     onPressed: () {
                              //       widget.homeController.addToCart(
                              //           widget.products![index].productId
                              //               .toString(),
                              //           widget.products![index].storeId
                              //               .toString(),
                              //           widget.products![index].offerPrice
                              //               .toString(),
                              //           "1");
                              //     },
                              //     title: "Add".tr,
                              //   ),
                              // ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: pink,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // if (products.quantity == "1") {
                                        //   cartController.removeCartItem(products.cartId);
                                        // } else {
                                        //   cartController.updateQty(products.cartId,
                                        //       int.parse(products.quantity.toString()) - 1);
                                        // }
                                      },
                                      child: const SizedBox(
                                        width: 20,
                                        child: CircleAvatar(
                                          backgroundColor: silver,
                                          radius: 15,
                                          child: ClipOval(
                                              child: Icon(
                                                  size: 15,
                                                  Icons.remove_outlined)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    ReusableText(
                                      title: widget.products![index].cartCount
                                          .toString(),
                                      size: 12,
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        widget.cartController.addToCart(
                                            widget.products![index].productId
                                                .toString(),
                                            widget.products![index].storeId
                                                .toString(),
                                            widget.products![index].offerPrice
                                                .toString(),
                                            "1");
                                        setState(() {
                                          widget.products![index].cartCount =
                                              (widget.products![index]
                                                      .cartCount! +
                                                  1);
                                        });
                                      },
                                      child: const SizedBox(
                                        width: 20,
                                        child: CircleAvatar(
                                          backgroundColor: primaryColor,
                                          radius: 15,
                                          child: ClipOval(
                                              child: Icon(size: 15, Icons.add)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ]),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/ProductDetailsScreen',
                          arguments: {
                            'productID': widget.products![index].productId,
                          },
                        );
                        /*AppUtils.navigateToPage(
                            ProductDetailsScreen(
                                productID: widget.products![index].productId));*/
                      })))
        ],
      ),
    );
  }
}
