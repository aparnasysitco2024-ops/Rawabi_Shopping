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
    searchController.getProductsByWordSearch(query,catID);
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
                              SvgPicture.asset("assets/icons/logo.svg"),
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
    List<String> suggestions = [
      'Chicken'.tr,
      'Oil'.tr,
      'Soap'.tr,
      'Fish'.tr,
      'Sandwich'.tr
    ];
    return ListView.builder(
      itemCount: 0,
      itemBuilder: (BuildContext context, int index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(
            suggestion,
            style: TextStyle(fontSize: 15),
          ),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
