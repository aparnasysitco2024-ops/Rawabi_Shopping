import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/account_screen.dart';
import 'package:rawabi/screen/cartScreen.dart';
import 'package:rawabi/utils/colors.dart';

import '../widget/commonwidget/reusable_text.dart';
import '../widget/commonwidget/svg_icon.dart';
import 'homeScreen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List _pages = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    CartScreen(),
    const AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: white,
        surfaceTintColor: white,
        elevation: 15,
        shape: const CircularNotchedRectangle(),
        child: Container(
          // margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10,top: 10),
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
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
      ),
    );
  }
}
