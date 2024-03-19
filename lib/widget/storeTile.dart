import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

class StoreTile extends StatelessWidget {
  final String title;
  const StoreTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 14,vertical: 2),
      padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 5) ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReusableText(title: title.tr, size: 12, weight: FontWeight.w600),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFB0B0B0),
              size: 18,
            ),
          )
        ],
      ),
    );
  }
}
