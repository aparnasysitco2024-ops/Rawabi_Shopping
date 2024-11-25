import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/cartController.dart';
import 'package:rawabi/controller/homeController.dart';
import 'package:rawabi/model/response/productDetailsResponse.dart';
import 'package:rawabi/screen/cart/cartScreenPreOrder.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/widget/commonWidget/reusable_button1.dart';
import 'package:rawabi/widget/heartIcon.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widget_zoom/widget_zoom.dart';

import '../controller/productsDetailsController.dart';
import '../utils/colors.dart';
import '../widget/commonWidget/reusableNetworkImage.dart';
import '../widget/commonWidget/reusable_text.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatefulWidget {
  final VoidCallback onCartSelected;

  ProductDetailsScreen({super.key, required this.onCartSelected});

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
                height: 50,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Container(
                      child: SvgPicture.asset("assets/icons/back.svg"),
                      width: 40,
                      height: 50,
                      padding: EdgeInsets.all(15),
                    ),
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
              homeController.defaultAddress.value.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 40,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [orange, yellow]),
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
                    : productDetailsController.productDetails.value.productId !=
                            null
                        ? Padding(
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
                                    productDetailsController.productDetails
                                            .value.multiImages!.isNotEmpty
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
                                                slideIndicatorOptions:
                                                    SlideIndicatorOptions(
                                                        currentIndicatorColor:
                                                            primaryColor,
                                                        indicatorBorderColor:
                                                            Colors.grey),
                                              ),
                                            ),
                                            items: productDetailsController
                                                .productDetails
                                                .value
                                                .multiImages!
                                                .map((i) {
                                              return Builder(
                                                builder:
                                                    (BuildContext context) {
                                                  return WidgetZoom(
                                                    heroAnimationTag: "tag",
                                                    zoomWidget: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 5,
                                                                top: 5,
                                                                bottom: 5),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          child: FadeInImage
                                                              .assetNetwork(
                                                                  fit: BoxFit
                                                                      .contain,
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
                                                    .productDetails
                                                    .value
                                                    .productImage
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
                                              .productDetails.value.productId,
                                          wishlist: productDetailsController
                                              .productDetails.value.wishlist,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        InkWell(
                                          child: SvgPicture.asset(
                                              "assets/icons/share.svg"),
                                          onTap: () {
                                            Share.share(productDetailsController
                                                .productDetails.value.share_link
                                                .toString());
                                          },
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
                                      .productDetails.value.productName,
                                  size: 18.0,
                                  weight: FontWeight.w600,
                                ),
                                // const ReusableText(
                                //   title: "Pack size - 1kg",
                                //   size: 14.0,
                                //   weight: FontWeight.w600,
                                // ),
                                productDetailsController
                                            .productDetails.value.offerPrice ==
                                        "0.00"
                                    ? SizedBox()
                                    : ReusableText(
                                        title: "QAR " +
                                            productDetailsController
                                                .productDetails
                                                .value
                                                .sellingPrice
                                                .toString(),
                                        size: 18,
                                        strike: true,
                                        color: grey1,
                                      ),
                                ReusableText(
                                  title:
                                      "QAR ${productDetailsController.productDetails.value.offerPrice == "0.00" ? productDetailsController.productDetails.value.sellingPrice : productDetailsController.productDetails.value.offerPrice}",
                                  size: 18.0,
                                  weight: FontWeight.w600,
                                ),
                                const Divider(
                                  color: lightGreyColor,
                                  thickness: 3,
                                  height: 20,
                                ),
                                productDetailsController.productDetails.value
                                        .shortDesc!.isNotEmpty
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
                                          HtmlWidget(productDetailsController
                                              .productDetails.value.shortDesc
                                              .toString()),
                                          const Divider(
                                            color: lightGreyColor,
                                            thickness: 3,
                                            height: 20,
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                                productDetailsController.productDetails.value
                                        .detailedDesc!.isNotEmpty
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
                                          HtmlWidget(productDetailsController
                                              .productDetails.value.detailedDesc
                                              .toString()),
                                        ],
                                      )
                                    : SizedBox(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16, top: 6),
                                  child: ReusableText(
                                    title: "Note".tr,
                                    size: 14,
                                    weight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, bottom: 10),
                                  child: TextFormField(
                                    onEditingComplete: () {
                                      productDetailsController
                                          .isKeyboardRefresh.value = true;
                                      SystemChannels.textInput
                                          .invokeMethod('TextInput.hide');
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(top: 0),
                                        hintText: "Note".tr,
                                        hintStyle: TextStyle(fontSize: 13),
                                        labelStyle: TextStyle(fontSize: 10)),
                                    controller: productDetailsController
                                        .noteTextController,
                                  ),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                                AddButton(
                                  onCartSelected: widget.onCartSelected,
                                  productDetails: productDetailsController
                                      .productDetails.value,
                                  note: productDetailsController
                                      .noteTextController.text,
                                ),

                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ))
                        : Padding(
                            padding: EdgeInsets.only(top: 150),
                            // width: double.infinity,
                            // height: double.infinity,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/logo.svg",
                                    height: 80,
                                  ),
                                  ReusableText(
                                    title: "No Item Found!!".tr,
                                  )
                                ]),
                          ),
              ))
            ])),
      ),
    );
  }
}

