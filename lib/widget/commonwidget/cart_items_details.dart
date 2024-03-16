import 'package:flutter/material.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

class CartItemDetails extends StatelessWidget {
  final String imageName;

  CartItemDetails({super.key, required this.imageName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 1),
      //alignment: Alignment.center,
      decoration:  BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: white,
            child: ClipOval(
              child:Image.asset(
                imageName,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                title: "Ajmi Special Pathiripodi 1 Kg",
                size: 10,
                weight: FontWeight.w600,
              ),
              ReusableText(
                title: "QAR 10.50َ",
                size: 12,
                weight: FontWeight.bold,
              ),

            ],
          ),

          Spacer(),
          CircleAvatar(
            backgroundColor: pink,
            radius: 15,
            child: ClipOval(
              child:Icon(Icons.remove_outlined)
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          ReusableText(
            title: "2",
            size: 12,
            weight: FontWeight.bold,
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
            backgroundColor: primaryColor,
            radius: 15,
            child: ClipOval(
              child:Icon(Icons.add)
            ),
          ),
        ],
      ),
    );
  }
}
