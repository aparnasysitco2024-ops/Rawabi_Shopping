import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/orderItemTile.dart';
import 'package:rawabi/widget/searchOrderWidget.dart';
import '../utils/colors.dart';
import '../widget/commonwidget/reusable_text.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
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
                    const Divider(
                      thickness: 1,
                      color: lightGreyColor,
                    ),
                    SizedBox(
                      height: 45,
                      child: ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(vertical: -3),
                        leading: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: blackLight,
                            size: 24,
                          ),
                        ),
                        title: ReusableText(
                          title: "My Orders".tr,
                          size: 18,
                          weight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SearchOrdersWidget(),

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
                            ReusableText(
                              title: "Orders".tr,
                              size: 14,
                              weight: FontWeight.w600,
                              textAlign: TextAlign.center,
                            ),
                            ReusableText(
                              title: "Delivered".tr,
                              size: 14,
                              weight: FontWeight.w600,
                              textAlign: TextAlign.center,
                            ),
                            ReusableText(
                              title: "Cancelled".tr,
                              size: 14,
                              weight: FontWeight.w600,
                              textAlign: TextAlign.center,
                            ),
                            ReusableText(
                              title: "Return".tr,
                              size: 14,
                              weight: FontWeight.w600,
                              textAlign: TextAlign.center,
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
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.separated(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, index) =>  OrderItemTile(),
                        separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 5,)
                      ),
                      ListView.separated(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: 8,
                        itemBuilder: (context, index) =>  OrderItemTile(),
                        separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 5,)
                      ),
                      ListView.separated(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) =>  OrderItemTile(),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 5,)
                      ),
                      ListView.separated(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: 2,
                        itemBuilder: (context, index) =>  OrderItemTile(),
                        separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 5,)
                      ),
                    ],
                  ),
                ),
              )
                        ],
                      ),
            )));
  }
}
