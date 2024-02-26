import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class ReusableButton1 extends StatelessWidget {
  final String? title;
  final Size? size;
  final Color? txtColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final bool? isOutlineButton;
  final Function()? onPressed;
  final double? fontSize;
  final FontWeight fontWeight;

  const ReusableButton1({
    Key? key,
    this.title,
    this.size,
    this.txtColor = Colors.white,
    this.backgroundColor = primaryColor,
    this.textStyle,
    this.isOutlineButton = false,
    this.onPressed,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w700,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: txtColor,
      backgroundColor: backgroundColor,
      minimumSize: size ?? Size(MediaQuery.of(context).size.width, 52),
      textStyle:
          textStyle ?? TextStyle(fontWeight: fontWeight, fontSize: fontSize),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
    return isOutlineButton!
        ? OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: size ?? Size(MediaQuery.of(context).size.width, 52),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              side: BorderSide(width: 2, color: txtColor!),
              foregroundColor: txtColor!,
            ),
            onPressed: onPressed ?? () {},
            child: Text(
              title!,
              style: TextStyle(fontFamily:
              Get.locale!.languageCode == 'en' ? 'englishFont' : 'elmessiri',
                  color: txtColor!, fontWeight: FontWeight.w700, fontSize: 18),
            ),
          )
        : ElevatedButton(
            style: raisedButtonStyle,
            onPressed: onPressed ?? () {},
            child: Text(title!),
          );
  }
}
