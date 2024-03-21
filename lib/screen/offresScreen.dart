import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../controller/categoryController.dart';
import '../widget/categoryItemTile.dart';

// ignore: must_be_immutable
class OffersScreen extends StatelessWidget {
  OffersScreen({super.key});

  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    categoryController.getCategory();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ReusableText(
                    title: "Offers".tr, size: 18, weight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                height: 42,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: const BoxDecoration(
                    color: silver,
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                child: Row(children: [
                  SvgPicture.asset("assets/icons/search.svg"),
                  const SizedBox(
                    width: 15,
                  ),
                  ReusableText(
                    title: "What are you looking for?".tr,
                    color: darkGrey,
                    size: 14,
                    weight: FontWeight.w600,
                  ),
                  const Spacer(),
                  SvgPicture.asset("assets/icons/scan.svg")
                ]),
              ),
              Expanded(
                child: Container(
                  color: silver,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        //Category
                        ListView.builder(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, right: 10),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: categoryController.categoryList.length,
                            itemBuilder: (_, index) {
                              return CategoryItemTile(
                                  category:
                                      categoryController.categoryList[index]);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
