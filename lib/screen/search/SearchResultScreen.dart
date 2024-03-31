import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/searchController.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widget/commonwidget/reusable_text.dart';
import '../../widget/productItem.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  var searchController = Get.put(SearchResutController());

  @override
  Widget build(BuildContext context) {
    // searchController.searchString.value="";
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
                              const ReusableText(
                                title: "No Item Found!!",
                              )
                            ]),
                      ),
                    ),
        ]));
  }
}
