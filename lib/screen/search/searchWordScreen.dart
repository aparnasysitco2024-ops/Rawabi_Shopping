import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controller/searchController.dart';
import '../../utils/colors.dart';
import '../../widget/commonwidget/reusable_text.dart';
import '../../widget/productItem.dart';


class MySearchDelegate extends SearchDelegate {
  var searchController = Get.put(SearchResutController());
  MySearchDelegate( );

  @override
  Widget? buildLeading(BuildContext context) =>
      IconButton(
          icon: const Icon(Icons.arrow_back),
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
      /*Container(
            height: 150,
            color: white,
            width: double.maxFinite,
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
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
                        Get.back();
                        Get.delete<SearchController>();
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
                            borderRadius:
                            BorderRadius.all(Radius.circular(7))),
                        margin: const EdgeInsets.only(right: 20),
                        child: Row(children: [
                          Container(
                            width: 220,
                            height: 42,
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: silver,
                                borderRadius:
                                BorderRadius.all(Radius.circular(4))),
                            padding: const EdgeInsets.only(right: 10),
                            child: TextField(
                              autofocus: true,
                              controller:
                              searchController.searchTextController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: silver,
                                // hintText:
                                //     searchController.searchString.value,
                                contentPadding:
                                const EdgeInsets.only(left: 10),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: blackLight,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onSubmitted: (value) {
                                if(value.isNotEmpty){
                                  //print("searching for $value");
                                  searchController.searchType.value = "word";
                                  searchController.searchString.value = value;
                                  searchController.getProductsByWordSearch();
                                  setState(() {});
                                }

                              },
                              onTap: (){
                                setState(() {
                                  searchController.searchTextController.text="";
                                });
                              },
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                searchController.searchType.value =
                                "barcode";
                                searchController.scanBarcodeNormal();
                                //  print("searching for ${searchController.searchString}");
                                searchController.getProductsByBarcodeSearch();
                                setState(() {});
                              },
                              child:
                              SvgPicture.asset("assets/icons/scan.svg"))
                        ]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),*/
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
                  mainAxisExtent: 295,
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
                const ReusableText(
                  title: "No Item Found!!",
                )
              ]),
        ),
      ),
    ]));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = ['Chicken', 'oil', 'soap', 'Fish','sandwitch'];
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

  /*Widget LoadSearchResults(BuildContext context) {
    return FutureBuilder(
        future: getSearchResult(query),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          // Checking if future is resolved or not
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: const TextStyle(fontSize: 18),
                ),
              );

              // if we got our data
            } else if (snapshot.hasData) {
              List<Item> itemList = snapshot.data;
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return itemListCard(itemList[index],context);
                  });
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget itemListCard(Item item,BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 70,
        width: MediaQuery.of(context).size.width,
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 2.3 / 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                normalBoldText(item.name),
                normalBoldText("${item.price}  ${item.currency}"),
              ],
            ),
          ),
          ItemCounter(itemKey: item.key, tableKey: tableKey),
        ]),
      ),
    );
  }
*/


}