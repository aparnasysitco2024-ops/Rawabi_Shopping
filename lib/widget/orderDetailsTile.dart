import 'package:flutter/material.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

class OrderDetailsTile extends StatelessWidget {

  OrderDetailsTile({super.key, });

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
            value: true,
            onChanged: (bool? value) {
            },
          ),
          SizedBox(
              width: 60,
              child: Image.asset("assets/images/ajmi.png")),
          const SizedBox(
            width: 5,
          ),
          const Expanded(
            flex: 3,
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
                  title: "Order #23243",
                  size: 10,
                  weight: FontWeight.w600,
                  color: darkGrey,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: blue,
                      radius: 3,
                    ),
                    SizedBox(width: 2,),
                    ReusableText(
                      title: "Out for delivery",
                      color: blue,
                      size: 10,
                      weight: FontWeight.w400,
                    ),
                    SizedBox(width: 10,),
                    ReusableText(
                      title: "Arriving today 5 PM",
                      size: 10,
                      weight: FontWeight.w400,
                    ),
                  ],
                ),
                ReusableText(
                  title: "QAR 10.50",
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
