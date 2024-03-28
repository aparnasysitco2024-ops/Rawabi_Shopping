import 'package:flutter/material.dart';
import 'package:rawabi/screen/myOrder/orderDetailsScreen.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../model/myOrderResponse.dart';

// ignore: must_be_immutable
class OrderItemTile extends StatelessWidget {
  Orders myOrder;

  OrderItemTile({super.key, required this.myOrder});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppUtils.navigateToPage(OrderDetailsScreen(
          myOrder: myOrder,
        ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
        //alignment: Alignment.center,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(
            //     width: 60,
            //     child: Image.asset("assets/images/ajmi.png")),
            // const SizedBox(
            //   width: 5,
            // ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    title: "Order #${myOrder.refno}",
                    size: 10,
                    weight: FontWeight.w600,
                    color: darkGrey,
                  ),
                  ReusableText(
                    title: myOrder.status,
                    color: blue,
                    size: 10,
                    weight: FontWeight.w400,
                  ),
                  ReusableText(
                    title: myOrder.date,
                    color: darkGrey,
                    size: 10,
                    weight: FontWeight.w400,
                  ),
                  ReusableText(
                    title: "Amount: QAR ${myOrder.payable}",
                    color: darkGrey,
                    size: 10,
                    weight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFB0B0B0),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
