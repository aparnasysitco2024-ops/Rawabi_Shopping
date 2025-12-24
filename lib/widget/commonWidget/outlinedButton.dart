import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class OutLinedButton extends StatelessWidget {
  final String? title;
  final Size? size;
  final Color? txtColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Function()? onPressed;
  final double? fontSize;
  final FontWeight fontWeight;
  final Color? bgColor;
  final Widget? child;

  const OutLinedButton({
    Key? key,
    this.title,
    this.size,
    this.txtColor = Colors.white,
    this.backgroundColor = primaryColor,
    this.textStyle,
    this.onPressed,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w700,
    this.bgColor, this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: size ?? Size(MediaQuery.of(context).size.width, 52),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        side: BorderSide(width: 2, color: txtColor!),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        foregroundColor: txtColor!,
        backgroundColor: bgColor,
      ),
      onPressed: onPressed ?? () {},
      child: child ?? Text(
        title!,
        style: TextStyle(
            fontFamily: Get.locale?.languageCode == 'ar' ? 'cairo' : 'openSans',
            color: txtColor!,
            fontWeight: FontWeight.w700,
            fontSize: fontSize),
      ),
    );
  }
}
