import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonWidget/reusable_text.dart';

// ignore: must_be_immutable
class SortOptionsWidget extends StatefulWidget {
  final Function(String val)? onPressed;

  SortOptionsWidget({super.key, required this.onPressed});

  var sortList = [
    {"name": "Featured", "value": "1"},
    {"name": "Relevance", "value": "2"},
    {"name": "Newest", "value": "3"},
    {"name": "Discount", "value": "4"},
    {"name": "Price high to low", "value": "5"},
    {"name": "Price low to high", "value": "6"},
  ];

  @override
  State<SortOptionsWidget> createState() => _SortOptionsWidgetState();
}

class _SortOptionsWidgetState extends State<SortOptionsWidget> {
  bool isSelectedRelevance = false;

  bool isSelectedLowestPrice = false;

  bool isSelectedHighestPrice = false;

  bool isSelectedNewest = false;

  bool isSelectedDiscount = true;

  String groupValue = "";
  int selectedPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReusableText(
            title: "Sort by".tr,
            size: 14,
            weight: FontWeight.w600,
          ),
          Divider(
            thickness: 0.5,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      widget.onPressed!(widget.sortList[index].values.last);
                      selectedPosition = index;
                      // isSelectedRelevance = true;
                      // isSelectedLowestPrice = false;
                      // isSelectedHighestPrice = false;
                      // isSelectedNewest = false;
                      // isSelectedDiscount = false;
                    });
                  },
                  child: SizedBox(
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                          title: widget.sortList[index].values.first,
                          size: 12,
                          weight: FontWeight.w600,
                        ),
                        Visibility(
                          visible: selectedPosition == index,
                          child: Icon(
                            Icons.radio_button_checked,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              itemCount: widget.sortList.length,
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     setState(() {
          //       widget.onPressed!("1");
          //       isSelectedRelevance = true;
          //       isSelectedLowestPrice = false;
          //       isSelectedHighestPrice = false;
          //       isSelectedNewest = false;
          //       isSelectedDiscount = false;
          //     });
          //   },
          //   child: SizedBox(
          //     height: 45,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         ReusableText(
          //           title: "Featured".tr,
          //           size: 12,
          //           weight: FontWeight.w600,
          //         ),
          //         Visibility(
          //           visible: isSelectedRelevance,
          //           child: Icon(
          //             Icons.radio_button_checked,
          //             color: primaryColor,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // Divider(
          //   thickness: 0.5,
          // ),
          // InkWell(
          //   onTap: () {
          //     setState(() {
          //       widget.onPressed!("2");
          //       isSelectedRelevance = false;
          //       isSelectedLowestPrice = true;
          //       isSelectedHighestPrice = false;
          //       isSelectedNewest = false;
          //       isSelectedDiscount = false;
          //     });
          //   },
          //   child: SizedBox(
          //     height: 40,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         ReusableText(
          //           title: "Relevance".tr,
          //           size: 12,
          //           weight: FontWeight.w600,
          //         ),
          //         Visibility(
          //           visible: isSelectedLowestPrice,
          //           child: Icon(
          //             Icons.radio_button_checked,
          //             color: primaryColor,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // Divider(
          //   thickness: 0.5,
          // ),
          // InkWell(
          //   onTap: () {
          //     setState(() {
          //       widget.onPressed!("3");
          //       isSelectedRelevance = false;
          //       isSelectedLowestPrice = false;
          //       isSelectedHighestPrice = true;
          //       isSelectedNewest = false;
          //       isSelectedDiscount = false;
          //     });
          //   },
          //   child: SizedBox(
          //     height: 40,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         ReusableText(
          //           title: "Newest".tr,
          //           size: 12,
          //           weight: FontWeight.w600,
          //         ),
          //         Visibility(
          //           visible: isSelectedHighestPrice,
          //           child: Icon(
          //             Icons.radio_button_checked,
          //             color: primaryColor,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // Divider(
          //   thickness: 0.5,
          // ),
          // InkWell(
          //   onTap: () {
          //     setState(() {
          //       widget.onPressed!("4");
          //       isSelectedRelevance = false;
          //       isSelectedLowestPrice = false;
          //       isSelectedHighestPrice = false;
          //       isSelectedNewest = true;
          //       isSelectedDiscount = false;
          //     });
          //   },
          //   child: SizedBox(
          //     height: 40,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         ReusableText(
          //           title: "Discount".tr,
          //           size: 12,
          //           weight: FontWeight.w600,
          //         ),
          //         Visibility(
          //           visible: isSelectedNewest,
          //           child: Icon(
          //             Icons.radio_button_checked,
          //             color: primaryColor,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
