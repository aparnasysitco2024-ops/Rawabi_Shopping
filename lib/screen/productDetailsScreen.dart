import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/cartController.dart';
import 'package:rawabi/controller/homeController.dart';
import 'package:rawabi/widget/commonwidget/reusable_button1.dart';

import '../controller/productsDetailsController.dart';
import '../utils/colors.dart';
import '../widget/commonwidget/networkImageWidget.dart';
import '../widget/commonwidget/reusable_text.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatelessWidget {

  ProductDetailsScreen({super.key});

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
        Navigator.pop(context);
        Get.delete<ProductDetailsController>();
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Obx(() => Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const SizedBox(
                height: 10,
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
                      Get.delete<ProductDetailsController>();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5, right: 0),
                      height: 40,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [blue, lightBlue, pink]),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Row(children: [
                        SvgPicture.asset(
                          "assets/icons/express.svg",
                          height: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: ReusableText(
                            title: "Express delivery".tr,
                            maxLine: 1,
                            size: 11,
                            weight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Transform.scale(
                          scale: 0.7,
                          child: Switch(
                            activeColor: primaryColor,
                            value: homeController.isExpress.value,
                            onChanged: (value) {
                              homeController.isExpress.value = value;
                            },
                          ),
                        )
                      ]),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SvgPicture.asset(
                    "assets/icons/line.svg",
                    height: 30,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/filter.svg",
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const ReusableText(
                        title: "Filter",
                        size: 12,
                        weight: FontWeight.w800,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SvgPicture.asset(
                    "assets/icons/line.svg",
                    height: 30,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/sort.svg",
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const ReusableText(
                        title: "Sort",
                        size: 12,
                        weight: FontWeight.w800,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
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
                      size: 10,
                      color: blue,
                    ),
                  )
                ]),
              ),
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
                                Flexible(
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        child: NetworkImageWidget(
                                          image: productDetailsController
                                              .productDetails?.productImage,
                                          height: 210.0,
                                        ))),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    SvgPicture.asset(
                                      "assets/icons/heart.svg",
                                      height: 18,
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
                            const ReusableText(
                              title: "Pack size - 1kg",
                              size: 14.0,
                              weight: FontWeight.w600,
                            ),
                            ReusableText(
                              title:
                                  "QAR ${productDetailsController.productDetails!.offerPrice}",
                              size: 18.0,
                              weight: FontWeight.w600,
                            ),
                            const Divider(
                              color: lightGreyColor,
                              thickness: 3,
                              height: 20,
                            ),
                            const ReusableText(
                              title: "Overview",
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
                            const ReusableText(
                              title: "Details",
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
                            const SizedBox(
                              height: 10,
                            ),
                            ReusableButton1(
                              title: "Add to Cart".tr,
                              onPressed: () {
                                cartController.addToCart(
                                    productID,
                                    productDetailsController
                                        .productDetails!.storeId
                                        .toString(),
                                    productDetailsController
                                        .productDetails!.offerPrice,
                                    "1");
                                //cartController.itemCount++;
                              },
                            ),
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
