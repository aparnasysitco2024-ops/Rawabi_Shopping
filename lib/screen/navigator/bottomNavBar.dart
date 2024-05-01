// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/homeController.dart';
import 'package:rawabi/screen/navigator/categoryNavigator.dart';
import 'package:rawabi/utils/colors.dart';

import '../../controller/cartController.dart';
import '../../widget/commonwidget/reusable_text.dart';
import '../../widget/commonwidget/svg_icon.dart';
import 'accountNavigator.dart';
import 'cartNavigator.dart';
import 'homeNavigator.dart';
import 'offerNavigator.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  GlobalKey bottomNavigationKey = GlobalKey();

//   const BottomNavBar({super.key});
  final currentIndex = 0.obs;

  // var languageParam = LanguageParam().obs;
  // var languageParamString = "";

  final cartController = Get.put(CartController());
  final homeController = Get.put(HomeController());
  late List _pages;

  void initState() {
    super.initState();
    // getLanguageData();
    homeController.getStorageData();
    _pages = [
      /*HomeScreen(),*/
      const HomeNavigator(),
      const CategoryNavigator(),
      const OfferNavigator(),
      const CartNavigator(),
      AccountNavigator(
        globalKey: bottomNavigationKey,
        onOffersSelected: () => currentIndex.value = 2,
        onCartSelected: () => currentIndex.value = 3,
      )
    ];
  }

  // getLanguageData() async {
  //   languageParamString =
  //       await StorageManager.readData(StorageManager.keyLanguageParams);
  //   if (languageParamString.isNotEmpty)
  //     languageParam.value =
  //         LanguageParam.fromJson(json.decode(languageParamString));
  //   else
  //     readJsonLanguage();
  // }
  //
  // Future<void> readJsonLanguage() async {
  //   final String response = await rootBundle.loadString('assets/json/englishLanguage.json');
  //   languageParam.value =
  //       LanguageParam.fromJson(json.decode(response));
  //   StorageManager.saveData(StorageManager.keyLanguageParams,
  //       json.encode(languageParam.value));
  // }

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    homeNavigatorKey,
    exploreNavigatorKey,
    offerNavigatorKey,
    cartNavigatorKey,
    accountNavigatorKey
  ];

  _systemBackButtonPressed(bool didPop) {
    if (_navigatorKeys[currentIndex.value].currentState!.canPop()) {
      _navigatorKeys[currentIndex.value]
          .currentState
          ?.pop(_navigatorKeys[currentIndex.value].currentContext);
    } else {
      // SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      if (currentIndex.value != 0) {
        currentIndex.value = 0;
      } else {
        _showBackDialog();
      }
    }
  }

  Future<bool> _showBackDialog() async {
    return (await showDialog(
          context: Get.context!,
          builder: (context) => AlertDialog(
            title: Text("Rawabi Shopping".tr),
            content: Text('Wish to exit from App ? '.tr),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                //<-- SEE HERE
                child: Text('No'.tr),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(), // <-- SEE HERE
                child: Text('Yes'.tr),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: _systemBackButtonPressed,
      //     (bool didPop) async {
      //   if (didPop) {
      //     return;
      //   }
      //   // final NavigatorState navigator = Navigator.of(context);
      //   // final bool shouldPop = await _showBackDialog();
      //   // if (shouldPop) {
      //   //   navigator.pop();
      //   // }
      // },
      child: Obx(() => Scaffold(
          body: _pages[currentIndex.value],
          bottomNavigationBar: homeController.languageParam.value.home != null
              ? Container(
                  key: bottomNavigationKey,
                  height: Platform.isIOS ? 100 : 70,
                  decoration: const BoxDecoration(
                      boxShadow: [BoxShadow(color: grey, blurRadius: 1)]),
                  child: BottomAppBar(
                    color: white,
                    surfaceTintColor: white,
                    shape: const CircularNotchedRectangle(),
                    child: Container(
                      width: double.maxFinite,
                      padding:
                          const EdgeInsets.only(top: 5, left: 15, right: 15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: SizedBox(
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  // setState(() {
                                  currentIndex.value = 0;
                                  // });
                                },
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      SvgIcon(
                                        image: "assets/icons/homeIcon.svg",
                                        height: 20,
                                        color: currentIndex == 0
                                            ? primaryColor
                                            : Colors.black,
                                      ),
                                      Expanded(
                                        child: ReusableText(
                                          title: homeController
                                              .languageParam.value.home,
                                          color: currentIndex == 0
                                              ? primaryColor
                                              : Colors.black,
                                          size: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            InkWell(
                                onTap: () {
                                  // setState(() {
                                  currentIndex.value = 1;
                                  // });
                                },
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      SvgIcon(
                                        image: "assets/icons/explore.svg",
                                        height: 20,
                                        color: currentIndex == 1
                                            ? primaryColor
                                            : Colors.black,
                                      ),
                                      Expanded(
                                        child: ReusableText(
                                          title: homeController
                                              .languageParam.value.explore,
                                          color: currentIndex == 1
                                              ? primaryColor
                                              : Colors.black,
                                          size: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            InkWell(
                                onTap: () {
                                  // setState(() {
                                  currentIndex.value = 2;
                                  // });
                                },
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      SvgIcon(
                                        image: "assets/icons/gift.svg",
                                        height: 20,
                                        color: currentIndex == 2
                                            ? primaryColor
                                            : Colors.black,
                                      ),
                                      Expanded(
                                        child: ReusableText(
                                          title: homeController
                                              .languageParam.value.offers,
                                          color: currentIndex == 2
                                              ? primaryColor
                                              : Colors.black,
                                          size: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                InkWell(
                                    onTap: () {
                                      // setState(() {
                                      currentIndex.value = 3;
                                      // });
                                    },
                                    child: SizedBox(
                                      child: Column(
                                        children: [
                                          SvgIcon(
                                            image: "assets/icons/cart.svg",
                                            height: 20,
                                            color: currentIndex == 3
                                                ? primaryColor
                                                : Colors.black,
                                          ),
                                          Expanded(
                                            child: ReusableText(
                                              title: homeController
                                                  .languageParam.value.cart,
                                              color: currentIndex == 3
                                                  ? primaryColor
                                                  : Colors.black,
                                              size: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                cartController.totalItemCount == 0
                                    ? const SizedBox()
                                    : Positioned(
                                        top: -15,
                                        right: -15,
                                        child: badges.Badge(
                                          position: badges.BadgePosition.topEnd(
                                              top: -10, end: -12),
                                          showBadge: true,
                                          ignorePointer: false,
                                          onTap: () {
                                            // setState(() {
                                            currentIndex.value = 3;
                                            // });
                                          },
                                          badgeContent: Obx(
                                            () => Text(
                                              cartController
                                                  .totalItemCount.value
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: white,
                                              ),
                                            ),
                                          ),
                                          badgeAnimation:
                                              const badges.BadgeAnimation.scale(
                                            animationDuration:
                                                Duration(seconds: 1),
                                            colorChangeAnimationDuration:
                                                Duration(seconds: 1),
                                            loopAnimation: false,
                                            curve: Curves.fastOutSlowIn,
                                            colorChangeAnimationCurve:
                                                Curves.easeInCubic,
                                          ),
                                          badgeStyle: badges.BadgeStyle(
                                            shape: badges.BadgeShape.circle,
                                            badgeColor: primaryColor,
                                            padding: const EdgeInsets.all(8),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.white, width: 2),
                                            elevation: 0,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            InkWell(
                                onTap: () {
                                  // setState(() {
                                  currentIndex.value = 4;
                                  // });
                                },
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      SvgIcon(
                                        image: "assets/icons/account.svg",
                                        height: 20,
                                        color: currentIndex == 4
                                            ? primaryColor
                                            : Colors.black,
                                      ),
                                      Expanded(
                                        child: ReusableText(
                                          title: homeController
                                              .languageParam.value.account,
                                          color: currentIndex == 4
                                              ? primaryColor
                                              : Colors.black,
                                          size: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox())),
    );
  }
}
