import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  final String? title;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final int? maxLine;
  final String? fontFamily;

  const ReusableText(
      {Key? key,
      this.title,
      this.size,
      this.weight,
      this.color = Colors.black,
      this.fontStyle,
      this.fontFamily='DMSans' ,
      this.maxLine = 100,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLine,
      title!,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          color: color,
          fontFamily: fontFamily,
          overflow: TextOverflow.ellipsis,
          fontStyle: fontStyle),
    );
  }
}