// ignore: must_be_immutable
class AddButton extends StatefulWidget {
  final VoidCallback onCartSelected;
  ProductDetails productDetails;
  String note;

  AddButton(
      {super.key,
      required this.onCartSelected,
      required this.productDetails,
      required this.note});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  // final productDetailsController = Get.put(ProductDetailsController());
  final cartController = Get.put(CartController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.productDetails.cartCount != 0
            ? Container(
                margin: const EdgeInsets.only(bottom: 5, top: 5),
                height: 40,
                width: 90,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (widget.productDetails.item_status == "4") {
                          cartController.updateQtyPreOrder(
                              widget.productDetails.productId,
                              int.parse(widget.productDetails.cartCount
                                      .toString()) -
                                  1);
                        } else {
                          cartController.updateQty(
                              widget.productDetails.productId,
                              int.parse(widget.productDetails.cartCount
                                      .toString()) -
                                  1);
                        }
                        setState(() {
                          widget.productDetails.cartCount =
                              (widget.productDetails.cartCount! - 1);
                        });
                      },
                      child: SvgPicture.asset(
                        "assets/icons/minus_item.svg",
                        height: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ReusableText(
                      title: widget.productDetails.cartCount.toString(),
                      size: 14,
                      color: silver,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        if (widget.productDetails.item_status == "4") {
                          cartController.addToCartPreOrder(
                              widget.productDetails.productId.toString(),
                              widget.productDetails.storeId.toString(),
                              widget.productDetails.offerPrice.toString() ==
                                      "0.00"
                                  ? widget.productDetails.sellingPrice
                                      .toString()
                                  : widget.productDetails.offerPrice.toString(),
                              "1",
                              widget.note);
                        } else {
                          cartController.addToCart(
                              widget.productDetails.productId.toString(),
                              widget.productDetails.storeId.toString(),
                              widget.productDetails.offerPrice.toString() ==
                                      "0.00"
                                  ? widget.productDetails.sellingPrice
                                      .toString()
                                  : widget.productDetails.offerPrice.toString(),
                              "1",
                              widget.note);
                        }

                        setState(() {
                          widget.productDetails.cartCount =
                              (widget.productDetails.cartCount! + 1);
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
        widget.productDetails.item_status == "4"
            ? widget.productDetails.cartCount == 0
                ? Expanded(
                    child: SizedBox(
                        height: 40,
                        child: ReusableButton1(
                          title: "PreOrder".tr,
                          onPressed: () {
                            cartController.addToCartPreOrder(
                                widget.productDetails.productId.toString(),
                                widget.productDetails.storeId.toString(),
                                widget.productDetails.offerPrice == "0.00"
                                    ? widget.productDetails.sellingPrice
                                    : widget.productDetails.offerPrice,
                                "1",
                                widget.note);
                            setState(() {
                              widget.productDetails.cartCount =
                                  (widget.productDetails.cartCount! + 1);
                            });
                          },
                        )),
                  )
                : Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ReusableButton1(
                        title: "Go To PreOrder Cart".tr,
                        onPressed: () {
                          AppUtils.navigateToPage(CartScreenPreOrder());
                        },
                      ),
                    ),
                  )
            : widget.productDetails.item_status != "1"
                ? Expanded(
                    child: SizedBox(
                        height: 40,
                        child: ReusableButton1(title: "Available Soon".tr)),
                  )
                : widget.productDetails.cartCount == 0
                    ? Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ReusableButton1(
                            title: homeController.languageParam.value.addToCart,
                            onPressed: () {
                              cartController.addToCart(
                                  widget.productDetails.productId.toString(),
                                  widget.productDetails.storeId.toString(),
                                  widget.productDetails.offerPrice == "0.00"
                                      ? widget.productDetails.sellingPrice
                                      : widget.productDetails.offerPrice,
                                  "1",
                                  widget.note);
                              setState(() {
                                widget.productDetails.cartCount =
                                    (widget.productDetails.cartCount! + 1);
                              });
                              //cartController.itemCount++;
                            },
                          ),
                        ),
                      )
                    : Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ReusableButton1(
                            title: "Go To Cart".tr,
                            onPressed: () {
                              widget.onCartSelected();
                            },
                          ),
                        ),
                      ),
      ],
    );
  }
}
