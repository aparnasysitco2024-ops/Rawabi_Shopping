import 'package:flutter/material.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

class OrderItemTile extends StatelessWidget {

  OrderItemTile({super.key, });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 4),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
      //alignment: Alignment.center,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 60,
              child: Image.asset("assets/images/ajmi.png")),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  title: "Ajmi Special Pathiri Podi 1kg",
                  size: 10,
                  weight: FontWeight.w600,
                  color: darkGrey,
                ),
                ReusableText(
                  title: "Arriving Today",
                  size: 10,
                  weight: FontWeight.w400,
                ),
              ],
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFFB0B0B0),
            size: 18,
          ),

        ],
      ),
    );
  }
}
