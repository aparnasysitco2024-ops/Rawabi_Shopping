import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:rawabi/controller/productsController.dart';
import 'package:rawabi/screen/filtersScreen.dart';
import 'package:rawabi/screen/search/mySearchDelegate.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/Commonwidget/reusable_text.dart';
import 'package:rawabi/widget/productItem.dart';
import 'package:rawabi/widget/sort_options.dart';

import '../controller/homeController.dart';
import '../controller/searchController.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';

// ignore: must_be_immutable
class ProductsByCategory extends StatefulWidget {
  bool isOffer = false;

  ProductsByCategory({super.key, this.isOffer = false});

  @override
  State<ProductsByCategory> createState() => _ProductsByCategoryState();
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  final homeController = Get.put(HomeController());
  var searchController = Get.put(SearchResultController());
  late var productController =
      Get.put(ProductController(isOffer: widget.isOffer));

  // var catID = "0", subCatID, subSubCatID;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        final arguments = (ModalRoute.of(context)?.settings.arguments ??
            <String, dynamic>{}) as Map;

        productController.catID.value = arguments['catId'] ?? "0";
        productController.subCatID.value = arguments['subCatId'] ?? "0";
        productController.subSubCatID.value = arguments['subSubCatId'] ?? "0";
        productController.subSubSubCatID.value =
            arguments['subSubSubCatId'] ?? "0";
        productController.brandId.value = arguments['brandId'] ?? "0";
        // final subSubSubCatID = arguments['subSubSubCatId'] ?? "0";

        if (productController.brandId.value != "0")
          productController.getProductsByBrand();
        else if (productController.subSubCatID.value != "0")
          productController.getSubCategory();
        else if (productController.catID.value != "0")
          productController.getSubCategory();
        else
          productController.getProductsByCat();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
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
                  InkWell(
                    child: Container(
                      child: SvgPicture.asset("assets/icons/back.svg"),
                      width: 40,
                      height: 50,
                      padding: EdgeInsets.all(15),
                    ),
                    onTap: () {
                      Navigator.of(context).popUntil(ModalRoute.withName('/'));
                    },
                  ),
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 50,
                      decoration: const BoxDecoration(
                          color: silver,
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: MySearchDelegate(
                                    catID: productController.catID.value),
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
                            ]),
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () async {
                                searchController.searchType.value = "barcode";
                                await searchController
                                    .scanBarcodeNormal()
                                    .whenComplete(() {
                                  searchController.searchProductList.isNotEmpty
                                      ? Navigator.pushNamed(
                                          context,
                                          '/ProductDetailsScreen',
                                          arguments: {
                                            'productID': searchController
                                                .searchProductList[0].productId,
                                          },
                                        )
                                      : CommonUtils().messageBox(
                                          "Unable to identify item!");
                                });
                              },
                              child: SvgPicture.asset("assets/icons/scan.svg"))
                        ],
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
                            padding: const EdgeInsets.only(left: 5, right: 5),
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
                                  title: homeController
                                      .languageParam.value.expressDelivery,
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
                  if (productController.brandId.value == "0")
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            AppUtils.navigateToPage(FiltersScreen(
                              isOffer: widget.isOffer,
                              price: productController.price.value,
                              selectedItem: (filterRequest) {
                                productController.pageNumber.value = 1;
                                filterRequest.catid =
                                    productController.catID.value;
                                filterRequest.subcatid =
                                    productController.subCatID.value;
                                filterRequest.subSubcatid =
                                    productController.subSubCatID.value;
                                filterRequest.subSubSubcatid =
                                    productController.subSubSubCatID.value;
                                productController.topSelectedCatId.value =
                                    filterRequest.selectedTopCategoryID!;

                                if (productController
                                        .topSelectedCategoryTypeID ==
                                    category) {
                                  filterRequest.catid =
                                      filterRequest.selectedTopCategoryID;
                                } else if (productController
                                        .topSelectedCategoryTypeID ==
                                    subCategory) {
                                  productController.subCatID.value =
                                      productController.topSelectedCatId.value;
                                  filterRequest.subcatid =
                                      filterRequest.selectedTopCategoryID;
                                } else if (productController
                                        .topSelectedCategoryTypeID ==
                                    subSubCategory) {
                                  productController.subSubCatID.value =
                                      productController.topSelectedCatId.value;
                                  filterRequest.subSubcatid =
                                      filterRequest.selectedTopCategoryID;
                                } else if (productController
                                        .topSelectedCategoryTypeID ==
                                    subSubSubCategory) {
                                  productController.subSubSubCatID.value =
                                      productController.topSelectedCatId.value;
                                  filterRequest.subSubSubcatid =
                                      filterRequest.selectedTopCategoryID;
                                }

                                productController.getFilterData(filterRequest);
                              },
                              brandList: productController.brandsList,
                              subCategoryListFilter:
                                  productController.subCategoryList,
                              selectedTopCategoryID:
                                  productController.topSelectedCatId.value,
                            ));
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
                                title:
                                    homeController.languageParam.value.filter,
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
                      ],
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
                                productController.pageNumber.value = 1;

                                if (productController.brandId.value != "0")
                                  productController.getProductsByBrand();
                                // else if (productController.subSubCatID.value !=
                                //     "0")
                                //   productController.getSubCategory();
                                // else if (productController.catID.value != "0")
                                //   productController.getSubCategory();
                                else
                                  productController.getProductsByCat();
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
                          title: homeController.languageParam.value.sort,
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
              productController.subCategoryList.isNotEmpty
                  ? Container(
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
                                                .topSelectedCatId.value ==
                                            productController
                                                .subCategoryList[index].catId
                                        ? [blue, lightBlue, pink]
                                        : [silver, silver, silver]),
                                onTap: () {
                                  productController.isLoaded = false;
                                  productController.topSelectedCatId.value =
                                      productController
                                          .subCategoryList[index].catId!;
                                  if (productController
                                          .topSelectedCategoryTypeID ==
                                      category) {
                                    productController.catID.value =
                                        productController
                                            .topSelectedCatId.value;
                                  } else if (productController
                                          .topSelectedCategoryTypeID ==
                                      subCategory) {
                                    productController.subCatID.value =
                                        productController
                                            .topSelectedCatId.value;
                                  } else if (productController
                                          .topSelectedCategoryTypeID ==
                                      subSubCategory) {
                                    productController.subSubCatID.value =
                                        productController
                                            .topSelectedCatId.value;
                                  } else if (productController
                                          .topSelectedCategoryTypeID ==
                                      subSubSubCategory) {
                                    productController.subSubSubCatID.value =
                                        productController
                                            .topSelectedCatId.value;
                                  }

                                  productController.subCategoryList.refresh();
                                  productController.pageNumber.value = 1;
                                  productController.getProductsByCat();
                                },
                                child: ReusableText(
                                  title: productController
                                      .subCategoryList[index].catName,
                                  color: darkGrey,
                                ),
                              ),
                            );
                          }),
                    )
                  : SizedBox(),
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
                            child: LazyLoadScrollView(
                              scrollOffset: 100,
                              onEndOfPage: () {
                                print("=------------load more---------------");
                                productController.pageNumber.value =
                                    productController.pageNumber.value + 1;
                                if (productController.isFiltered) {
                                  productController.getFilterData(
                                      productController.filterRequest!);
                                } else if (productController.brandId.value !=
                                    "0")
                                  productController.getProductsByBrand();
                                else
                                  productController.getProductsByCat();
                              },
                              child: GridView.builder(
                                  padding: const EdgeInsets.only(top: 10),
                                  shrinkWrap: true,
                                  itemCount:
                                      productController.productList.length,
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
