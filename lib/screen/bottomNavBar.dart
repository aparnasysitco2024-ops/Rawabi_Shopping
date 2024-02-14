import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/splashScreen.dart';
import 'package:rawabi/utils/colors.dart';

import '../widget/commomwidget/reusable_text.dart';
import '../widget/commomwidget/svg_icon.dart';
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
    const SplashScreen(),
    const SplashScreen(),
    const SplashScreen(),
    const SplashScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 10,
        shape: const CircularNotchedRectangle(),
        child: Container(
          // margin: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: const BoxDecoration(
            // image: DecorationImage(
            //     image: AssetImage('assets/images/pattern2.png'),
            //     fit: BoxFit.cover),
            color: Colors.white,
            // borderRadius: BorderRadius.circular(18),
            // gradient: bottomNavGradient,
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
                    height: 45,
                    child: Column(
                      children: [
                        SvgIcon(
                          image: "assets/icons/home.svg",
                          height: 25,
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
                    height: 45,
                    child: Column(
                      children: [
                        SvgIcon(
                          image: "assets/icons/explore.svg",
                          height: 25,
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
                    height: 45,
                    child: Column(
                      children: [
                        SvgIcon(
                          image: "assets/icons/gift.svg",
                          height: 25,
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
                    height: 45,
                    child: Column(
                      children: [
                        SvgIcon(
                          image: "assets/icons/cart.svg",
                          height: 25,
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
                    height: 45,
                    child: Column(
                      children: [
                        SvgIcon(
                          image: "assets/icons/account.svg",
                          height: 25,
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
