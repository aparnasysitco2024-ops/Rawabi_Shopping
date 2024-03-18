import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';

class SearchOrdersWidget extends StatelessWidget {
  final TextEditingController ? controller;
  const SearchOrdersWidget({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 42,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: silver,
        borderRadius: BorderRadius.all(Radius.circular(4))),
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
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
    );
  }
}
