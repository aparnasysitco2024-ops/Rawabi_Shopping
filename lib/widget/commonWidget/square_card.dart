import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../../utils/colors.dart';

class SquareCard extends StatelessWidget {
  final String image;
  final String title;

  const SquareCard({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 83,
      width: 83,
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: grey, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            fit: BoxFit.fill,
            width: 28,
            height: 28,
          ),
          const SizedBox(
            height: 10,
          ),
          ReusableText(
            title: title.tr,
            size: 10,
            weight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
