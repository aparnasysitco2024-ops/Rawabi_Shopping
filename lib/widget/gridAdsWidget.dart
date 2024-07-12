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
        ? Padding(
            padding: const EdgeInsets.only(left: 5,right: 5),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    onClick(0);
                  },
                  child: SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: NetworkImageWidget(
                        image: widget.itemGroup!.grpImages![0].image.toString(),
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Flexible(
                      child: SizedBox(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: () {
                              onClick(1);
                            },
                            child: NetworkImageWidget(
                              image: widget.itemGroup!.grpImages![1].image
                                  .toString(),
                              fit: BoxFit.fill,
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: SizedBox(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: () {
                              onClick(2);
                            },
                            child: NetworkImageWidget(
                              image: widget.itemGroup!.grpImages![2].image
                                  .toString(),
                              fit: BoxFit.fill,
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          )
        // Row(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           const SizedBox(
        //             width: 10,
        //           ),
        //           Column(
        //             children: [
        //               InkWell(
        //                 onTap: () {
        //                   onClick(0);
        //                 },
        //                 child: SizedBox(
        //                     height: 250,
        //                     width: MediaQuery.of(context).size.width * 0.6,
        //                     child: NetworkImageWidget(
        //                       image:
        //                           widget.itemGroup!.grpImages![0].image.toString(),
        //                       fit: BoxFit.fill,
        //                     )),
        //               ),
        //               const SizedBox(
        //                 height: 5,
        //               ),
        //             ],
        //           ),
        //           const SizedBox(
        //             width: 5,
        //           ),
        //           Flexible(
        //               child: Column(
        //             children: [
        //               InkWell(
        //                 onTap: () {
        //                   onClick(1);
        //                 },
        //                 child: SizedBox(
        //                     height: 123,
        //                     child: NetworkImageWidget(
        //                       image:
        //                           widget.itemGroup!.grpImages![1].image.toString(),
        //                       fit: BoxFit.fill,
        //                     )),
        //               ),
        //               const SizedBox(
        //                 height: 5,
        //               ),
        //               InkWell(
        //                 onTap: () {
        //                   onClick(2);
        //                 },
        //                 child: SizedBox(
        //                     height: 123,
        //                     child: NetworkImageWidget(
        //                       image:
        //                           widget.itemGroup!.grpImages![2].image.toString(),
        //                       fit: BoxFit.fill,
        //                     )),
        //               ),
        //             ],
        //           )),
        //           const SizedBox(
        //             width: 10,
        //           ),
        //         ],
        //       )
        : SizedBox();
  }

  onClick(int position) {
    if (widget.itemGroup!.grpImages![position].linkType == "category") {
      widget.homeController.moveToProductList(
          context,
          widget.itemGroup!.grpImages![position].bannerPoint.toString(),
          "0",
          "0",
          "0",
          "0");
    } else if (widget.itemGroup!.grpImages![position].linkType ==
        "sub_category") {
      widget.homeController.moveToProductList(
          context,
          widget.itemGroup!.grpImages![position].cat.toString(),
          widget.itemGroup!.grpImages![position].bannerPoint.toString(),
          "0",
          "0",
          "0");
    } else if (widget.itemGroup!.grpImages![position].linkType ==
        "sub_sub_category") {
      widget.homeController.moveToProductList(
          context,
          widget.itemGroup!.grpImages![position].cat.toString(),
          widget.itemGroup!.grpImages![position].subcat.toString(),
          widget.itemGroup!.grpImages![position].bannerPoint.toString(),
          "0",
          "0");
    } else if (widget.itemGroup!.grpImages![position].linkType ==
        "sub_sub_sub_category") {
      widget.homeController.moveToProductList(
          context,
          widget.itemGroup!.grpImages![position].cat.toString(),
          widget.itemGroup!.grpImages![position].subcat.toString(),
          widget.itemGroup!.grpImages![position].subsubcat.toString(),
          widget.itemGroup!.grpImages![position].bannerPoint.toString(),
          "0");
    } else if (widget.itemGroup!.grpImages![position].linkType == "product") {
      widget.homeController.moveToProductDetails(context,
          widget.itemGroup!.grpImages![position].bannerPoint.toString());
    } else if (widget.itemGroup!.grpImages![position].linkType == "brand") {
      widget.homeController.moveToProductList(context, "0", "0", "0", "0",
          widget.itemGroup!.grpImages![position].bannerPoint.toString());
    }
  }
}
