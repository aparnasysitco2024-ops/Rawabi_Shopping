import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/trackOrderScreen.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/widget/orderDetailsTile.dart';
import 'package:rawabi/widget/searchOrderWidget.dart';
import '../utils/colors.dart';
import '../widget/commonwidget/reusable_text.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

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
                                // physics: const NeverScrollableScrollPhysics(),
                                itemCount: 2,
                                itemBuilder: (context, index) =>
                                    OrderDetailsTile(),
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
                                    onTap: (){
                                      AppUtils.navigateToPage(const TrackOrderScreen());
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      width: 125,
                                      padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                      decoration: const BoxDecoration(
                                          color: pink,

                                          borderRadius:
                                          BorderRadius.all(Radius.circular(100))),
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
