import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/search/mySearchDelegate.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../../controller/homeController.dart';
import '../../widget/mainCategoryItem.dart';

// ignore: must_be_immutable
class CategoryFromHomeScreen extends StatefulWidget {
  const CategoryFromHomeScreen({
    super.key,
  });

  @override
  State<CategoryFromHomeScreen> createState() => _CategoryFromHomeScreenState();
}

class _CategoryFromHomeScreenState extends State<CategoryFromHomeScreen> {
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

    final category = arguments['category'];
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
               category.isNotEmpty
                      ? Flexible(
                          child: Container(
                            height: double.infinity,
                            color: silver,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child:  GridView.builder(
                          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                   scrollDirection: Axis.vertical,
                   shrinkWrap: true,
                   physics: const ClampingScrollPhysics(),
                   itemCount: category.length,
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisSpacing: 15,
                       mainAxisSpacing: 5,
                       mainAxisExtent: 130,
                       crossAxisCount: 4),
                   itemBuilder: (_, index) {
                     return MainCategoryItem(
                       category: category![index],
                     );
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
                                  const ReusableText(
                                    title: "No Item Found!!",
                                  )
                                ]),
                          ),
                        ),
            ])),
      ),
    );
  }
}
