import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonWidget/reusable_text.dart';

class ReusableTextForm extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? text;
  final bool? obscureText;
  final bool? enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? fillColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  const ReusableTextForm({
    Key? key,
    this.validator,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.text = "",
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.prefixIcon,
    this.fillColor,
    this.borderRadius,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText!,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? white,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabled: enabled!,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: ReusableText(
          title: text,
        ),
        labelStyle: TextStyle(
          fontFamily: Get.locale!.languageCode == 'en' ? 'DMSans' : 'DMSans',
        ),
        hintStyle: TextStyle(
          fontFamily: Get.locale!.languageCode == 'en' ? 'DMSans' : 'DMSans',
        ),
        contentPadding: contentPadding ?? const EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          borderSide: BorderSide.none,
        ),
      ),
      // validations
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
