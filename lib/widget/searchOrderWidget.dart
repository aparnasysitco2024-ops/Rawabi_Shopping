import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import 'commonwidget/reusable_text.dart';

class SearchOrdersWidget extends StatelessWidget {
  final TextEditingController ? controller;
  const SearchOrdersWidget({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: [
        Container(
        width: 240,
        height: 42,
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
            color: silver,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        padding: const EdgeInsets.only(right: 10),
        child:  TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: lightGreyColor,
            hintText: "Search Orders".tr,
            contentPadding: const EdgeInsets.only(left: 10),
            prefixIcon: const Icon(Icons.search,color: blackLight,),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
          const Spacer(),
          Container(
              width: 130,
              height: 42,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: silver,

                  borderRadius:
                  BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ReusableText(
                      title: "Last 3 months".tr,
                      size: 12,
                      weight: FontWeight.w400,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: grey,
                    size: 20,
                  ),
                ],
              )),
        ],
      ),
    );




  }
}
