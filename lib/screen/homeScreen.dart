import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/homeController.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/adsWidget.dart';
import 'package:rawabi/widget/categoryWidget.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';
import 'package:rawabi/widget/gridAdsWidget.dart';
import 'package:rawabi/widget/itemsWidget.dart';
import 'package:rawabi/widget/mainCategoryItem.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    homeController.getHomeData();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => Column(
            children: [
              const SizedBox(
                height: 50,
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
                        SvgPicture.asset("assets/icons/search.svg"),
                        const Spacer(),
                        SvgPicture.asset("assets/icons/scan.svg")
                      ]),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: SvgPicture.asset("assets/icons/notification.svg"),
                    onTap: () {
                      // AppUtils.navigateToPage(
                      //     ProductDetailsScreen(productID: "3"));
                    },
                  ),
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
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5, right: 0),
                      height: 40,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [blue, lightBlue, pink]),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
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
                            title: "Express delivery".tr,
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
                    width: 5,
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5, right: 0),
                      height: 40,
                      decoration: const BoxDecoration(
                          color: silver,
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Row(children: [
                        SvgPicture.asset(
                          "assets/icons/calendar.svg",
                          height: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ReusableText(
                          title: "Scheduled delivery".tr,
                          size: 11,
                          weight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
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
                  const ReusableText(
                    title: "deliver to: al wakra, doha, qatar",
                    size: 12,
                    weight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    child: ReusableText(
                      title: "Change".tr,
                      size: 9,
                      color: blue,
                    ),
                  )
                ]),
              ),

              Expanded(
                child: Container(
                  color: silver,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        //Top banner
                        homeController.bannerList.isNotEmpty
                            ? FlutterCarousel(
                                options: CarouselOptions(
                                  initialPage: 1,
                                  height: 180.0,
                                  showIndicator: false,
                                  slideIndicator:
                                      const CircularSlideIndicator(),
                                ),
                                items: homeController.bannerList.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5, top: 5, bottom: 5),
                                          child: FadeInImage.assetNetwork(
                                              fit: BoxFit.fill,
                                              placeholder:
                                                  'assets/images/logo.png',
                                              image: i.bannerImage.toString()));
                                    },
                                  );
                                }).toList(),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 5,
                        ),
                        //top ads
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset('assets/images/ads.png')),
                        const SizedBox(
                          height: 5,
                        ),
                        //Category
                        GridView.builder(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, right: 10),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: homeController.categoryList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 5,
                                    mainAxisExtent: 130,
                                    crossAxisCount: 4),
                            itemBuilder: (_, index) {
                              return MainCategoryItem(
                                  category: homeController.categoryList[index]);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset('assets/images/ads2.png')),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.only(top: 0.0),
                          itemCount: homeController.itemGroupList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => homeController
                                      .itemGroupList[index].grpType ==
                                  homeController.grpTypeProduct
                              ? ItemsWidget(
                                  title: homeController
                                      .itemGroupList[index].grpName,
                                  products: homeController
                                      .itemGroupList[index].grpItems,
                                )
                              : homeController.itemGroupList[index].grpType ==
                                      homeController.grpTypeImage
                                  ? AdsWidget(
                                      title: homeController
                                          .itemGroupList[index].grpName,
                                      itemGroup:
                                          homeController.itemGroupList[index],
                                    )
                                  : CategoryWidget(
                                      title: homeController
                                          .itemGroupList[index].grpName,
                                      itemGroup:
                                          homeController.itemGroupList[index],
                                    ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 5, left: 0, right: 0, bottom: 5),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [blue, lightBlue, pink]),
                          ),
                          child: FlutterCarousel(
                            options: CarouselOptions(
                              height: 180.0,
                              showIndicator: false,
                            ),
                            items: homeController.bannerList2.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5, top: 5, bottom: 5),
                                    child: Image.asset(
                                      i,
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        // AdsWidget(title: "Hot Deals Promotions"),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        GridAdsWidget(),

                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
