import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/homeDeliveryMapScreen.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/storeTile.dart';

import '../widget/commonwidget/reusable_text.dart';

class DeliveryModeScreen extends StatefulWidget {
  const DeliveryModeScreen({super.key});

  @override
  State<DeliveryModeScreen> createState() => _DeliveryModeScreenState();
}

class _DeliveryModeScreenState extends State<DeliveryModeScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: silver,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: white,
              padding: const EdgeInsets.all(0),
              width: double.maxFinite,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 40,
                    width: double.maxFinite,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Stack(
                      children: [
                        Center(
                          child: ReusableText(
                            title: "Delivery Mode".tr,
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
                            child: Row(

                              children: [
                                Image.asset('assets/icons/fastdelivery.png', width: 18, height: 18),
                                const SizedBox(width: 8),
                                Text(
                                   "Home Delivery".tr,
                                  style: const TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              children: [
                                Image.asset('assets/icons/store.png', width: 18, height: 18),
                                const SizedBox(width: 8),
                                Text(
                                  "Store Pickup".tr,
                                  style: const TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
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
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                     const HomeDeliveryMapScreen(),
                    ListView.separated(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: 8,
                        itemBuilder: (context, index) => const StoreTile(
                            title: "Rawabi Al khor, T tower Building"),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                              height: 5,
                            )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
