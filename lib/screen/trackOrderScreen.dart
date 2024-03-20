import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/commonwidget/svg_icon.dart';
import '../utils/colors.dart';
import '../widget/commonwidget/reusable_text.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: silver,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 110,
                color: white,
                width: double.maxFinite,
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Divider(
                      thickness: 1,
                      color: lightGreyColor,
                    ),
                    Container(
                      height: 40,
                      width: double.maxFinite,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 5,bottom: 5),
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
                            ),)
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
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [blue, lightBlue, pink]),
                      ),
                      child: Row(children: [
                        Image.asset(
                          "assets/icons/clock.png",
                          height: 30,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const ReusableText(
                          title: "Deliver today at 5.00 pm",
                          size: 10,
                          weight: FontWeight.w600,
                          color: white,
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                              color: white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3))),
                          child: InkWell(
                            onTap: () {},
                            child: ReusableText(
                              title: "Change time".tr,
                              size: 10,
                              color: blue,
                            ),
                          ),
                        )
                      ]),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      height: 85,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                title: "Deliver To".tr,
                                size: 12,
                                weight: FontWeight.w600,
                              ),
                              ReusableText(
                                title:
                                    "Ilyas Doodler, A 38, A wakra Shopping Complex, Al wakra, Doha,Qatar."
                                        .tr,
                                size: 12,
                                weight: FontWeight.w400,
                              ),
                            ],
                          ),
                          const Spacer(),
                          ReusableText(
                            title: "Change".tr,
                            size: 10,
                            color: blue,
                          ),
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
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                title: "Total Amount",
                                size: 12,
                                weight: FontWeight.w400,
                              ),
                              ReusableText(
                                title: "QAR 20.00",
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
                              child: const ReusableText(
                                title: "Track Your Order",
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
                    Container(
                      height: 285,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  FDottedLine(
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
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                        title: "Order placed",
                                        size: 10,
                                        weight: FontWeight.w600,
                                      ),
                                      ReusableText(
                                        title: "2:30 Pm - 27-Dec-2023",
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
                                  FDottedLine(
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
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                        title: "Item Processed",
                                        size: 10,
                                        weight: FontWeight.w600,
                                      ),
                                      ReusableText(
                                        title: "Bagged from Shop at 2:45 Pm",
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
                                  FDottedLine(
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
                                          child:
                                          SvgIcon(image: "assets/icons/Tick.svg",color: white,),
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                        title: "Delivering",
                                        size: 10,
                                        color: primaryColor,
                                        weight: FontWeight.w600,
                                      ),
                                      ReusableText(
                                        title: "Your delivery is on the way",
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
                                  FDottedLine(
                                      color: blackLight,
                                      strokeWidth: 2.0,
                                      dottedLength: 3.0,
                                      space: 3.0,
                                      corner: FDottedLineCorner.all(75.0),
                                      child: Container(
                                        width: 38,
                                        height: 38,
                                        alignment: Alignment.center,
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                        title: "Item Delivered",
                                        size: 10,
                                        color: primaryColor,
                                        weight: FontWeight.w600,
                                      ),
                                      ReusableText(
                                        title: "Expected at 3:00 Pm Today",
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
                                  color: skyBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              child: const ReusableText(
                                title: "Cancel Order",
                                color: blackLight,
                                size: 12,
                                weight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
