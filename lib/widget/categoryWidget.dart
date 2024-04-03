// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../model/response/homeResponse.dart';
import 'categoryGroupItem.dart';

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
    List pages = ['Home', 'About', 'Careers', 'Contact Us', 'Blog', 'Disclaimer'];
    return Container(
      margin: const EdgeInsets.all(0),
      color: Colors.white,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          Container(
            height: 135,
            child: ListView.builder(
                padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.itemGroup!.grpCategory!.length,
                itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CategoryGroupItem(
                              category: widget.itemGroup!.grpCategory![index],
                            ),
                          );
                }),
          ),
          // Expanded(
          //   child: ListView.builder(
          //       padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
          //       scrollDirection: Axis.horizontal,
          //       shrinkWrap: true,
          //       itemCount: widget.itemGroup!.grpCategory!.length,
          //       itemBuilder: (_, index) {
          //         return CategoryGroupItem(
          //           category: widget.itemGroup!.grpCategory![index],
          //         );
          //       }),
          // )
        ],
      ),
    );
  }
}
