import 'package:flutter/material.dart';
import 'package:rawabi/model/categoryResponse.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusableNetworkImage.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

// ignore: must_be_immutable
class CategoryItemTile extends StatelessWidget {
  Category category;

  CategoryItemTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // AppUtils.navigateToPage(OrderDetailsScreen(
        //   myOrder: myOrder,
        // ));
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
           ReusableNetworkImage(image: category.catIcon.toString(),height: 60,),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    title: category.catName,
                    size: 10,
                    weight: FontWeight.w600,
                    color: darkGrey,
                  ),
                  ReusableText(
                    title: category.catName,
                    color: blue,
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
