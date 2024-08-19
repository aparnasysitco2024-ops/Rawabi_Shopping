import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/homeController.dart';
import 'package:rawabi/model/response/products.dart';

import '../controller/cartController.dart';
import '../controller/productsController.dart';
import '../utils/colors.dart';
import 'commonWidget/reusableNetworkImage.dart';
import 'commonWidget/reusable_button1.dart';
import 'commonWidget/reusable_text.dart';

class ProductItem extends StatefulWidget {
  final Products products;
  final cartController = Get.put(CartController());
  final homeController = Get.put(HomeController());

  ProductItem({super.key, required this.products});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/ProductDetailsScreen',
          arguments: {
            'productID': widget.products.productId,
          },
        ).whenComplete(
          () {
            if (Get.isRegistered<ProductController>()) {
              final productController = Get.put(ProductController());
              if (productController.brandId.value != "0")
                productController.getProductsByBrand();
              // else if (productController.subSubCatID.value != "0")
              //   productController.getSubCategory();
              // else if (productController.catID.value != "0")
              //   productController.getSubCategory();
              else
                productController.getProductsByCat();
              // productController.getProductsByCat();
            }
          },
        );
      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
            border: Border.all(color: silver)),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.products.best_seller == 1
                    ? Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 70,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 2),
                        decoration: const BoxDecoration(
                            color: lightPink,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: ReusableText(
                          title: widget
                              .homeController.languageParam.value.bestSeller,
                          color: primaryColor,
                          size: 10,
                        ),
                      )
                    : SizedBox(),
                Spacer(),
                InkWell(
                  onTap: () {
                    widget.products.wishlist == 0
                        ? widget.cartController
                            .addToWishList(widget.products.productId)
                        : widget.cartController
                            .removeFromWishList(widget.products.productId);
                    setState(() {
                      widget.products.wishlist =
                          widget.products.wishlist == 0 ? 1 : 0;
                    });
                  },
                  child: SvgPicture.asset(
                    "assets/icons/heart.svg",
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                        widget.products.wishlist == 0 ? silver : primaryColor,
                        BlendMode.srcIn),
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
                  // SvgPicture.asset(
                  //   "assets/icons/fastdelivery.svg",
                  //   fit: BoxFit.fill,
                  // ),
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
                    height: 1,
                  ),
                  // const ReusableText(
                  //   title: "30 gm",
                  //   size: 10,
                  //   weight: FontWeight.w400,
                  // ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.products.offerPrice == "0.00"
                              ? SizedBox()
                              : ReusableText(
                                  title: "QAR " +
                                      widget.products.sellingPrice.toString(),
                                  size: 8,
                                  strike: true,
                                  color: grey1,
                                ),
                          ReusableText(
                            title: widget.products.offerPrice == "0.00"
                                ? "QAR " +
                                    widget.products.sellingPrice.toString()
                                : "QAR " +
                                    widget.products.offerPrice.toString(),
                            size: 12,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Flexible(
                        child: widget.products.item_status == "1"
                            ? widget.products.cartCount == 0
                                ? ReusableButton1(
                                    onPressed: () {
                                      widget.cartController.addToCart(
                                          widget.products.productId.toString(),
                                          widget.products.storeId.toString(),
                                          widget.products.offerPrice
                                                      .toString() ==
                                                  "0.00"
                                              ? widget.products.sellingPrice
                                                  .toString()
                                              : widget.products.offerPrice
                                                  .toString(),
                                          "1",
                                          "");
                                      setState(() {
                                        widget.products.cartCount =
                                            (widget.products.cartCount! + 1);
                                      });
                                    },
                                    title: "Add".tr,
                                    size: const Size(60, 27),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  )
                                : Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 5, top: 5),
                                    height: 30,
                                    width: 65,
                                    padding: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        color: pink,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // if (widget.products.cartCount == 1) {
                                            //   widget.cartController.removeCartItem(
                                            //       widget.products.productId);
                                            // } else {
                                            widget.cartController.updateQty(
                                                widget.products.productId,
                                                int.parse(widget
                                                        .products.cartCount
                                                        .toString()) -
                                                    1);
                                            setState(() {
                                              widget.products.cartCount =
                                                  (widget.products.cartCount! -
                                                      1);
                                            });
                                            // }
                                          },
                                          child: SvgPicture.asset(
                                            "assets/icons/minus_item.svg",
                                            height: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        ReusableText(
                                          title: widget.products.cartCount
                                              .toString(),
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
                                                widget.products.productId
                                                    .toString(),
                                                widget.products.storeId
                                                    .toString(),
                                                widget.products.offerPrice
                                                            .toString() ==
                                                        "0.00"
                                                    ? widget
                                                        .products.sellingPrice
                                                        .toString()
                                                    : widget.products.offerPrice
                                                        .toString(),
                                                "1",
                                                "");
                                            setState(() {
                                              widget.products.cartCount =
                                                  (widget.products.cartCount! +
                                                      1);
                                            });
                                          },
                                          child: SvgPicture.asset(
                                            "assets/icons/plus_item.svg",
                                            height: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                            : Expanded(
                                child: ReusableText(
                                  title: "Available Soon".tr,
                                  textAlign: TextAlign.center,
                                  size: 12,
                                  color: primaryColor,
                                ),
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
