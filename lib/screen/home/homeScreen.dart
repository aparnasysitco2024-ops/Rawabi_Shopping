import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rawabi/controller/cartController.dart';
import 'package:rawabi/controller/homeController.dart';
import 'package:rawabi/controller/searchController.dart';
import 'package:rawabi/screen/deliverymode/deliveryModeScreen.dart';
import 'package:rawabi/screen/home/flayerListScreen.dart';
import 'package:rawabi/screen/home/notificationListScreen.dart';
import 'package:rawabi/screen/home/selectSlotScreen.dart';
import 'package:rawabi/screen/search/mySearchDelegate.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/utils/commonUtils.dart';
import 'package:rawabi/widget/adsImageWidget.dart';
import 'package:rawabi/widget/categoryWidget.dart';
import 'package:rawabi/widget/commonWidget/networkImageWidget.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';
import 'package:rawabi/widget/itemsWidget.dart';
import 'package:rawabi/widget/mainCategoryItem.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/response/popupBannerResponse.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';
import '../../utils/http_client/base_client.dart';
import '../../widget/commonWidget/reusable_button.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  String? productId;
  final VoidCallback onOffersSelected;

  HomeScreen({
    super.key,
    this.productId = "",
    required this.onOffersSelected,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());

  final cartController = Get.put(CartController());
  final searchController = Get.put(SearchResultController());

  @override
  void initState() {
    if (widget.productId!.isNotEmpty) {
      Timer(const Duration(microseconds: 500), () async {
        Navigator.pushNamed(
          context,
          '/ProductDetailsScreen',
          arguments: {
            'productID': widget.productId,
          },
        );
      });
    } else {
      if (!homeController.isSavedAddressSlotLoaded)
        homeController.getSavedAddressSlot();
      if (!homeController.isPopUpLoaded) getPopupBanner();
      homeController.getHomeCategory();
    }
    super.initState();
  }

  Future<void> getPopupBanner() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      // String appName = packageInfo.appName;
      // String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      // String buildNumber = packageInfo.buildNumber;

      var response = await BaseClient().get(popupBannerUrl);
      if (response != null) {
        var responseData =
            PopupBannerResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          if (responseData.update?.first.forceUpdate == "yes" &&
              getExtendedVersionNumber(version) <
                  getExtendedVersionNumber(
                      responseData.update!.first.version.toString())) {
            //force update
            homeController.showUpdateVersionDialog(
                context, responseData.update?.first.url);
          } else if (responseData.popUpBanners != null &&
              responseData.popUpBanners!.isNotEmpty) {
            //popup banner
            homeController.popUpBannersList.value = responseData.popUpBanners!;
            showPopUpBannerDialog();
          }
        }
      }
    } catch (error) {
      error.printError();
    }
  }

  int getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<dynamic> showPopUpBannerDialog() async {
    homeController.isPopUpLoaded = true;
    return (showDialog(
        useSafeArea: true,
        context: context,
        builder: (_) => new Dialog(
              backgroundColor: Colors.transparent,
              child: new Container(
                  // alignment: FractionalOffset.center,
                  height: double.infinity,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlutterCarousel(
                            options: CarouselOptions(
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                enlargeCenterPage: true,
                                viewportFraction: 1,
                                showIndicator: true,
                                height: double.infinity),
                            items: homeController.popUpBannersList.map((i) {
                              return InkWell(
                                onTap: () {
                                  Get.back();
                                  if (i.linkType == "category") {
                                    homeController.moveToProductList(
                                        context,
                                        i.bannerPoint.toString(),
                                        "0",
                                        "0",
                                        "0",
                                        "0");
                                  } else if (i.linkType == "sub_category") {
                                    homeController.moveToProductList(
                                        context,
                                        i.cat.toString(),
                                        i.bannerPoint.toString(),
                                        "0",
                                        "0",
                                        "0");
                                  } else if (i.linkType == "sub_sub_category") {
                                    homeController.moveToProductList(
                                        context,
                                        i.cat.toString(),
                                        i.subcat.toString(),
                                        i.bannerPoint.toString(),
                                        "0",
                                        "0");
                                  } else if (i.linkType ==
                                      "sub_sub_sub_category") {
                                    homeController.moveToProductList(
                                        context,
                                        i.cat.toString(),
                                        i.subcat.toString(),
                                        i.subsubcat.toString(),
                                        i.bannerPoint.toString(),
                                        "0");
                                  } else if (i.linkType == "product") {
                                    homeController.moveToProductDetails(
                                        context, i.bannerPoint.toString());
                                  } else if (i.linkType == "brand") {
                                    homeController.moveToProductList(
                                        context,
                                        "0",
                                        "0",
                                        "0",
                                        "0",
                                        i.bannerPoint.toString());
                                  } else if (i.linkType == "itemgroup") {
                                    Navigator.pushNamed(
                                      context,
                                      '/ProductsFromHomeScreen',
                                      arguments: {
                                        'title': "i.bannerName",
                                        "grp_id": i.bannerPoint
                                      },
                                    );
                                  } else if (i.linkType == "external_url") {
                                    openUrl(i.bannerPoint ?? "");
                                  }
                                },
                                child: Builder(
                                  builder: (BuildContext context) {
                                    return CachedNetworkImage(
                                        fit: BoxFit.contain,
                                        height: double.infinity,
                                        width: double.infinity,
                                        placeholder: (context, url) => Center(
                                                child:
                                                    new CircularProgressIndicator(
                                              color: primaryColor,
                                            )),
                                        imageUrl: i.bannerImage.toString());
                                  },
                                ),
                              );
                            }).toList(),
                          )),
                      Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 0, top: 0),
                            child: SizedBox(
                              height: 30,
                              child: ReusableButton(
                                  padding: 8.0,
                                  textSize: 9.0,
                                  buttonColor: Colors.white,
                                  textColor: Colors.black,
                                  width: 70.0,
                                  onTap: () {
                                    // AppUtils.navigateToPageReplace(
                                    //      BottomNavBar());
                                    Get.back();
                                  },
                                  title: "Skip".tr),
                            ),
                          )),
                    ],
                  )),
            )));
  }

  @override
  Widget build(BuildContext context) {
    if (!homeController.isPickup.value) homeController.getStorageData();
    // homeController.getHomeData();
    homeController.page = 0;
    homeController.getHomeGroup();
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
                    SvgPicture.asset("assets/icons/logo.svg", height: 47),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        height: 50,
                        decoration: const BoxDecoration(
                            color: silver,
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: Row(children: [
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                showSearch(
                                  context: context,
                                  delegate: MySearchDelegate(),
                                );
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/icons/search.svg"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  ReusableText(
                                    title: homeController
                                        .languageParam.value.search,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // const Spacer(),
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
                        AppUtils.navigateToPage(NotificationListScreen(
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
                                      const EdgeInsets.only(left: 5, right: 5),
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [primaryColor, lightGreen]),
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
                                        activeColor: orange,
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
                              homeController.isExpress.value
                                  ? SizedBox()
                                  : Flexible(
                                      child: InkWell(
                                        onTap: () {
                                          AppUtils.navigateToPage(
                                              SelectSlotScreen());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
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
                                            homeController.selectedStartTime
                                                    .value.isEmpty
                                                ? Expanded(
                                                    child: ReusableText(
                                                      title: homeController
                                                          .languageParam
                                                          .value
                                                          .scheduledDelivery,
                                                      size: 10,
                                                      weight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: ReusableText(
                                                          title: homeController
                                                              .languageParam
                                                              .value
                                                              .scheduledDelivery,
                                                          size: 10,
                                                          weight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: ReusableText(
                                                          title: homeController
                                                                  .selectedStartTime
                                                                  .value +
                                                              " - " +
                                                              homeController
                                                                  .selectedEndTime
                                                                  .value,
                                                          size: 10,
                                                          weight:
                                                              FontWeight.w600,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
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
                  height: 36,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [orange, yellow]),
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/location.svg",
                          height: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 3,
                              ),
                              Expanded(
                                child: ReusableText(
                                  maxLine: 1,
                                  title: homeController.storeAddress.value,
                                  size: 11,
                                  weight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: ReusableText(
                                  maxLine: 1,
                                  title: "(" +
                                      homeController.storeName.value +
                                      ")",
                                  size: 8,
                                  weight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () =>
                              AppUtils.navigateToPage(DeliveryModeScreen()),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                                color: primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                            child: ReusableText(
                              title: homeController.languageParam.value.change,
                              size: 10,
                              color: Colors.white,
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
                Flexible(
                  child: RefreshIndicator(
                    child: homeController.loading.value ||
                            !homeController.isHomeLoaded.value
                        ? SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                          )
                        : Container(
                            color: silver,
                            child: LazyLoadScrollView(
                              scrollOffset: 300,
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
                                              height: 110.0,
                                              showIndicator: false,
                                              slideIndicator:
                                                  const CircularSlideIndicator(),
                                            ),
                                            items: homeController.bannerListTop
                                                .map((i) {
                                              return Builder(
                                                builder:
                                                    (BuildContext context) {
                                                  return InkWell(
                                                    onTap: () {
                                                      if (i.linkType == "external_url") {
                                                      openUrl(i.bannerPoint ?? "");
                                                      } else if (i.linkType ==
                                                          "category") {
                                                        if (i.bannerPoint !=
                                                            "0") {
                                                          homeController
                                                              .moveToProductList(
                                                                  context,
                                                                  i.bannerPoint
                                                                      .toString(),
                                                                  "0",
                                                                  "0",
                                                                  "0",
                                                                  "0");
                                                        }
                                                      } else if (i.linkType ==
                                                          "sub_category") {
                                                        if (i.bannerPoint !=
                                                            "0") {
                                                          homeController
                                                              .moveToProductList(
                                                                  context,
                                                                  i.cat
                                                                      .toString(),
                                                                  i.bannerPoint
                                                                      .toString(),
                                                                  "0",
                                                                  "0",
                                                                  "0");
                                                        }
                                                      } else if (i.linkType ==
                                                          "sub_sub_category") {
                                                        if (i.bannerPoint !=
                                                            "0") {
                                                          homeController
                                                              .moveToProductList(
                                                                  context,
                                                                  i.cat
                                                                      .toString(),
                                                                  i.subcat
                                                                      .toString(),
                                                                  i.bannerPoint
                                                                      .toString(),
                                                                  "0",
                                                                  "0");
                                                        }
                                                      } else if (i.linkType ==
                                                          "sub_sub_sub_category") {
                                                        if (i.bannerPoint !=
                                                            "0") {
                                                          homeController
                                                              .moveToProductList(
                                                                  context,
                                                                  i.cat
                                                                      .toString(),
                                                                  i.subcat
                                                                      .toString(),
                                                                  i.subsubcat
                                                                      .toString(),
                                                                  i.bannerPoint
                                                                      .toString(),
                                                                  "0");
                                                        }
                                                      } else if (i.linkType ==
                                                          "product") {
                                                        homeController
                                                            .moveToProductDetails(
                                                                context,
                                                                i.bannerPoint
                                                                    .toString());
                                                      } else if (i.linkType ==
                                                          "brand") {
                                                        homeController
                                                            .moveToProductList(
                                                                context,
                                                                "0",
                                                                "0",
                                                                "0",
                                                                "0",
                                                                i.bannerPoint
                                                                    .toString());
                                                      } else if (i.linkType ==
                                                          "offer") {
                                                        widget
                                                            .onOffersSelected();
                                                      } else if (i.linkType ==
                                                          "itemgroup") {
                                                        Navigator.pushNamed(
                                                          context,
                                                          '/ProductsFromHomeScreen',
                                                          arguments: {
                                                            'title':
                                                                i.bannerName,
                                                            "grp_id":
                                                                i.bannerPoint
                                                          },
                                                        );
                                                      }
                                                    },
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 5,
                                                                top: 5,
                                                                bottom: 5),
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child:
                                                                NetworkImageWidget(
                                                              image: i
                                                                  .bannerImage
                                                                  .toString(),
                                                              fit: BoxFit.fill,
                                                            )
                                                            // FadeInImage
                                                            //     .assetNetwork(
                                                            //         fit: BoxFit
                                                            //             .fill,
                                                            //         placeholder:
                                                            //             'assets/images/logo.png',
                                                            //         image: i
                                                            //             .bannerImage
                                                            //             .toString()),
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
                                                builder:
                                                    (BuildContext context) {
                                                  return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5,
                                                              top: 5,
                                                              bottom: 5,
                                                              left: 5),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child: FadeInImage
                                                            .assetNetwork(
                                                                fit:
                                                                    BoxFit.fill,
                                                                placeholder:
                                                                    'assets/images/logo.png',
                                                                image: i
                                                                    .bannerImage
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
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              child: CachedNetworkImage(
                                                  fit: BoxFit.contain,
                                                  width: double.infinity,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                          child:
                                                              new CircularProgressIndicator(
                                                        color: primaryColor,
                                                      )),
                                                  imageUrl:
                                                      "https://rawabihypermarket.com/assets/flyer-banner.jpg")
                                              // Image.asset(
                                              //   fit: BoxFit.cover,
                                              //   'assets/images/flayer.jpg'),
                                              )),
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) =>
                                          homeController.itemGroupList[index]
                                                      .grpType ==
                                                  homeController.grpTypeProduct
                                              ? ItemsWidget(
                                                  title: homeController
                                                      .itemGroupList[index]
                                                      .grpName,
                                                  products: homeController
                                                      .itemGroupList[index]
                                                      .grpItems,
                                                  groupImage: homeController
                                                      .itemGroupList[index]
                                                      .grpImage,
                                                  grp_id: homeController
                                                      .itemGroupList[index]
                                                      .grpId)
                                              : homeController
                                                          .itemGroupList[index]
                                                          .grpType ==
                                                      homeController
                                                          .grpTypeImage
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
                              onEndOfPage: () {
                                homeController.getHomeGroup();
                              },
                            ),
                          ),
                    onRefresh: () async {
                      // homeController.getHomeData();
                      homeController.page = 0;
                      homeController.getHomeGroup();
                    },
                  ),
                ),
              ],
            )
          : SizedBox()),
    );
  }
}
