import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/myOrder/trackOrderScreen.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/widget/orderDetailsTile.dart';
import 'package:rawabi/widget/searchOrderWidget.dart';
import '../../model/myOrderResponse.dart';
import '../../utils/colors.dart';
import '../../widget/commonwidget/reusable_text.dart';

// ignore: must_be_immutable
class OrderDetailsScreen extends StatelessWidget {
  Orders myOrder;

  OrderDetailsScreen({super.key, required this.myOrder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: silver,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: white,
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(bottom: 10),
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
                      const SearchOrdersWidget(hintText: "Search Orders",),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 8),
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 0),
                        color: white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Column(
                          children: [
                            ListView.separated(
                                padding: const EdgeInsets.all(0),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: myOrder.items!.length,
                                itemBuilder: (context, index) =>
                                    OrderDetailsTile(
                                        items: myOrder.items![index]),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(
                                          thickness: 1,
                                        )),
                            const Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const ReusableText(
                                    title: "Cancel Order",
                                    size: 12,
                                    weight: FontWeight.w600,
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      AppUtils.navigateToPage(
                                          const TrackOrderScreen());
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      width: 125,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 2),
                                      decoration: const BoxDecoration(
                                          color: pink,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100))),
                                      child: const ReusableText(
                                        title: "Track Your Order",
                                        color: primaryColor,
                                        size: 12,
                                        weight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
