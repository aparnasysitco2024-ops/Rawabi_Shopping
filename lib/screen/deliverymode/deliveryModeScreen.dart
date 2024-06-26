import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/model/response/guestLoginResponse.dart';
import 'package:rawabi/screen/deliverymode/homeDeliveryMapScreen.dart';
import 'package:rawabi/screen/deliverymode/storePickupScreen.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/utils/storage_manager.dart';

import '../../controller/storePickupController.dart';
import '../../utils/constants.dart';
import '../../utils/http_client/base_client.dart';
import '../../widget/commonwidget/reusable_text.dart';

class DeliveryModeScreen extends StatefulWidget {
  DeliveryModeScreen({super.key});

  final storePickupController = Get.put(StorePickupController());

  @override
  State<DeliveryModeScreen> createState() => _DeliveryModeScreenState();
}

class _DeliveryModeScreenState extends State<DeliveryModeScreen>
    with TickerProviderStateMixin {
  Future<void> getGuestData() async {
    if (await StorageManager.getGuestID() == "0") {
      try {
        var response = await BaseClient().get(guestUrl);
        if (response != null) {
          var responseData =
              GuestLoginResponse.fromJson(json.decode(response.toString()));

          if (responseData.code == "200") {
            StorageManager.saveData(
                StorageManager.keyGuestID, responseData.guestId);
          } else {}
        } else {}
      } catch (error) {
        error.printError();
        // CommonUtils.showErrorDialog(error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    getGuestData();
    return PopScope(
      onPopInvoked: (didPop) {
        Get.delete<StorePickupController>();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: silver,
        body: Obx(() => widget.storePickupController.languageParam.value.home !=
                null
            ? SizedBox(
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
                                    title: widget.storePickupController
                                        .languageParam.value.deliveryMode,
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
                                        Image.asset(
                                            'assets/icons/fastdelivery.png',
                                            width: 18,
                                            height: 18),
                                        const SizedBox(width: 8),
                                        Text(
                                          widget.storePickupController
                                              .languageParam.value.homeDelivery
                                              .toString(),
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
                                        Image.asset('assets/icons/store.png',
                                            width: 18, height: 18),
                                        const SizedBox(width: 8),
                                        Text(
                                          widget.storePickupController
                                              .languageParam.value.storePickup
                                              .toString(),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: [
                            HomeDeliveryMapScreen(),
                            StorePickupScreen()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox()),
      ),
    );
  }
}
