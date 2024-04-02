import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/model/response/categoryResponse.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusableNetworkImage.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../controller/categoryController.dart';

// ignore: must_be_immutable
class SubCategoryItemTile1 extends StatelessWidget {
  Category subCategory;

  SubCategoryItemTile1({super.key, required this.subCategory});

  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        onExpansionChanged: (value) {
          if (value) {
            // categoryController.getSubCategory(category.catId.toString());
          }
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReusableNetworkImage(
              image: subCategory.catIcon.toString(),
              height: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    title: subCategory.catName,
                    size: 10,
                    weight: FontWeight.w600,
                    color: darkGrey,
                  ),
                ],
              ),
            ),
            // const Icon(
            //   Icons.keyboard_arrow_down_sharp,
            //   color: Color(0xFFB0B0B0),
            //   size: 18,
            // ),
          ],
        ),
      ),
    );
  }
}
