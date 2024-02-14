// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commomwidget/reusable_button.dart';
import 'package:rawabi/widget/commomwidget/reusable_text.dart';

import '../controller/homeController.dart';

class AdsWidget extends StatefulWidget {
  String? title;
  final homeController = Get.put(HomeController());

  AdsWidget({super.key, this.title});

  @override
  State<AdsWidget> createState() => _AdsWidgetState();
}

class _AdsWidgetState extends State<AdsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 35,
          alignment: Alignment.centerLeft,
          color: Colors.white,
          padding: const EdgeInsets.only(left: 10),
          child: ReusableText(
            title: widget.title,
            weight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FlutterCarousel(
          options: CarouselOptions(
            height: 180.0,
            showIndicator: false,
          ),
          items: widget.homeController.bannerList3.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(
                      right: 5, top: 5, bottom: 5),
                  child: Image.asset(
                    i,
                    fit: BoxFit.fill,
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
