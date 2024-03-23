import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../controller/categoryController.dart';
import '../widget/categoryItemTile.dart';
import '../widget/subCategoryItemTile.dart';

// ignore: must_be_immutable
class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final categoryController = Get.put(CategoryController());
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
    categoryController.getCategory();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ReusableText(
                    title: "Categories".tr, size: 18, weight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                height: 42,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: const BoxDecoration(
                    color: silver,
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                child: Row(children: [
                  SvgPicture.asset("assets/icons/search.svg"),
                  const SizedBox(
                    width: 15,
                  ),
                  ReusableText(
                    title: _scanBarcode==""?
                        "What are you looking for?".tr
                    :_scanBarcode,
                    color: darkGrey,
                    size: 14,
                    weight: FontWeight.w600,
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
              !categoryController.loading.value
                  ? Expanded(
                      child: Container(
                        color: silver,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                  margin: const EdgeInsets.all(10),
                                  //Main category
                                  child: MainCategory()),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height - 280,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    ),
            ],
          )),
    );
  }
}

class MainCategory extends StatelessWidget {
  final categoryController = Get.put(CategoryController());

  MainCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ExpandedTileList.builder(
          padding: const EdgeInsets.all(0),
          itemCount: categoryController.categoryList.length,
          maxOpened: 1,
          itemBuilder: (context, index, controller) {
            return ExpandedTile(
              theme: const ExpandedTileThemeData(
                headerColor: Colors.white,
                // headerRadius: 8,
                headerPadding: EdgeInsets.all(5),
                leadingPadding: EdgeInsets.all(0),
                // headerSplashColor: lightPink,
                // contentBackgroundColor: Colors.white,
                contentPadding: EdgeInsets.all(0),
                // contentRadius: 8
              ),
              controller: index == 2
                  ? controller.copyWith(isExpanded: true)
                  : controller,
              title: CategoryItemTile(
                  category: categoryController.categoryList[index]),
              content: categoryController.subCategoryList.isNotEmpty
                  ? SubCategory()
                  : const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    ),
              onTap: () {
                if (controller.isExpanded) {
                  categoryController.getSubCategory(
                      categoryController.categoryList[index].catId.toString(),
                      0);
                }
              },
            );
          },
        ));
  }
}

class SubCategory extends StatelessWidget {
  final categoryController = Get.put(CategoryController());

  SubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ExpandedTileList.builder(
          padding: const EdgeInsets.all(0),
          itemCount: categoryController.subCategoryList.length,
          maxOpened: 1,
          itemBuilder: (context, index, controller) {
            return ExpandedTile(
              theme: const ExpandedTileThemeData(
                headerColor: Colors.white,
                // headerRadius: 8,
                headerPadding: EdgeInsets.all(5),
                leadingPadding: EdgeInsets.all(0),
                // headerSplashColor: lightPink,
                // contentBackgroundColor: Colors.white,
                contentPadding: EdgeInsets.all(0),
                // contentRadius: 8
              ),
              controller: index == 2
                  ? controller.copyWith(isExpanded: true)
                  : controller,
              title: SubCategoryItemTile(
                  subCategory: categoryController.subCategoryList[index]),
              content:
                  categoryController.subCategoryList[index].subCategory == 0
                      ? const SizedBox()
                      : categoryController.subSubCategoryList.isNotEmpty
                          ? SubSubCategory()
                          : const SizedBox(
                              height: 100,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              ),
                            ),
              onTap: () {
                if (categoryController.subCategoryList[index].subCategory ==
                    1) {
                  if (controller.isExpanded) {
                    categoryController.getSubCategory(
                        categoryController.subCategoryList[index].catId
                            .toString(),
                        1);
                  }
                } else {
                  Navigator.pushNamed(
                    context,
                    '/ProductsByCategory',
                    arguments: categoryController.subCategoryList[index].catId,
                  );
                  /*AppUtils.navigateToPage(ProductsByCategory(
                      catID: categoryController.subCategoryList[index].catId));*/
                }
              },
            );
          },
        ));
  }
}

class SubSubCategory extends StatelessWidget {
  final categoryController = Get.put(CategoryController());

  SubSubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ExpandedTileList.builder(
          padding: const EdgeInsets.all(0),
          itemCount: categoryController.subSubCategoryList.length,
          maxOpened: 1,
          itemBuilder: (context, index, controller) {
            return ExpandedTile(
              theme: const ExpandedTileThemeData(
                headerColor: Colors.white,
                // headerRadius: 8,
                headerPadding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                leadingPadding: EdgeInsets.all(0),
                // headerSplashColor: lightPink,
                // contentBackgroundColor: Colors.white,
                contentPadding: EdgeInsets.all(0),
                // contentRadius: 8
              ),
              controller: index == 2
                  ? controller.copyWith(isExpanded: true)
                  : controller,
              title: SubCategoryItemTile(
                  subCategory: categoryController.subSubCategoryList[index]),
              content:
                  categoryController.subSubCategoryList[index].subCategory == 0
                      ? const SizedBox()
                      : categoryController.subSubSubCategoryList.isNotEmpty
                          ? SubSubSubCategory()
                          : const SizedBox(
                              height: 100,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              ),
                            ),
              onTap: () {
                if (categoryController.subSubCategoryList[index].subCategory ==
                    1) {
                  if (controller.isExpanded) {
                    categoryController.getSubCategory(
                        categoryController.subSubCategoryList[index].catId
                            .toString(),
                        2);
                  }
                } else {
                  Navigator.pushNamed(
                    context,
                    '/ProductsByCategory',
                    arguments: categoryController.subSubCategoryList[index].catId,
                  );
                  /*AppUtils.navigateToPage(ProductsByCategory(
                      catID:
                          categoryController.subSubCategoryList[index].catId));
                */}
              },
            );
          },
        ));
  }
}

class SubSubSubCategory extends StatelessWidget {
  final categoryController = Get.put(CategoryController());

  SubSubSubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ExpandedTileList.builder(
          padding: const EdgeInsets.all(0),
          itemCount: categoryController.subSubSubCategoryList.length,
          maxOpened: 1,
          itemBuilder: (context, index, controller) {
            return ExpandedTile(
              theme: const ExpandedTileThemeData(
                headerColor: Colors.white,
                // headerRadius: 8,
                headerPadding: EdgeInsets.only(left: 40, top: 5, bottom: 5),
                leadingPadding: EdgeInsets.all(0),
                // headerSplashColor: lightPink,
                // contentBackgroundColor: Colors.white,
                contentPadding: EdgeInsets.all(0),
                // contentRadius: 8
              ),
              controller: index == 2
                  ? controller.copyWith(isExpanded: true)
                  : controller,
              title: SubCategoryItemTile(
                  subCategory: categoryController.subSubSubCategoryList[index]),
              content: categoryController.subSubSubCategoryList.isNotEmpty
                  ? const SizedBox()
                  : const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/ProductsByCategory',
                  arguments: categoryController.subSubSubCategoryList[index].catId,
                );
                // if (controller.isExpanded) {
                /*AppUtils.navigateToPage(ProductsByCategory(
                    catID:
                        categoryController.subSubSubCategoryList[index].catId));
                */// }
              },
            );
          },
        ));
  }
}
