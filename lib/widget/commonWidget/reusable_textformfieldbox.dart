import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReusableTextFormBox extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool? obscureText;
  final bool? enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final fillColor;
  final Color? borderColor;

  const ReusableTextFormBox({
    Key? key,
    this.validator,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.suffixIcon,
    this.fillColor = Colors.white,
    this.obscureText = false,
    this.enabled = true,
    this.prefixIcon,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText!,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          enabled: enabled!,
          hintText: hintText,
          labelStyle: TextStyle(
            fontFamily:
                Get.locale!.languageCode == 'en' ? 'englishFont' : 'elmessiri',
          ),
          hintStyle: TextStyle(
            fontFamily:
                Get.locale!.languageCode == 'en' ? 'englishFont' : 'elmessiri',
          ),
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            // borderSide: BorderSide.none,
            borderSide:
                BorderSide(color: Colors.blue.withOpacity(0.5), width: 1.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            // borderSide: BorderSide.none,
            borderSide:
            BorderSide(color: borderColor??Colors.blue.withOpacity(0.5), width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            // borderSide: BorderSide.none,
            borderSide:
            BorderSide(color: Colors.red.withOpacity(0.5), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            // borderSide: BorderSide.none,
            borderSide:
            BorderSide(color: borderColor??Colors.blue.withOpacity(0.5), width: 1.0),
          ),
        ),
        // validations
        validator: validator);
  }
}
