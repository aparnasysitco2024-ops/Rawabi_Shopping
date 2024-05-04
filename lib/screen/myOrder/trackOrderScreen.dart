import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/commonwidget/svg_icon.dart';

import '../../controller/trackOrderController.dart';
import '../../model/response/myorder/myOrderResponse.dart';
import '../../utils/colors.dart';
import '../../widget/commonwidget/reusable_text.dart';

// ignore: must_be_immutable
class TrackOrderScreen extends StatelessWidget {
  String id;
  Orders myOrder;

  TrackOrderScreen({super.key, required this.id, required this.myOrder});

  final trackOrderController = Get.put(TrackOrderController());

  @override
  Widget build(BuildContext context) {
    trackOrderController.getStatus(id);
    return PopScope(
      onPopInvoked: (didPop) {
        Get.delete<TrackOrderController>();
      },
      child: Obx(() => Scaffold(
          backgroundColor: silver,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: white,
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: double.maxFinite,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Stack(
                          children: [
                            Center(
                              child: ReusableText(
                                title: "Track Order".tr,
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
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8.0),
                  child: Column(
                    children: [
                      // Container(
                      //   padding: const EdgeInsets.only(left: 10, right: 10),
                      //   height: 30,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(4),
                      //     gradient: const LinearGradient(
                      //         begin: Alignment.topLeft,
                      //         end: Alignment.bottomRight,
                      //         colors: [blue, lightBlue, pink]),
                      //   ),
                      //   child: Row(children: [
                      //     Image.asset(
                      //       "assets/icons/clock.png",
                      //       height: 30,
                      //     ),
                      //     const SizedBox(
                      //       width: 5,
                      //     ),
                      //     ReusableText(
                      //       title: "Deliver today at 5.00 pm".tr,
                      //       size: 10,
                      //       weight: FontWeight.w600,
                      //       color: white,
                      //     ),
                      //     const Spacer(),
                      //     Container(
                      //       padding: const EdgeInsets.all(4),
                      //       decoration: const BoxDecoration(
                      //           color: white,
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(3))),
                      //       child: InkWell(
                      //         onTap: () {},
                      //         child: ReusableText(
                      //           title: "Change time".tr,
                      //           size: 10,
                      //           color: blue,
                      //         ),
                      //       ),
                      //     )
                      //   ]),
                      // ),
                      // const SizedBox(
                      //   height: 6,
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  title: "Deliver To ".tr,
                                  size: 12,
                                  weight: FontWeight.w600,
                                ),
                                ReusableText(
                                  title: myOrder.addressName.toString() +
                                      ", " +
                                      myOrder.address.toString() +
                                      ", " +
                                      myOrder.phone.toString(),
                                  size: 12,
                                  weight: FontWeight.w400,
                                ),
                              ],
                            ),
                            const Spacer(),
                            // ReusableText(
                            //   title: "Change".tr,
                            //   size: 10,
                            //   color: blue,
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 64,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  title: "Total Amount".tr,
                                  size: 12,
                                  weight: FontWeight.w400,
                                ),
                                ReusableText(
                                  title: "QAR " + myOrder.payable.toString(),
                                  size: 12,
                                  weight: FontWeight.w600,
                                ),
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 125,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 2),
                                decoration: const BoxDecoration(
                                    color: pink,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                child: ReusableText(
                                  title: "Track Your Order".tr,
                                  color: primaryColor,
                                  size: 12,
                                  weight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      trackOrderController.loading.value
                          ? SizedBox()
                          : Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            trackOrderController.status.value
                                                        .orderPlaced ==
                                                    "yes"
                                                ? Checked()
                                                : EmptyChecked(),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ReusableText(
                                                  title: "Order placed".tr,
                                                  size: 10,
                                                  weight: FontWeight.w600,
                                                ),
                                                Wrap(children: [
                                                  ReusableText(
                                                    title: trackOrderController
                                                        .status.value.orderTime,
                                                    size: 10,
                                                    color: blue,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ]),
                                              ],
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 19.0, vertical: 5),
                                          child: FDottedLine(
                                            color: blackLight,
                                            height: 26.0,
                                            width: 0,
                                            strokeWidth: 2.0,
                                            dottedLength: 3.0,
                                            space: 2.0,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            trackOrderController.status.value
                                                        .processing ==
                                                    "yes"
                                                ? Checked()
                                                : EmptyChecked(),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ReusableText(
                                                  title: "Item Processed".tr,
                                                  size: 10,
                                                  weight: FontWeight.w600,
                                                ),
                                                ReusableText(
                                                  title: trackOrderController
                                                      .status.value.processTime,
                                                  size: 10,
                                                  color: blue,
                                                  weight: FontWeight.w400,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 19.0, vertical: 5),
                                          child: FDottedLine(
                                            color: blackLight,
                                            height: 26.0,
                                            width: 0,
                                            strokeWidth: 2.0,
                                            dottedLength: 3.0,
                                            space: 2.0,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            trackOrderController.status.value
                                                        .delivering ==
                                                    "yes"
                                                ? Checking()
                                                : trackOrderController.status
                                                            .value.delivered ==
                                                        "yes"
                                                    ? Checked()
                                                    : EmptyChecked(),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ReusableText(
                                                  title: "Delivering".tr,
                                                  size: 10,
                                                  color: primaryColor,
                                                  weight: FontWeight.w600,
                                                ),
                                                ReusableText(
                                                  title: trackOrderController
                                                              .status
                                                              .value
                                                              .delivering ==
                                                          "yes"
                                                      ? "Your delivery is on the way"
                                                          .tr
                                                      : trackOrderController
                                                          .status
                                                          .value
                                                          .deliverTime,
                                                  size: 10,
                                                  color: blackLight,
                                                  weight: FontWeight.w400,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 19.0, vertical: 5),
                                          child: FDottedLine(
                                            color: blackLight,
                                            height: 26.0,
                                            width: 0,
                                            strokeWidth: 2.0,
                                            dottedLength: 3.0,
                                            space: 2.0,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            trackOrderController.status.value
                                                        .delivering ==
                                                    "yes"
                                                ? Checking()
                                                : trackOrderController.status
                                                            .value.delivered ==
                                                        "yes"
                                                    ? Checked()
                                                    : EmptyChecked(),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ReusableText(
                                                  title: "Item Delivered".tr,
                                                  size: 10,
                                                  color: primaryColor,
                                                  weight: FontWeight.w600,
                                                ),
                                                ReusableText(
                                                  title: trackOrderController
                                                      .status
                                                      .value
                                                      .deliveryTime,
                                                  size: 10,
                                                  color: blackLight,
                                                  weight: FontWeight.w400,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  // Expanded(
                                  //   flex: 3,
                                  //   child: GestureDetector(
                                  //     onTap: () {},
                                  //     child: Container(
                                  //       alignment: Alignment.center,
                                  //       height: 30,
                                  //       width: 125,
                                  //       padding: const EdgeInsets.symmetric(
                                  //           horizontal: 3, vertical: 2),
                                  //       decoration: const BoxDecoration(
                                  //           color: skyBlue,
                                  //           borderRadius:
                                  //               BorderRadius.all(Radius.circular(100))),
                                  //       child: ReusableText(
                                  //         title: "Cancel Order".tr,
                                  //         color: blackLight,
                                  //         size: 12,
                                  //         weight: FontWeight.w600,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ))),
    );
  }
}

class Checked extends StatelessWidget {
  const Checked({super.key});

  @override
  Widget build(BuildContext context) {
    return FDottedLine(
        color: pink,
        strokeWidth: 0.0,
        dottedLength: 8.0,
        space: 3.0,
        corner: FDottedLineCorner.all(75.0),
        child: Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          color: pink,
          child: CircleAvatar(
            radius: 15,
            backgroundColor: lightPink,
            child: SvgPicture.asset("assets/icons/Tick.svg"),
          ),
        ));
  }
}

class EmptyChecked extends StatelessWidget {
  const EmptyChecked({super.key});

  @override
  Widget build(BuildContext context) {
    return FDottedLine(
        color: blackLight,
        strokeWidth: 2.0,
        dottedLength: 3.0,
        space: 3.0,
        corner: FDottedLineCorner.all(75.0),
        child: Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
        ));
  }
}

class Checking extends StatelessWidget {
  const Checking({super.key});

  @override
  Widget build(BuildContext context) {
    return FDottedLine(
        color: pink,
        strokeWidth: 0.0,
        dottedLength: 8.0,
        space: 3.0,
        corner: FDottedLineCorner.all(75.0),
        child: Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          color: pink,
          child: const CircleAvatar(
            radius: 15,
            backgroundColor: primaryColor,
            child: SvgIcon(
              image: "assets/icons/Tick.svg",
              color: white,
            ),
          ),
        ));
  }
}
