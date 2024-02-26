// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../controller/homeController.dart';
import '../model/homeResponse.dart';

class AdsWidget extends StatefulWidget {
  String? title;
  ItemGroup? itemGroup;
  final homeController = Get.put(HomeController());

  AdsWidget({super.key, this.title, this.itemGroup});

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
          height: 5,
        ),
        FlutterCarousel(
          options: CarouselOptions(
            height: 130.0,
            showIndicator: false,
          ),
          items: widget.itemGroup!.grpImages!.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
                  child: FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: 'assets/images/logo.png',
                      image: i.image.toString()));
              },
            );
          }).toList(),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
