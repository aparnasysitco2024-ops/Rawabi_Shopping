import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/model/categoryResponse.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusableNetworkImage.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../controller/categoryController.dart';

// ignore: must_be_immutable
class SubCategoryItemTile extends StatelessWidget {
  Category subCategory;

  SubCategoryItemTile({super.key, required this.subCategory});

  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0,),
      child: Row(
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
    );
  }
}
