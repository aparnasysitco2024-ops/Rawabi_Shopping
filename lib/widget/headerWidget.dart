import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'commonWidget/reusable_text.dart';

// ignore: must_be_immutable
class HeaderWidget extends StatelessWidget {
  var title;
  Function() onBack;

  HeaderWidget({super.key, this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      padding: const EdgeInsets.only(bottom: 0),
      width: double.maxFinite,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 40,
            width: double.maxFinite,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Stack(
              children: [
                Center(
                  child: ReusableText(
                    title: title,
                    size: 18,
                    weight: FontWeight.bold,
                    textAlign: TextAlign.left,
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: blackLight,
                      size: 24,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 2,
            color: lightGreyColor,
          ),
        ],
      ),
    );
  }
}
