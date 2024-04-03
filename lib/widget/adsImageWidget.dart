// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../controller/homeController.dart';
import '../model/response/homeResponse.dart';
import '../utils/colors.dart';
import 'gridAdsWidget.dart';

class AdsImageWidget extends StatefulWidget {
  String? title;
  ItemGroup? itemGroup;
  String grpDesign;
  final homeController = Get.put(HomeController());

  AdsImageWidget(
      {super.key, this.title, this.itemGroup, required this.grpDesign});

  @override
  State<AdsImageWidget> createState() => _AdsImageWidgetState();
}

class _AdsImageWidgetState extends State<AdsImageWidget> {
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
        widget.grpDesign == "1"
            ? imageDesign1(
                itemGroup: widget.itemGroup,
              )
            : widget.grpDesign == "2"
                ? imageDesign2(
                    itemGroup: widget.itemGroup,
                  )
                : widget.grpDesign == "3"
                    ? GridAdsWidget(
                        itemGroup: widget.itemGroup,
                      )
                    : SizedBox(),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

class imageDesign1 extends StatelessWidget {
  ItemGroup? itemGroup;

  imageDesign1({super.key, this.itemGroup});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [blue, lightBlue, pink]),
        ),
        child: FlutterCarousel(
          options: CarouselOptions(
            initialPage: 1,
            autoPlay: false,
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
            viewportFraction: 0.4,
            height: 170.0,
            showIndicator: false,
            slideIndicator: const CircularSlideIndicator(),
          ),
          items: itemGroup!.grpImages!.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                    padding: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: FadeInImage.assetNetwork(
                          fit: BoxFit.fill,
                          placeholder: 'assets/images/logo.png',
                          image: i.image.toString()),
                    ));
              },
            );
          }).toList(),
        ));
  }
}

class imageDesign2 extends StatelessWidget {
  ItemGroup? itemGroup;

  imageDesign2({super.key, this.itemGroup});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        initialPage: 0,
        autoPlay: false,
        enableInfiniteScroll: true,
        enlargeCenterPage: false,
        viewportFraction: 0.7,
        height: 170.0,
        showIndicator: false,
        slideIndicator: const CircularSlideIndicator(),
      ),
      items: itemGroup!.grpImages!.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
                padding: const EdgeInsets.only(right: 10, top: 0, bottom: 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: 'assets/images/logo.png',
                      image: i.image.toString()),
                ));
          },
        );
      }).toList(),
    );
  }
}

class imageDesign3 extends StatelessWidget {
  ItemGroup? itemGroup;

  imageDesign3({super.key, this.itemGroup});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        initialPage: 0,
        autoPlay: false,
        enableInfiniteScroll: true,
        enlargeCenterPage: false,
        viewportFraction: 0.7,
        height: 170.0,
        showIndicator: false,
        slideIndicator: const CircularSlideIndicator(),
      ),
      items: itemGroup!.grpImages!.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
                padding: const EdgeInsets.only(right: 10, top: 0, bottom: 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: 'assets/images/logo.png',
                      image: i.image.toString()),
                ));
          },
        );
      }).toList(),
    );
  }
}
