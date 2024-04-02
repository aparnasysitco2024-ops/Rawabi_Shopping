// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';
import 'package:rawabi/widget/mainCategoryItem.dart';

import '../model/response/homeResponse.dart';

class CategoryWidget extends StatefulWidget {
  String? title;
  ItemGroup? itemGroup;

  CategoryWidget({super.key, this.title, this.itemGroup});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      color: Colors.white,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              ReusableText(
                title: widget.title,
                weight: FontWeight.bold,
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/CategoryFromHomeScreen',
                    arguments: {
                      'title': widget.title,
                      'category': widget.itemGroup!.grpCategory,
                    },
                  );
                },
                child: ReusableText(
                  title: "See All".tr,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.builder(
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: widget.itemGroup!.grpCategory!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 5,
                  mainAxisExtent: 130,
                  crossAxisCount: 4),
              itemBuilder: (_, index) {
                return MainCategoryItem(
                  category: widget.itemGroup!.grpCategory![index],
                );
              })
        ],
      ),
    );
  }
}
