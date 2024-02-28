// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_button.dart';
import 'package:rawabi/widget/commonwidget/reusable_button1.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../model/products.dart';
import '../screen/productDetailsScreen.dart';
import '../utils/app_utils.dart';

class ItemsWidget extends StatefulWidget {
  String? title;
  List<Products>? products;
  bool hideViewAll;

  ItemsWidget({super.key, this.title, this.products, this.hideViewAll = false});

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
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
                                SvgPicture.asset("assets/icons/heart.svg")
                              ],
                            ),
                            SizedBox(
                              height: 130,
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
                                  width: 80,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                SizedBox(
                                  width: 55.0,
                                  height: 25,
                                  child: ReusableButton1(
                                    fontSize: 11.0,
                                    onPressed: () {},
                                    title: "Add".tr,
                                  ),
                                )
                              ],
                            )
                          ]),
                        ),
                        onTap: () => AppUtils.navigateToPage(
                            ProductDetailsScreen(
                                productID: widget.products![index].productId)),
                      )))
        ],
      ),
    );
  }
}
