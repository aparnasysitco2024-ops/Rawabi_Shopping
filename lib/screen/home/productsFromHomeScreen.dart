import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/filtersScreen.dart';
import 'package:rawabi/screen/search/mySearchDelegate.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';
import 'package:rawabi/widget/productItem.dart';

import '../../controller/homeController.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';
import '../../widget/sort_options.dart';

// ignore: must_be_immutable
class ProductsFromHomeScreen extends StatefulWidget {
  const ProductsFromHomeScreen({
    super.key,
  });

  @override
  State<ProductsFromHomeScreen> createState() => _ProductsFromHomeScreenState();
}

class _ProductsFromHomeScreenState extends State<ProductsFromHomeScreen> {
  final homeController = Get.put(HomeController());

  /* String _scanBarcode = '';

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
  }*/

  @override
  Widget build(BuildContext context) {
    // final catID = ModalRoute.of(context)?.settings.arguments;
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final products = arguments['products'];
    final title = arguments['title'];

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        // Navigator.of(context).popUntil(ModalRoute.withName('/'));
        // Get.delete<ProductController>();
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
                    width: 20,
                  ),
                  InkWell(
                    child: SvgPicture.asset("assets/icons/back.svg"),
                    onTap: () {
                      Navigator.of(context).popUntil(ModalRoute.withName('/'));
                      // Get.delete<ProductController>();
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
                      child: InkWell(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: MySearchDelegate(),
                          );
                        },
                        /*onTap: () async {
                          AppUtils.navigateToPage(const SearchScreen());
                        },*/
                        child: Row(children: [
                          SvgPicture.asset("assets/icons/search.svg"),
                          const SizedBox(
                            width: 5,
                          ),
                          ReusableText(
                            title: title,
                          ),
                          const Spacer(),
                          SvgPicture.asset("assets/icons/scan.svg")
                        ]),
                      ),
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
                  InkWell(
                    onTap: (){
                     AppUtils.navigateToPage(FiltersScreen());
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/filter.svg",
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                         ReusableText(
                          title: "Filter".tr,
                          size: 12,
                          weight: FontWeight.w800,
                        )
                      ],
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
                  InkWell(
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          builder: ((context) {
                            return SortOptionsWidget();
                          }));
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/sort.svg",
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                         ReusableText(
                          title: "Sort".tr,
                          size: 12,
                          weight: FontWeight.w800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
               products.isNotEmpty
                      ? Flexible(
                          child: Container(
                            height: double.infinity,
                            color: silver,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: GridView.builder(
                                padding: const EdgeInsets.only(top: 15),
                                shrinkWrap: true,
                                itemCount: products.length,
                                // physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 12,
                                        mainAxisExtent: productItemHeight,
                                        crossAxisSpacing: 12,
                                        childAspectRatio: 0.5),
                                itemBuilder: (_, index) {
                                  return InkWell(
                                      onTap: () async {},
                                      child: ProductItem(
                                        products: products[index],
                                      ));
                                }),
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
                                    title: "No Item Found!!".tr,
                                  )
                                ]),
                          ),
                        ),
            ])),
      ),
    );
  }
}
