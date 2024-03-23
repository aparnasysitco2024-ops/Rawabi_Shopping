// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/accountScreen.dart';
import 'package:rawabi/screen/cartScreen.dart';
import 'package:rawabi/screen/navigator/categoryNavigator.dart';
import 'package:rawabi/screen/navigator/homeNavigator.dart';
import 'package:rawabi/screen/offresScreen.dart';
import 'package:rawabi/utils/colors.dart';

import '../../controller/cartController.dart';
import '../../widget/commonwidget/reusable_text.dart';
import '../../widget/commonwidget/svg_icon.dart';

class BottomNavBar extends StatelessWidget {
//   const BottomNavBar({super.key});
//
//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
  var _currentIndex = 0.obs;
  final cartController = Get.put(CartController());
  final List _pages = [
    /*HomeScreen(),*/
    const HomeNavigator(),
    const CategoryNavigator(),
    OffersScreen(),
    CartScreen(),
    const AccountScreen()
  ];

  BottomNavBar({super.key});

  Future<bool> _showBackDialog() async {
    return (await showDialog(
          context: Get.context!,
          builder: (context) => AlertDialog(
            title: Text("Rawabi".tr),
            content: const Text('Wish to exit from App ? '),
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
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        final NavigatorState navigator = Navigator.of(context);
        final bool shouldPop = await _showBackDialog();
        if (shouldPop) {
          navigator.pop();
        }
      },
      child: Obx(() => Scaffold(
          body: _pages[_currentIndex.value],
          bottomNavigationBar: Container(
            height: Platform.isIOS ? 95 : 65,
            decoration: const BoxDecoration(
                boxShadow: [BoxShadow(color: grey, blurRadius: 1)]),
            child: BottomAppBar(
              color: white,
              surfaceTintColor: white,
              shape: const CircularNotchedRectangle(),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
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
                            _currentIndex.value = 0;
                            // });
                          },
                          child: SizedBox(
                            child: Column(
                              children: [
                                SvgIcon(
                                  image: "assets/icons/homeIcon.svg",
                                  height: 20,
                                  color: _currentIndex == 0
                                      ? primaryColor
                                      : Colors.black,
                                ),
                                ReusableText(
                                  title: "Home".tr,
                                  color: _currentIndex == 0
                                      ? primaryColor
                                      : Colors.black,
                                  size: 12,
                                )
                              ],
                            ),
                          )),
                      InkWell(
                          onTap: () {
                            // setState(() {
                            _currentIndex.value = 1;
                            // });
                          },
                          child: SizedBox(
                            child: Column(
                              children: [
                                SvgIcon(
                                  image: "assets/icons/explore.svg",
                                  height: 20,
                                  color: _currentIndex == 1
                                      ? primaryColor
                                      : Colors.black,
                                ),
                                ReusableText(
                                  title: "Explore".tr,
                                  color: _currentIndex == 1
                                      ? primaryColor
                                      : Colors.black,
                                  size: 12,
                                )
                              ],
                            ),
                          )),
                      InkWell(
                          onTap: () {
                            // setState(() {
                            _currentIndex.value = 2;
                            // });
                          },
                          child: SizedBox(
                            child: Column(
                              children: [
                                SvgIcon(
                                  image: "assets/icons/gift.svg",
                                  height: 20,
                                  color: _currentIndex == 2
                                      ? primaryColor
                                      : Colors.black,
                                ),
                                ReusableText(
                                  title: "Offers".tr,
                                  color: _currentIndex == 2
                                      ? primaryColor
                                      : Colors.black,
                                  size: 12,
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
                                _currentIndex.value = 3;
                                // });
                              },
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    SvgIcon(
                                      image: "assets/icons/cart.svg",
                                      height: 20,
                                      color: _currentIndex == 3
                                          ? primaryColor
                                          : Colors.black,
                                    ),
                                    ReusableText(
                                      title: "Cart".tr,
                                      color: _currentIndex == 3
                                          ? primaryColor
                                          : Colors.black,
                                      size: 12,
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
                                _currentIndex.value = 3;
                                // });
                              },
                              badgeContent: Obx(
                                    () => Text(
                                  cartController.totalItemCount.value
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: white,
                                  ),
                                ),
                              ),
                              badgeAnimation:
                              const badges.BadgeAnimation.scale(
                                animationDuration: Duration(seconds: 1),
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
                                borderRadius: BorderRadius.circular(10),
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
                            _currentIndex.value = 4;
                            // });
                          },
                          child: SizedBox(
                            child: Column(
                              children: [
                                SvgIcon(
                                  image: "assets/icons/account.svg",
                                  height: 20,
                                  color: _currentIndex == 4
                                      ? primaryColor
                                      : Colors.black,
                                ),
                                ReusableText(
                                  title: "Account".tr,
                                  color: _currentIndex == 4
                                      ? primaryColor
                                      : Colors.black,
                                  size: 12,
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ))),
    );
  }
}
