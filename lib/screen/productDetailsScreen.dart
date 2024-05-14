import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/cartController.dart';
import 'package:rawabi/controller/homeController.dart';
import 'package:rawabi/widget/commonWidget/reusable_button1.dart';
import 'package:rawabi/widget/heartIcon.dart';
import 'package:widget_zoom/widget_zoom.dart';

import '../controller/productsDetailsController.dart';
import '../utils/colors.dart';
import '../widget/commonWidget/reusableNetworkImage.dart';
import '../widget/commonWidget/reusable_text.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final productDetailsController = Get.put(ProductDetailsController());

  final homeController = Get.put(HomeController());

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final productID = arguments['productID'] ?? "0";

    productDetailsController.getProductDetails(productID);
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        Get.delete<ProductDetailsController>();
        // Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => Column(children: [
              const SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: SvgPicture.asset("assets/icons/back.svg"),
                    onTap: () {
                      Navigator.of(context).pop(context);
                      /*Navigator.of(context).popUntil(ModalRoute.withName('/'));*/
                      // Get.delete<ProductDetailsController>();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              homeController.defaultAddress.value.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 40,
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
                          title: "Deliver to ".tr +
                              homeController.defaultAddress.value,
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
                            title: homeController.languageParam.value.change,
                            size: 10,
                            color: blue,
                          ),
                        )
                      ]),
                    )
                  : SizedBox(),
              Expanded(
                  child: SingleChildScrollView(
                child: productDetailsController.loading.value
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 30,
                                ),
                                productDetailsController
                                        .productDetails!.multiImages!.isNotEmpty
                                    ? Expanded(
                                        child: FlutterCarousel(
                                        options: CarouselOptions(
                                          initialPage: 0,
                                          autoPlay: false,
                                          enableInfiniteScroll: true,
                                          enlargeCenterPage: false,
                                          viewportFraction: 1,
                                          height: 220.0,
                                          showIndicator: true,
                                          slideIndicator:
                                              const CircularSlideIndicator(
                                                  currentIndicatorColor:
                                                      primaryColor,
                                                  indicatorBorderColor:
                                                      Colors.grey),
                                        ),
                                        items: productDetailsController
                                            .productDetails!.multiImages!
                                            .map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return WidgetZoom(
                                                heroAnimationTag: "tag",
                                                zoomWidget: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5,
                                                            top: 5,
                                                            bottom: 5),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      child: FadeInImage
                                                          .assetNetwork(
                                                              fit: BoxFit.fill,
                                                              placeholder:
                                                                  'assets/images/logo.png',
                                                              image: i.image
                                                                  .toString()),
                                                    )),
                                              );
                                            },
                                          );
                                        }).toList(),
                                      ))
                                    : Flexible(
                                        child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        child: WidgetZoom(
                                          zoomWidget: ReusableNetworkImage(
                                            image: productDetailsController
                                                .productDetails!.productImage
                                                .toString(),
                                            height: 210.0,
                                          ),
                                          heroAnimationTag: "tag",
                                        ),
                                      )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    HeartIcon(
                                      productId: productDetailsController
                                          .productDetails!.productId,
                                      wishlist: productDetailsController
                                          .productDetails!.wishlist,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    InkWell(
                                      child: SvgPicture.asset(
                                          "assets/icons/share.svg"),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ReusableText(
                              title: productDetailsController
                                  .productDetails!.productName,
                              size: 18.0,
                              weight: FontWeight.w600,
                            ),
                            // const ReusableText(
                            //   title: "Pack size - 1kg",
                            //   size: 14.0,
                            //   weight: FontWeight.w600,
                            // ),
                            ReusableText(
                              title:
                                  "QAR ${productDetailsController.productDetails!.offerPrice == "0.00" ? productDetailsController.productDetails!.sellingPrice : productDetailsController.productDetails!.offerPrice}",
                              size: 18.0,
                              weight: FontWeight.w600,
                            ),
                            const Divider(
                              color: lightGreyColor,
                              thickness: 3,
                              height: 20,
                            ),
                            productDetailsController
                                    .productDetails!.shortDesc!.isNotEmpty
                                ? Column(
                                    children: [
                                      ReusableText(
                                        title: homeController
                                            .languageParam.value.overview,
                                        size: 14.0,
                                        weight: FontWeight.w600,
                                      ),
                                      const Divider(
                                        color: grey,
                                        thickness: .5,
                                        height: 20,
                                      ),
                                      Html(
                                          data: productDetailsController
                                              .productDetails!.shortDesc),
                                      const Divider(
                                        color: lightGreyColor,
                                        thickness: 3,
                                        height: 20,
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            productDetailsController
                                    .productDetails!.detailedDesc!.isNotEmpty
                                ? Column(
                                    children: [
                                      ReusableText(
                                        title: homeController
                                            .languageParam.value.details,
                                        size: 14.0,
                                        weight: FontWeight.w600,
                                      ),
                                      const Divider(
                                        color: grey,
                                        thickness: .5,
                                        height: 20,
                                      ),
                                      Html(
                                          data: productDetailsController
                                              .productDetails!.detailedDesc),
                                    ],
                                  )
                                : SizedBox(),
                            const SizedBox(
                              height: 10,
                            ),
                            AddButton(),

                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
              ))
            ])),
      ),
    );
  }
}

class AddButton extends StatefulWidget {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  final productDetailsController = Get.put(ProductDetailsController());
  final cartController = Get.put(CartController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        productDetailsController.productDetails!.cartCount != 0
            ? Container(
                margin: const EdgeInsets.only(bottom: 5, top: 5),
                height: 40,
                width: 70,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: pink, borderRadius: BorderRadius.circular(5)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // if (productDetailsController
                        //         .productDetails!.cartCount ==
                        //     1) {
                        //   cartController.removeCartItem(productDetailsController
                        //       .productDetails!.productId);
                        // } else {
                        cartController.updateQty(
                            productDetailsController.productDetails!.productId,
                            int.parse(productDetailsController
                                    .productDetails!.cartCount
                                    .toString()) -
                                1);
                        setState(() {
                          productDetailsController.productDetails!.cartCount =
                              (productDetailsController
                                      .productDetails!.cartCount! -
                                  1);
                        });
                        // }
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
                      title: productDetailsController.productDetails!.cartCount
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
                        cartController.addToCart(
                            productDetailsController.productDetails!.productId
                                .toString(),
                            productDetailsController.productDetails!.storeId
                                .toString(),
                            productDetailsController.productDetails!.offerPrice
                                        .toString() ==
                                    "0"
                                ? productDetailsController
                                    .productDetails!.sellingPrice
                                    .toString()
                                : productDetailsController
                                    .productDetails!.offerPrice
                                    .toString(),
                            "1");
                        setState(() {
                          productDetailsController.productDetails!.cartCount =
                              (productDetailsController
                                      .productDetails!.cartCount! +
                                  1);
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
            : SizedBox(),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: SizedBox(
            height: 40,
            child: ReusableButton1(
              title: homeController.languageParam.value.addToCart,
              onPressed: () {
                cartController.addToCart(
                    productDetailsController.productDetails!.productId
                        .toString(),
                    productDetailsController.productDetails!.storeId.toString(),
                    productDetailsController.productDetails!.offerPrice ==
                            "0.00"
                        ? productDetailsController.productDetails!.sellingPrice
                        : productDetailsController.productDetails!.offerPrice,
                    "1");
                setState(() {
                  productDetailsController.productDetails!.cartCount =
                      (productDetailsController.productDetails!.cartCount! + 1);
                });
                //cartController.itemCount++;
              },
            ),
          ),
        ),
      ],
    );
  }
}
