import 'package:flutter/material.dart';
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
    HomeNavigator(),
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
        content:  Text('Wish to exit from App ? '),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
            child:  Text('No'.tr),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // <-- SEE HERE
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
            child: Stack(
              children: [
                SizedBox(
                  height: 90,
                  child: Row(
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
                    InkWell(
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
                Positioned(

                  right: 75,
                  bottom: 60,
                  child: CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: 10,
                    child: Obx(()=>Text(cartController.itemCount.value.toString(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: white,
                      ),),
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
