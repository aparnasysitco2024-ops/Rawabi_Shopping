/*
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
}
*/
