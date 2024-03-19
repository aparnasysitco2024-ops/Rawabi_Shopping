import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/orderDetailsTile.dart';
import 'package:rawabi/widget/searchOrderWidget.dart';
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
                height: 120,
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
                    SizedBox(
                      height: 50,
                      child: ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(vertical: -3),
                        leading: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: blackLight,
                            size: 24,
                          ),
                        ),
                        title: ReusableText(
                          title: "Track Order".tr,
                          size: 18,
                          weight: FontWeight.w700,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 8.0),
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
                        SvgPicture.asset(
                          "assets/icons/Clock.svg",
                          height: 35,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const ReusableText(
                          title: "Deliver today at 5.00 pm",
                          size: 10,
                          weight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                              color: Colors.white,
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
                    const SizedBox(height: 6,),
                    Container(
                      height: 85,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
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
                                title: "Ilyas Doodler, A 38, A wakra Shopping Complex, Al wakra, Doha,Qatar.".tr,
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
                    const SizedBox(height: 6,),
                    Container(
                      alignment: Alignment.center,
                      height: 64,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
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
                            onTap: (){

                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 125,
                              padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 2),
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
                    const SizedBox(height: 6,),
                    Container(
                      height: 285,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),

                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
