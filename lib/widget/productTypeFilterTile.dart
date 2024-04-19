import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';
import 'commonwidget/reusable_text.dart';

// ignore: must_be_immutable
class ProductTypeFilterTile extends StatelessWidget {
  final String title;
  Function(bool) checked;
  final bool isChecked;

  ProductTypeFilterTile(
      {super.key, required this.title, required this.isChecked, required this.checked});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: white,
          activeColor: primaryColor,
          value: isChecked,
          onChanged: (bool? value) {
            checked(value!);
          },
        ),
        ReusableText(
          title: title.tr,
          size: 12,
          weight: FontWeight.w600,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
