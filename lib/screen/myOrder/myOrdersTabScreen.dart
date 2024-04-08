import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/myOrder/myOrderScreen.dart';
import 'package:rawabi/widget/searchOrderWidget.dart';

import '../../utils/colors.dart';
import '../../widget/commonwidget/reusable_text.dart';

class MyOrdersTabScreen extends StatefulWidget {
  const MyOrdersTabScreen({super.key});

  @override
  State<MyOrdersTabScreen> createState() => _MyOrdersTabScreenState();
}

class _MyOrdersTabScreenState extends State<MyOrdersTabScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 4, vsync: this);
    return Scaffold(
        backgroundColor: silver,
        body: SingleChildScrollView(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                color: white,
                width: double.maxFinite,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: double.maxFinite,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Stack(
                        children: [
                          Center(
                            child: ReusableText(
                              title: "My Orders".tr,
                              size: 18,
                              weight: FontWeight.bold,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 0,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: blackLight,
                                size: 24,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                     SearchOrdersWidget(hintText: "Search Orders".tr,),
                    const Divider(
                      thickness: 1,
                      color: lightGreyColor,
                    ),
                    SizedBox(
                      height: 33,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: primaryColor,
                          unselectedLabelColor: blackLight,
                          labelColor: primaryColor,
                          controller: _tabController,
                          tabs: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: ReusableText(
                                title: "Orders".tr,
                                size: 14,
                                weight: FontWeight.w600,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: ReusableText(
                                title: "Delivered".tr,
                                size: 14,
                                weight: FontWeight.w600,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: ReusableText(
                                title: "Cancelled".tr,
                                size: 14,
                                weight: FontWeight.w600,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: ReusableText(
                                title: "Return".tr,
                                size: 14,
                                weight: FontWeight.w600,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      MyOrderScreen(),
                      MyOrderScreen(),
                      MyOrderScreen(),
                      MyOrderScreen(),
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
