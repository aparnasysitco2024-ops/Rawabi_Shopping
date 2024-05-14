import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/cartController.dart';
import 'package:rawabi/controller/homeController.dart';
import 'package:rawabi/controller/searchController.dart';
import 'package:rawabi/screen/deliverymode/deliveryModeScreen.dart';
import 'package:rawabi/screen/emptyScreen.dart';
import 'package:rawabi/screen/home/flayerListScreen.dart';
import 'package:rawabi/screen/home/selectSlotScreen.dart';
import 'package:rawabi/screen/search/mySearchDelegate.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/utils/commonUtils.dart';
import 'package:rawabi/widget/adsImageWidget.dart';
import 'package:rawabi/widget/categoryWidget.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';
import 'package:rawabi/widget/itemsWidget.dart';
import 'package:rawabi/widget/mainCategoryItem.dart';

import '../../utils/app_utils.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());

  final cartController = Get.put(CartController());
  final searchController = Get.put(SearchResutController());

  @override
  Widget build(BuildContext context) {
    homeController.getStorageData();
    homeController.getHomeData();
    cartController.getCartList();
    // homeController.getLanguageParam("en","1");

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => homeController.languageParam.value.home != null
          ? Column(
              children: [
                const SizedBox(
                  height: 45,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    SvgPicture.asset("assets/icons/logo.svg", height: 60),
                    Flexible(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        height: 50,
                        decoration: const BoxDecoration(
                            color: silver,
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: Row(children: [
                          InkWell(
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: MySearchDelegate(),
                              );
                            },
                            /*onTap: () async {
                            searchController.searchType.value = "word";
                            AppUtils.navigateToPage( MySearchDelegate());
                          },*/
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/icons/search.svg"),
                                const SizedBox(
                                  width: 5,
                                ),
                                ReusableText(
                                  title:
                                      homeController.languageParam.value.search,
                                ),
                              ],
                            ),
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
                        ]),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      child: SvgPicture.asset("assets/icons/notification.svg"),
                      onTap: () {
                        AppUtils.navigateToPage(EmptyScreen(
                          title: "Notification",
                        ));
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                homeController.isPickup.value
                    ? SizedBox()
                    : Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 0),
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
                                        title: homeController.languageParam
                                            .value.expressDelivery,
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
                                          homeController.isExpress.value =
                                              value;
                                        },
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    AppUtils.navigateToPage(SelectSlotScreen());
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 0),
                                    height: 40,
                                    decoration: const BoxDecoration(
                                        color: silver,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    child: Row(children: [
                                      SvgPicture.asset(
                                        "assets/icons/calendar.svg",
                                        height: 20,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      ReusableText(
                                        title: homeController.languageParam
                                            .value.scheduledDelivery,
                                        size: 11,
                                        weight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 10,
                ),
                //Location
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 30,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [blue, lightBlue, pink]),
                  ),
                  child: Row(children: [
                    SvgPicture.asset(
                      "assets/icons/location.svg",
                      height: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ReusableText(
                      title: homeController.storeAddress.value,
                      size: 12,
                      weight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                      child: InkWell(
                        onTap: () =>
                            AppUtils.navigateToPage(DeliveryModeScreen()),
                        child: ReusableText(
                          title: homeController.languageParam.value.change,
                          size: 9,
                          color: blue,
                        ),
                      ),
                    ),
                    // const Spacer(),
                    // Container(
                    //   padding: const EdgeInsets.all(4),
                    //   decoration: const BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.all(Radius.circular(3))),
                    //   child: InkWell(
                    //     onTap: () =>
                    //         AppUtils.navigateToPage(SelectSlotScreen()),
                    //     child: ReusableText(
                    //       title: "Select Slot".tr,
                    //       size: 9,
                    //       color: blue,
                    //     ),
                    //   ),
                    // ),
                  ]),
                ),
                homeController.loading.value
                    ? Flexible(
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
                    : Expanded(
                        child: Container(
                          color: silver,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                //Top banner
                                homeController.bannerListTop.isNotEmpty
                                    ? FlutterCarousel(
                                        options: CarouselOptions(
                                          initialPage: 1,
                                          autoPlay: true,
                                          enableInfiniteScroll: true,
                                          enlargeCenterPage: true,
                                          viewportFraction: 0.8,
                                          height: 170.0,
                                          showIndicator: false,
                                          slideIndicator:
                                              const CircularSlideIndicator(),
                                        ),
                                        items: homeController.bannerListTop
                                            .map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return InkWell(
                                                onTap: () {
                                                  if (i.linkType ==
                                                      "category") {
                                                    Navigator.pushNamed(
                                                      context,
                                                      '/ProductsByCategory',
                                                      arguments: {
                                                        'catId': i.bannerPoint,
                                                        'subCatId': "0",
                                                        'subSubCatId': "0",
                                                        'subSubSubCatId': "0"
                                                      },
                                                    );
                                                  }
                                                },
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5,
                                                            top: 5,
                                                            bottom: 5),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      child: FadeInImage
                                                          .assetNetwork(
                                                              fit: BoxFit.fill,
                                                              placeholder:
                                                                  'assets/images/logo.png',
                                                              image: i
                                                                  .bannerImage
                                                                  .toString()),
                                                    )),
                                              );
                                            },
                                          );
                                        }).toList(),
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 5,
                                ),
                                //top ads
                                homeController.bannerListTop2.isNotEmpty
                                    ? FlutterCarousel(
                                        options: CarouselOptions(
                                          initialPage: 0,
                                          enableInfiniteScroll: true,
                                          viewportFraction: 1,
                                          showIndicator: false,
                                          height: 60.0,
                                        ),
                                        items: homeController.bannerListTop2
                                            .map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5,
                                                          top: 5,
                                                          bottom: 5,
                                                          left: 5),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: FadeInImage.assetNetwork(
                                                        fit: BoxFit.fill,
                                                        placeholder:
                                                            'assets/images/logo.png',
                                                        image: i.bannerImage
                                                            .toString()),
                                                  ));
                                              // return FadeInImage.assetNetwork(
                                              //     placeholder: 'assets/images/logo.png',
                                              //     image: i.bannerImage.toString());
                                            },
                                          );
                                        }).toList(),
                                      )
                                    : const SizedBox(),

                                //Category
                                GridView.builder(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10, right: 10),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount:
                                        homeController.categoryList.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisSpacing: 15,
                                            mainAxisSpacing: 5,
                                            mainAxisExtent: 130,
                                            crossAxisCount: 4),
                                    itemBuilder: (_, index) {
                                      return MainCategoryItem(
                                          category: homeController
                                              .categoryList[index]);
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                //Flayer
                                InkWell(
                                  onTap: () => AppUtils.navigateToPage(
                                      FlayerListScreen()),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Image.asset(
                                          'assets/images/ads2.png')),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                //Item group
                                ListView.builder(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  itemCount:
                                      homeController.itemGroupList.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) =>
                                      homeController.itemGroupList[index]
                                                  .grpType ==
                                              homeController.grpTypeProduct
                                          ? ItemsWidget(
                                              title: homeController
                                                  .itemGroupList[index].grpName,
                                              products: homeController
                                                  .itemGroupList[index]
                                                  .grpItems,
                                            )
                                          : homeController.itemGroupList[index]
                                                      .grpType ==
                                                  homeController.grpTypeImage
                                              ? AdsImageWidget(
                                                  grpDesign: homeController
                                                      .itemGroupList[index]
                                                      .grpDesign
                                                      .toString(),
                                                  title: homeController
                                                      .itemGroupList[index]
                                                      .grpName,
                                                  itemGroup: homeController
                                                      .itemGroupList[index],
                                                )
                                              : CategoryWidget(
                                                  title: homeController
                                                      .itemGroupList[index]
                                                      .grpName,
                                                  itemGroup: homeController
                                                      .itemGroupList[index],
                                                ),
                                ),

                                const SizedBox(
                                  height: 5,
                                ),

                                // GridAdsWidget(),
                                //
                                // const SizedBox(
                                //   height: 5,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            )
          : SizedBox()),
    );
  }
}
