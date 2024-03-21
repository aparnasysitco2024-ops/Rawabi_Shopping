import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/model/categoryResponse.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusableNetworkImage.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';
import 'package:rawabi/widget/subCategoryItemTile.dart';

import '../controller/categoryController.dart';

// ignore: must_be_immutable
class CategoryItemTile1 extends StatelessWidget {
  Category category;

  CategoryItemTile1({super.key, required this.category});

  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        categoryController.getSubCategory(category.catId.toString(),0);
      },
      child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
          //alignment: Alignment.center,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(4),
          ),
          child:
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              onExpansionChanged: (value) {
                if (value) {
                  // categoryController.subCategoryList.clear();
                  categoryController.getSubCategory(category.catId.toString(),1);
                }
              },
              title: Row(
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
                        ReusableText(
                          title: category.catName,
                          color: grey1,
                          size: 10,
                          weight: FontWeight.w400,
                        ),
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
              children: [
                categoryController.subCategoryList.isNotEmpty
                    ? ListView.builder(
                        padding:
                            const EdgeInsets.only(left: 10, top: 10, right: 10),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: categoryController.subCategoryList.length,
                        itemBuilder: (_, index) {
                          return SubCategoryItemTile(
                              subCategory:
                                  categoryController.subCategoryList[index]);
                        })
                    : const SizedBox(
                        height: 120,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      ),
              ],
            ),
          )),
    );
  }
}
