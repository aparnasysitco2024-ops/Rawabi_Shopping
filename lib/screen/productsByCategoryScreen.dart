import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/productsController.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';
import 'package:rawabi/widget/productItem.dart';

import '../controller/homeController.dart';

// ignore: must_be_immutable
class ProductsByCategory extends StatefulWidget {
  //String? catID;

  ProductsByCategory({
    super.key,
    /* required this.catID*/
  });

  @override
  State<ProductsByCategory> createState() => _ProductsByCategoryState();
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  final homeController = Get.put(HomeController());

  final productController = Get.put(ProductController());
  String _scanBarcode = '';

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final catID = ModalRoute.of(context)?.settings.arguments;
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final catID = arguments['catId'] ?? "0";
    final subCatID = arguments['subCatID'] ?? "0";
    final subSubCatID = arguments['subSubCatID'] ?? "0";
    final subSubSubCatID = arguments['subSubSubCatID'] ?? "0";

    productController.getProductsByCat(
        catID.toString(), subCatID.toString(), subSubCatID, subSubSubCatID);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => Column(children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  child: SvgPicture.asset("assets/icons/back.svg"),
                  onTap: () {
                    Navigator.of(context).popUntil(ModalRoute.withName('/'));
                    /*Get.back();
                    Get.delete<ProductController>();*/
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    decoration: const BoxDecoration(
                        color: silver,
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: Row(children: [
                      // SvgPicture.asset("assets/icons/search.svg"),
                      ReusableText(
                        title: _scanBarcode == ""
                            ? productController.catName.value
                            : _scanBarcode,
                      ),
                      const Spacer(),
                      InkWell(
                          onTap: () async {
                            await scanBarcodeNormal();
                            print("scancode:$_scanBarcode");
                          },
                          child: SvgPicture.asset("assets/icons/scan.svg"))
                    ]),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset("assets/icons/notification.svg"),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
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
            Flexible(
              child: Container(
                color: silver,
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: GridView.builder(
                    padding: const EdgeInsets.only(top: 15),
                    shrinkWrap: true,
                    itemCount: productController.productList.length,
                    // physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            mainAxisExtent: 330,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.5),
                    itemBuilder: (_, index) {
                      return InkWell(
                          onTap: () async {},
                          child: ProductItem(
                            products: productController.productList[index],
                          ));
                    }),
              ),
            ),
            // Container(
            //   color: silver,
            //   child:
            //   SingleChildScrollView(
            //     child:
            //     Column(
            //       children: [
            //         ItemsWidget(
            //           title: productController.catName.value,
            //           products: productController.productList,
            //           hideViewAll: true,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ])),
    );
  }
}
