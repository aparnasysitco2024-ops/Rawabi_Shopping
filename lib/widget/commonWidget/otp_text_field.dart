import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class OtpTextField extends StatelessWidget {
  final Function(String v)? onChanged;
  final TextEditingController? controller;

  const OtpTextField({
    Key? key,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 55,
      child: TextField(
        style: TextStyle(
          fontFamily: Get.locale!.languageCode == 'en' ? 'englishFont' : 'elmessiri',
        ),
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          filled: true,
          fillColor: lightGreyColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
