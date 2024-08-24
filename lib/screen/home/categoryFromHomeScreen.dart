import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/search/mySearchDelegate.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../../controller/homeController.dart';
import '../../controller/searchController.dart';
import '../../utils/commonUtils.dart';
import '../../widget/categoryGroupItem.dart';

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
  final searchController = Get.put(SearchResultController());

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
        body: Column(children: [
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
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: MySearchDelegate(catID: category),
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
                                  : CommonUtils()
                                      .messageBox("Unable to identify item!");
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
          category.isNotEmpty
              ? Flexible(
                  child: Container(
                    height: double.infinity,
                    color: silver,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: GridView.builder(
                        padding:
                            const EdgeInsets.only(left: 10, top: 10, right: 10),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: category.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 5,
                                mainAxisExtent: 130,
                                crossAxisCount: 4),
                        itemBuilder: (_, index) {
                          return CategoryGroupItem(
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
                          SvgPicture.asset("assets/icons/logo.svg",height: 80,),
                          const ReusableText(
                            title: "No Item Found!!",
                          )
                        ]),
                  ),
                ),
        ]),
      ),
    );
  }
}
