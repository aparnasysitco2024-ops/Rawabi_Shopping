import 'package:flutter/material.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../../utils/colors.dart';

class ReusableButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final width;
  final buttonColor;
  final textColor;
  final textSize;
  final padding;
  final borderRadius;

  const ReusableButton(
      {Key? key,
      required this.onTap,
      required this.title,
      this.buttonColor = primaryColor,
      this.textColor = Colors.white,
      this.textSize,
      this.padding = 12.0,
      this.borderRadius = 30.0,
      this.width = double.infinity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: buttonColor,
        ),
        child: ReusableText(
          // fontFamily:
          // Get.locale!.languageCode == 'en' ? 'englishFont' : 'elmessiri',
          title: title,
          weight: FontWeight.w700,
          size: textSize,
          color: textColor,
        ),
      ),
    );
  }
}
