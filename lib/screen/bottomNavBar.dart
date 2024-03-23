import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/accountScreen.dart';
import 'package:rawabi/screen/cartScreen.dart';
import 'package:rawabi/screen/categoryScreen.dart';
import 'package:rawabi/screen/homeNavigator.dart';
import 'package:rawabi/screen/offresScreen.dart';
import 'package:rawabi/utils/colors.dart';
import '../controller/cartController.dart';
import '../widget/commonwidget/reusable_text.dart';
import '../widget/commonwidget/svg_icon.dart';
import 'package:badges/badges.dart' as badges;

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final cartController = Get.put(CartController());
  final List _pages = [
    /*HomeScreen(),*/
    const HomeNavigator(),
    CategoryScreen(),
    OffersScreen(),
    CartScreen(),
    const AccountScreen()
  ];

  Future<bool> _showBackDialog() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:  Text("Rawabi".tr),
        content:  const Text('Wish to exit from App ? '),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
            child:  Text('No'.tr),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(), // <-- SEE HERE
            child:  Text('Yes'.tr),
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
        final bool? shouldPop = await _showBackDialog();
        if (shouldPop ?? false) {
          navigator.pop();
        }
      },
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomAppBar(
          height: 120,
          color: white,
          surfaceTintColor: white,
          elevation: 15,
          shape: const CircularNotchedRectangle(),
          child: Container(
            width: double.maxFinite,
            // margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10,top: 10),
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SizedBox(
              height: 90,
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                    child: SizedBox(
                      height: 40,
                      child: Column(
                        children: [
                          SvgIcon(
                            image: "assets/icons/blue_home.svg",
                            height: 20,
                            color:
                                _currentIndex == 0 ? primaryColor : Colors.black,
                          ),
                          ReusableText(
                            title: "Home".tr,
                            color:
                                _currentIndex == 0 ? primaryColor : Colors.black,
                            size: 12,
                          )
                        ],
                      ),
                    )),
                InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    child: SizedBox(
                      height: 40,
                      child: Column(
                        children: [
                          SvgIcon(
                            image: "assets/icons/explore.svg",
                            height: 20,
                            color:
                                _currentIndex == 1 ? primaryColor : Colors.black,
                          ),
                          ReusableText(
                            title: "Explore".tr,
                            color:
                                _currentIndex == 1 ? primaryColor : Colors.black,
                            size: 12,
                          )
                        ],
                      ),
                    )),
                InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                    child: SizedBox(
                      height: 40,
                      child: Column(
                        children: [
                          SvgIcon(
                            image: "assets/icons/gift.svg",
                            height: 20,
                            color:
                                _currentIndex == 2 ? primaryColor : Colors.black,
                          ),
                          ReusableText(
                            title: "Offers".tr,
                            color:
                                _currentIndex == 2 ? primaryColor : Colors.black,
                            size: 12,
                          )
                        ],
                      ),
                    )),
                badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -10, end: -12),
                  showBadge: true,
                  ignorePointer: false,
                  onTap: () {
                    setState(() {
                    _currentIndex = 3;
                  });
                    },
                  badgeContent:
                  Obx(()=>Text(cartController.itemCount.value.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: white,
                    ),),),
                  badgeAnimation: const badges.BadgeAnimation.scale(
                    animationDuration: Duration(seconds: 1),
                    colorChangeAnimationDuration: Duration(seconds: 1),
                    loopAnimation: false,
                    curve: Curves.fastOutSlowIn,
                    colorChangeAnimationCurve: Curves.easeInCubic,
                  ),
                  badgeStyle: badges.BadgeStyle(
                    shape: badges.BadgeShape.circle,
                    badgeColor: primaryColor,
                    padding: const EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    elevation: 0,
                  ),

                  child: InkWell(
                      onTap: () {
                        setState(() {
                          _currentIndex = 3;
                        });
                      },
                      child: SizedBox(
                        height: 40,
                        child: Column(
                          children: [
                            SvgIcon(
                              image: "assets/icons/cart.svg",
                              height: 20,
                              color:
                              _currentIndex == 3 ? primaryColor : Colors.black,
                            ),
                            ReusableText(
                              title: "Cart".tr,
                              color:
                              _currentIndex == 3 ? primaryColor : Colors.black,
                              size: 12,
                            )
                          ],
                        ),
                      )),
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 4;
                      });
                    },
                    child: SizedBox(
                      height: 40,
                      child: Column(
                        children: [
                          SvgIcon(
                            image: "assets/icons/account.svg",
                            height: 20,
                            color:
                                _currentIndex == 4 ? primaryColor : Colors.black,
                          ),
                          ReusableText(
                            title: "Account".tr,
                            color:
                                _currentIndex == 4 ? primaryColor : Colors.black,
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
      ),
    );
  }
}
