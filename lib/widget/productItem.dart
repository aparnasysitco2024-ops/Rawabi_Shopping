import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/model/products.dart';
import 'package:rawabi/widget/commonwidget/reusableNetworkImage.dart';
import 'package:rawabi/widget/commonwidget/reusable_button1.dart';
import '../controller/cartController.dart';
import '../utils/colors.dart';
import 'commonwidget/reusable_text.dart';

class ProductItem extends StatefulWidget {
  final Products products;
  final cartController = Get.put(CartController());

  ProductItem({super.key, required this.products});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      Navigator.pushNamed(
        context,
        '/ProductDetailsScreen',
        arguments: {
          'productID': widget.products.productId,
        },
      );
      /*AppUtils.navigateToPage(
          ProductDetailsScreen(
              productID: widget.products.productId));*/
    },
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 20,
                  width: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                  decoration: const BoxDecoration(
                      color: lightPink,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: const ReusableText(
                    title: "Best seller",
                    color: primaryColor,
                    size: 10,
                  ),
                ),
                InkWell(
                  onTap: () {

                    setState(() {

                    });

                  },
                  child: SvgPicture.asset(
                    "assets/icons/heart.svg",
                    fit: BoxFit.fill,
                    colorFilter:
                        const ColorFilter.mode(silver, BlendMode.srcIn),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ReusableNetworkImage(
              image: widget.products.productImage.toString(),
              height: 130,
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/icons/fastdelivery.svg",
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ReusableText(
                    title: widget.products.productName,
                    maxLine: 2,
                    size: 10,
                    weight: FontWeight.w600,
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                  // const ReusableText(
                  //   title: "30 gm",
                  //   size: 10,
                  //   weight: FontWeight.w400,
                  // ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            title: widget.products.sellingPrice.toString(),
                            size: 8,
                            strike: true,
                            color: grey1,
                          ),
                          ReusableText(
                            title: widget.products.offerPrice,
                            size: 12,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                      widget.products.cartCount == 0
                          ? ReusableButton1(
                              onPressed: () {
                                widget.cartController.addToCart(
                                    widget.products.productId.toString(),
                                    widget.products.storeId.toString(),
                                    widget.products.offerPrice.toString(),
                                    "1");
                                setState(() {
                                  widget.products.cartCount =
                                      (widget.products.cartCount! + 1);
                                });
                              },
                              title: "Add",
                              size: const Size(70, 27),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            )
                          : Container(
                              margin: const EdgeInsets.only(bottom: 5,top: 5),
                              height: 30,
                              width: 70,
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                  color: pink,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (widget.products.cartCount == "1") {
                                        widget.cartController.removeCartItem(
                                            widget.products.productId);
                                      } else {
                                        widget.cartController.updateQty(
                                            widget.products.productId,
                                            int.parse(widget.products.cartCount
                                                    .toString()) -
                                                1);
                                        setState(() {
                                          widget.products.cartCount =
                                          (widget.products.cartCount! - 1);
                                        });
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/minus_item.svg",
                                      height: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  ReusableText(
                                    title: widget.products.cartCount.toString(),
                                    size: 12,
                                    color: silver,
                                    weight: FontWeight.bold,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      widget.cartController.addToCart(
                                          widget.products.productId.toString(),
                                          widget.products.storeId.toString(),
                                          widget.products.offerPrice.toString(),
                                          "1");
                                      setState(() {
                                        widget.products.cartCount =
                                            (widget.products.cartCount! + 1);
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/plus_item.svg",
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                            )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
