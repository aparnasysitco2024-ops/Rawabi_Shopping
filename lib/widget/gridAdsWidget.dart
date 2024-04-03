// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/homeController.dart';
import '../model/response/homeResponse.dart';
import 'commonWidget/networkImageWidget.dart';

class GridAdsWidget extends StatefulWidget {
  ItemGroup? itemGroup;
  final homeController = Get.put(HomeController());

  GridAdsWidget({super.key, required this.itemGroup});

  @override
  State<GridAdsWidget> createState() => _GridAdsWidgetState();
}

class _GridAdsWidgetState extends State<GridAdsWidget> {
  @override
  Widget build(BuildContext context) {
    int? itemLength = widget.itemGroup?.grpImages?.length;
    return itemLength! > 2
        ? Row(
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
                      child: NetworkImageWidget(
                        image: widget.itemGroup!.grpImages![0].image.toString(),
                        fit: BoxFit.fill,
                      )),
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
                      height: 123,
                      child: NetworkImageWidget(
                        image: widget.itemGroup!.grpImages![1].image.toString(),
                        fit: BoxFit.fill,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                      height: 123,
                      child: NetworkImageWidget(
                        image: widget.itemGroup!.grpImages![2].image.toString(),
                        fit: BoxFit.fill,
                      )),
                ],
              )),
              const SizedBox(
                width: 10,
              ),
            ],
          )
        : SizedBox();
  }
}
