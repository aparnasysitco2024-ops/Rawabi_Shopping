import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/commonwidget/reusable_button1.dart';
import 'package:rawabi/widget/headerWidget.dart';

import '../../controller/languageController.dart';
import '../../controller/storePickupController.dart';
import '../../utils/colors.dart';
import '../../widget/commonWidget/reusable_text.dart';

class OurStoreScreen extends StatelessWidget {
  OurStoreScreen({super.key});

  final storePickupController = Get.put(StorePickupController());

  @override
  Widget build(BuildContext context) {
    storePickupController.getStore();
    return Obx(() => PopScope(
          onPopInvoked: (didPop) {
            Get.delete<LanguageController>();
          },
          child: Scaffold(
              backgroundColor: silver,
              body: Column(
                children: [
                  HeaderWidget(
                    title: "Our Store",
                    onBack: () => Get.back(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  storePickupController.loading.value
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height - 280,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.separated(
                              padding: const EdgeInsets.all(0),
                              shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: storePickupController.storeList.length,
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 2),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ReusableText(
                                              title: storePickupController
                                                  .storeList[index].storeName
                                                  .toString(),
                                              size: 12,
                                              weight: FontWeight.w600),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ReusableText(
                                              title: "Address",
                                              size: 10,
                                              color: Colors.grey,
                                              weight: FontWeight.w400),
                                          ReusableText(
                                              title: storePickupController
                                                  .storeList[index].address
                                                  .toString(),
                                              size: 10,
                                              weight: FontWeight.w400),
                                          ReusableText(
                                              title: storePickupController
                                                  .storeList[index].phone
                                                  .toString(),
                                              size: 10,
                                              weight: FontWeight.w400),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ReusableButton1(
                                            onPressed: () {
                                              storePickupController
                                                  .launchGoogleMaps(
                                                      double.parse(
                                                          storePickupController
                                                              .storeList[index]
                                                              .latitude
                                                              .toString()),
                                                      double.parse(
                                                          storePickupController
                                                              .storeList[index]
                                                              .longitude
                                                              .toString()));
                                            },
                                            fontSize: 12.0,
                                            size: Size(double.infinity, 40),
                                            title: "Direction",
                                            backgroundColor: primaryColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                        height: 5,
                                      )),
                        ),
                  SizedBox(
                    height: 30,
                  )
                ],
              )),
        ));
  }
}
