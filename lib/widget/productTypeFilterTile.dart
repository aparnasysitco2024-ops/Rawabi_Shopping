
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';
import 'commonwidget/reusable_text.dart';

class ProductTypeFilterTile extends StatelessWidget {
  final String title;

  final bool isChecked;

  const ProductTypeFilterTile({super.key,required this.title,required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: white,
          activeColor: primaryColor,
          value: isChecked,
          onChanged: (bool? value) {
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
