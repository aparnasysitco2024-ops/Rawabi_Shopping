import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controller/searchController.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widget/commonwidget/reusable_text.dart';
import '../../widget/productItem.dart';

class MySearchDelegate extends SearchDelegate {
  var searchController = Get.put(SearchResultController());
  var catID;
  var searchCatID = "";

  MySearchDelegate({this.catID = ""});

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.keyboard_arrow_left),
      onPressed: () => close(context, null));

  @override
  TextStyle? get searchFieldStyle {
    return TextStyle(fontSize: 15.0);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor: Colors.white,
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
        ),
      ];

  @override
  Widget buildResults(BuildContext context) {
    searchController.getProductsByWordSearch(query, searchCatID);
    return Obx(() => Column(children: [
          searchController.loading.value
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
              : searchController.searchProductList.isNotEmpty
                  ? Flexible(
                      child: Container(
                        height: double.infinity,
                        color: silver,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: GridView.builder(
                            padding: const EdgeInsets.only(top: 15),
                            shrinkWrap: true,
                            itemCount:
                                searchController.searchProductList.length,
                            // physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 12,
                                    mainAxisExtent: productItemHeight,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 0.5),
                            itemBuilder: (_, index) {
                              return ProductItem(
                                products:
                                    searchController.searchProductList[index],
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
                              SvgPicture.asset("assets/icons/logo.svg",height: 80,),
                              ReusableText(
                                title: "No Item Found!!".tr,
                              )
                            ]),
                      ),
                    ),
        ]));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchCatID = catID;
    if (query.length > 2) {
      searchController.getAutoSuggestion(query, catID);
    } else {
      searchController.searchSuggestionList.clear();
      searchController.searchSuggestionCategoryList.clear();
    }
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            searchController.searchSuggestionCategoryList.isEmpty &&
                    searchController.searchSuggestionList.isEmpty
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: searchController.recentSearch.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          query = searchController.recentSearch[index];
                          showResults(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 45,
                                    height: 45,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(
                                        'assets/icons/search.svg',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Flexible(
                                    child: ReusableText(
                                      title:
                                          searchController.recentSearch[index],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                height: 0.5,
                                thickness: 0.5,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox(),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: searchController.searchSuggestionCategoryList.length,
              itemBuilder: (BuildContext context, int index) {
                // final suggestion =
                //     searchController.searchSuggestionCategoryList[index].product;
                //
                return InkWell(
                  onTap: () {
                    // searchController.getProductsByWordSearch(query, searchController.searchSuggestionCategoryList[index].categoryId);
                    // query = suggestion!;
                    searchCatID = searchController
                        .searchSuggestionCategoryList[index].categoryId!;
                    showResults(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 45,
                              height: 45,
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ReusableText(
                                    title: query,
                                  ),
                                  ReusableText(
                                    color: primaryColor,
                                    title: searchController
                                        .searchSuggestionCategoryList[index]
                                        .categoryName,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          height: 0.5,
                          thickness: 0.5,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: searchController.searchSuggestionList.length,
              itemBuilder: (BuildContext context, int index) {
                final suggestion =
                    searchController.searchSuggestionList[index].product;

                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/ProductDetailsScreen',
                      arguments: {
                        'productID': searchController
                            .searchSuggestionList[index].productId,
                      },
                    );
                    // searchController.getProductsByWordSearch(suggestion!, catID);
                    // query = suggestion!;
                    // showResults(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  placeholder: 'assets/images/logo.png',
                                  image: searchController
                                      .searchSuggestionList[index].image
                                      .toString()),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: ReusableText(
                                title: suggestion,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          height: 0.5,
                          thickness: 0.5,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
