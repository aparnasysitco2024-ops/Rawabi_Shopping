import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controller/searchController.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widget/commonwidget/reusable_text.dart';
import '../../widget/productItem.dart';


class MySearchDelegate extends SearchDelegate {
  var searchController = Get.put(SearchResutController());
  MySearchDelegate( );

  @override
  Widget? buildLeading(BuildContext context) =>
      IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => close(context, null));

  @override
  List<Widget>? buildActions(BuildContext context) =>
      [
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
    searchController.getProductsByWordSearch(query);
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
                return InkWell(
                    onTap: () async {},
                    child: ProductItem(
                      products: searchController
                          .searchProductList[index],
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
    ]));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = ['Chicken'.tr, 'oil'.tr, 'soap'.tr, 'Fish'.tr,'sandwitch'.tr];
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;

            showResults(context);
          },
        );
      },
    );
  }


}