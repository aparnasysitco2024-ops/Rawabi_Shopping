// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commomwidget/reusable_button.dart';
import 'package:rawabi/widget/commomwidget/reusable_text.dart';

import '../controller/homeController.dart';

class GridAdsWidget extends StatefulWidget {
  final homeController = Get.put(HomeController());

  GridAdsWidget({super.key});

  @override
  State<GridAdsWidget> createState() => _GridAdsWidgetState();
}

class _GridAdsWidgetState extends State<GridAdsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Image.asset(
                  'assets/images/outdoor.png',
                  fit: BoxFit.fill,
                )),
            const SizedBox(
              height: 5,
            ),
            const ReusableText(
              title: "Outdoor Camping Products",
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
            child: Column(
          children: [
            SizedBox(
                height: 111,
                child: Image.asset(
                  'assets/images/sofa.png',
                  fit: BoxFit.fill,
                )),
            const SizedBox(
              height: 5,
            ),
            const ReusableText(
              title: "Sofas",
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
                height: 111,
                child: Image.asset(
                  'assets/images/chair.png',
                  fit: BoxFit.fill,
                )),
            const SizedBox(
              height: 5,
            ),
            const ReusableText(
              title: "Outdoor Furnitures",
            ),
          ],
        )),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
