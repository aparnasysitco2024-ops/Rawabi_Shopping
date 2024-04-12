import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:rawabi/controller/productsController.dart';
import 'package:rawabi/screen/filtersScreen.dart';
import 'package:rawabi/screen/search/mySearchDelegate.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';
import 'package:rawabi/widget/productItem.dart';
import 'package:rawabi/widget/sort_options.dart';

import '../controller/homeController.dart';
import '../controller/searchController.dart';
import '../utils/constants.dart';

// ignore: must_be_immutable
class ProductsByCategory extends StatefulWidget {
  const ProductsByCategory({
    super.key,
  });

  @override
  State<ProductsByCategory> createState() => _ProductsByCategoryState();
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  final homeController = Get.put(HomeController());
  var searchController = Get.put(SearchResutController());
  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final catID = arguments['catId'] ?? "0";
    final subCatID = arguments['subCatId'] ?? "0";
    final subSubCatID = arguments['subSubCatId'] ?? "0";
    // final subSubSubCatID = arguments['subSubSubCatId'] ?? "0";

    productController.getSubCategory(catID,subCatID,subSubCatID);

    // productController.getProductsByCat(
    //     catID.toString(), subCatID.toString(), subSubCatID, subSubSubCatID);
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        // Navigator.of(context).popUntil(ModalRoute.withName('/'));
        Get.delete<ProductController>();
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
                      Get.delete<ProductController>();
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
                            title: productController.catName.value,
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
                  homeController.isPickup.value
                      ? Spacer()
                      : Flexible(
                          child: Container(
                            padding: const EdgeInsets.only(left: 5, right: 0),
                            height: 40,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [blue, lightBlue, pink]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
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
                    onTap: () {
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
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: ((context) {
                            return SortOptionsWidget(
                              onPressed: (val) {
                                Navigator.pop(context);
                                productController.sort.value = val;
                                productController.getProductsByCat(
                                    catID.toString(),
                                    subCatID.toString(),
                                    subSubCatID,
                                    productController.subSubSubCatID.value);
                              },
                            );
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
              Container(
                height: 35,
                child: ListView.builder(

                    padding: const EdgeInsets.only(left: 10, right: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: productController.subCategoryList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: OutlineGradientButton(
                          radius: Radius.circular(5),
                          padding: EdgeInsets.all(5),
                          strokeWidth: 1.5,
                          backgroundColor: silver,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: productController
                                          .subSubSubCatID.value ==
                                      productController
                                          .subCategoryList[index].catId
                                  ? [blue, lightBlue, pink]
                                  : [silver, silver, silver]),
                          onTap: () {
                            productController.subSubSubCatID.value =
                                productController.subCategoryList[index].catId!;
                            productController.subCategoryList.refresh();
                            productController.getProductsByCat(
                                catID,
                                subCatID,
                                subSubCatID,
                                productController.subCategoryList[index].catId
                                    .toString());
                          },
                          child: ReusableText(
                            title: productController
                                .subCategoryList[index].catName,
                            color: darkGrey,
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              productController.loading.value
                  ? const Flexible(
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      ),
                    )
                  : productController.productList.isNotEmpty
                      ? Flexible(
                          child: Container(
                            height: double.infinity,
                            color: silver,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: GridView.builder(
                                padding: const EdgeInsets.only(top: 10),
                                shrinkWrap: true,
                                itemCount: productController.productList.length,
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
                                        products: productController
                                            .productList[index],
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
