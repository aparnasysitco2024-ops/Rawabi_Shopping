import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import 'commonwidget/reusable_text.dart';

class SearchOrdersWidget extends StatelessWidget {
  final TextEditingController ? controller;

  final String? hintText;
  const SearchOrdersWidget({super.key, this.controller,this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: [
        Expanded(
          flex: 5,
          child: Container(
          width: 220,
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
              fillColor: silver,
              hintText: hintText,
              contentPadding: const EdgeInsets.only(left: 10),
              prefixIcon: const Icon(Icons.search,color: blackLight,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
            ),
          ),
                ),
        ),
          const SizedBox(width: 10,),
          Expanded(
            flex: 3,
            child: Container(
                width: 140,
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
                        title: "Last 3months".tr,
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
          ),
        ],
      ),
    );




  }
}
