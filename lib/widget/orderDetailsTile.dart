import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonWidget/reusable_button1.dart';
import 'package:rawabi/widget/commonwidget/reusableNetworkImage.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../controller/myOrderDetailsController.dart';
import '../model/response/myorder/items.dart';
import '../model/response/myorder/myOrderResponse.dart';

// ignore: must_be_immutable
class OrderDetailsTile extends StatelessWidget {
  Items items;
  Orders myOrder;
  final myOrderDetailController = Get.put(MyOrderDetailController());

  OrderDetailsTile({super.key, required this.items, required this.myOrder});

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Checkbox(
          //   checkColor: white,
          //   activeColor: primaryColor,
          //   value: false,
          //   onChanged: (bool? value) {},
          // ),
          SizedBox(
              width: 60,
              child: ReusableNetworkImage(
                image: items.itemImage.toString(),
                height: 60.0,
              )),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  title: items.itemName,
                  size: 10,
                  weight: FontWeight.w600,
                  color: darkGrey,
                ),
                items.delete == "yes"
                    ? ReusableText(
                        title: "(Item Deleted)",
                        size: 10,
                        weight: FontWeight.w600,
                        color: darkGrey,
                      )
                    : items.alter == "yes"
                        ? ReusableText(
                            title: "(Item Replaced)",
                            size: 10,
                            weight: FontWeight.w600,
                            color: darkGrey,
                          )
                        : SizedBox(),

                // ReusableText(
                //   title: "Order #23243",
                //   size: 10,
                //   weight: FontWeight.w600,
                //   color: darkGrey,
                // ),
                Row(
                  children: [
                    // CircleAvatar(
                    //   backgroundColor: blue,
                    //   radius: 3,
                    // ),
                    // SizedBox(
                    //   width: 2,
                    // ),
                    // ReusableText(
                    //   title: "Out for delivery".tr,
                    //   color: blue,
                    //   size: 10,
                    //   weight: FontWeight.w400,
                    // ),
                    // SizedBox(
                    //   width: 10,
                    // ),

                    myOrder.status == "Processing" &&
                            myOrder.order_type == "delivery"
                        ? ReusableText(
                            title: "Arriving in ".tr +
                                items.deliveryDays.toString() +
                                " days".tr,
                            size: 10,
                            weight: FontWeight.w400,
                          )
                        : SizedBox(),
                  ],
                ),
                ReusableText(
                  title: items.itemQty! + "x QAR ${items.itemPrice}",
                  size: 10,
                  weight: FontWeight.w600,
                ),
                myOrder.status == "Delivered" && items.returnEligible == 1
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 5,
                            width: double.infinity,
                          ),
                          Container(
                            width: 70,
                            height: 25,
                            margin: EdgeInsets.only(right: 10, left: 10),
                            child: ReusableButton1(
                              onPressed: () =>
                                  myOrderDetailController.returnItem(
                                      items.itemId.toString(),
                                      items.detailId.toString()),
                              title: "Return".tr,
                              fontSize: 10,
                            ),
                          )
                        ],
                      )
                    : SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
