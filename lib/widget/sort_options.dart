import 'package:flutter/material.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonWidget/reusable_text.dart';

class SortOptionsWidget extends StatefulWidget {
  SortOptionsWidget({super.key});

  @override
  State<SortOptionsWidget> createState() => _SortOptionsWidgetState();
}

class _SortOptionsWidgetState extends State<SortOptionsWidget> {
  bool isSelectedRelevance = false;

  bool isSelectedLowestPrice = false;

  bool isSelectedHighestPrice = false;

  bool isSelectedNewest = false;

  bool isSelectedDiscount = true;

  String groupValue = "Discount";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.maxFinite,
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReusableText(
            title: "Sort by",
            size: 14,
            weight: FontWeight.w600,
          ),
          Divider(
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              setState(() {
                isSelectedRelevance = true;
                isSelectedLowestPrice = false;
                isSelectedHighestPrice = false;
                isSelectedNewest = false;
                isSelectedDiscount = false;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableText(
                  title: "Relevance",
                  size: 12,
                  weight: FontWeight.w600,
                ),
                Visibility(
                  visible: isSelectedRelevance,
                  child: Icon(
                    Icons.radio_button_checked,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              setState(() {
                isSelectedRelevance = false;
                isSelectedLowestPrice = true;
                isSelectedHighestPrice = false;
                isSelectedNewest = false;
                isSelectedDiscount = false;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableText(
                  title: "Price(lowest first)",
                  size: 12,
                  weight: FontWeight.w600,
                ),
                Visibility(
                  visible: isSelectedLowestPrice,
                  child: Icon(
                    Icons.radio_button_checked,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              setState(() {
                isSelectedRelevance = false;
                isSelectedLowestPrice = false;
                isSelectedHighestPrice = true;
                isSelectedNewest = false;
                isSelectedDiscount = false;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableText(
                  title: "Price(highest first)",
                  size: 12,
                  weight: FontWeight.w600,
                ),
                Visibility(
                  visible: isSelectedHighestPrice,
                  child: Icon(
                    Icons.radio_button_checked,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              setState(() {
                isSelectedRelevance = false;
                isSelectedLowestPrice = false;
                isSelectedHighestPrice = false;
                isSelectedNewest = true;
                isSelectedDiscount = false;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableText(
                  title: "Newest",
                  size: 12,
                  weight: FontWeight.w600,
                ),
                Visibility(
                  visible: isSelectedNewest,
                  child: Icon(
                    Icons.radio_button_checked,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              setState(() {
                isSelectedRelevance = false;
                isSelectedLowestPrice = false;
                isSelectedHighestPrice = false;
                isSelectedNewest = false;
                isSelectedDiscount = true;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableText(
                  title: "Discount",
                  size: 12,
                  weight: FontWeight.w600,
                ),
                Visibility(
                  visible: isSelectedDiscount,
                  child: Icon(
                    Icons.radio_button_checked,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
