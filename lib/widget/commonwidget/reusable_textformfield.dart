import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReusableTextForm extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool? obscureText;
  final bool? enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const ReusableTextForm({
    Key? key,
    this.validator,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.prefixIcon,
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
          fillColor: Colors.white,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          enabled: enabled!,
          hintText: hintText,
          labelStyle: TextStyle(
            fontFamily:
                Get.locale!.languageCode == 'en' ? 'DMSans' : 'DMSans',
          ),
          hintStyle: TextStyle(
            fontFamily:
                Get.locale!.languageCode == 'en' ? 'DMSans' : 'DMSans',
          ),
          contentPadding: const EdgeInsets.all(20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        // validations
        validator: validator);
  }
}
