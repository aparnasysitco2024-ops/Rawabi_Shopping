import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusableNetworkImage.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../model/response/myorder/items.dart';

// ignore: must_be_immutable
class OrderDetailsTile extends StatelessWidget {
  Items items;

  OrderDetailsTile({super.key, required this.items});

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
          Checkbox(
            checkColor: white,
            activeColor: primaryColor,
            value: false,
            onChanged: (bool? value) {},
          ),
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
                // ReusableText(
                //   title: "Order #23243",
                //   size: 10,
                //   weight: FontWeight.w600,
                //   color: darkGrey,
                // ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: blue,
                      radius: 3,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    ReusableText(
                      title: "Out for delivery".tr,
                      color: blue,
                      size: 10,
                      weight: FontWeight.w400,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ReusableText(
                      title: "Arriving in ".tr +
                          items.deliveryDays.toString() +
                          " days".tr,
                      size: 10,
                      weight: FontWeight.w400,
                    ),
                  ],
                ),
                ReusableText(
                  title: "QAR ${items.itemPrice}",
                  size: 10,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
