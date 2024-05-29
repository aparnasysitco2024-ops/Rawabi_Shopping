import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/model/response/offerListResponse.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusableNetworkImage.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../controller/categoryController.dart';

// ignore: must_be_immutable
class OfferCategoryItemTile extends StatelessWidget {
  OfferCategory category;

  OfferCategoryItemTile({super.key, required this.category});

  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReusableNetworkImage(
            image: category.catIcon.toString(),
            height: 55,
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
                  title: category.catName,
                  size: 10,
                  weight: FontWeight.w600,
                  color: darkGrey,
                ),
                // ReusableText(
                //   title: category.catName,
                //   color: grey1,
                //   size: 10,
                //   weight: FontWeight.w400,
                // ),
              ],
            ),
          ),
          const Spacer(),
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
