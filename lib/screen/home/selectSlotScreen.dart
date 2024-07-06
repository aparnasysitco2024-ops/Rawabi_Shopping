import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rawabi/controller/homeController.dart';
import 'package:rawabi/utils/colors.dart';

import '../../controller/slotController.dart';
import '../../model/response/slotResponse.dart';
import '../../widget/Commonwidget/reusable_text.dart';
import '../../widget/commonWidget/reusable_button1.dart';

class SelectSlotScreen extends StatefulWidget {
  const SelectSlotScreen({super.key});

  @override
  State<SelectSlotScreen> createState() => _SelectSlotScreenState();
}

class _SelectSlotScreenState extends State<SelectSlotScreen> {
  final slotController = Get.put(SlotController());
  final homeController = Get.put(HomeController());
  var selectedSlot;

  late int selectedDateIndex = 0;
  late int? selectedSlotIndex = null;

  var displaySlots = <Slot>[];
  DateTime todayDate = DateTime.now();
  Map<int, String> weekdayName = {
    1: "MON",
    2: "TUE",
    3: "WED",
    4: "THU",
    5: "FRI",
    6: "SAT",
    7: "SUN"
  };

  @override
  void initState() {
    super.initState();
    slotController.getStoreData();
  }

  // void getDefaultSlot() {
  //   slotController.slots.forEach((element) {
  //     if (element.limit != "0") {
  //       selectedSlotIndex = int.parse(element.slotid.toString()) - 1;
  //       return;
  //     }
  //   });
  //   selectedSlotIndex = null;
  // }

  @override
  Widget build(BuildContext context) {
    // slotController.getStoreData();
    if (selectedDateIndex == 0)
      displaySlots = slotController.availableSlots;
    else
      displaySlots = slotController.allSlots;
    return PopScope(
      onPopInvoked: (didPop) {
        Get.delete<SlotController>();
      },
      child: Obx(() => Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              centerTitle: true,
              title: ReusableText(
                title: "Select Slot",
                size: 20,
                weight: FontWeight.bold,
              ),
            ),
            body: slotController.loading.value
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 280,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Divider(thickness: 3, color: lightGreyColor),
                            Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: double.maxFinite,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  itemCount: 7,
                                  itemBuilder: (BuildContext context, index) {
                                    return InkWell(
                                      onTap: () {
                                        if (mounted) {
                                          setState(() {
                                            selectedDateIndex = index;
                                            selectedSlotIndex = null;
                                          });
                                        }
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ReusableText(
                                            title: weekdayName[todayDate
                                                .add(Duration(days: index))
                                                .weekday],
                                            color: blackLight,
                                            weight: FontWeight.w500,
                                            size: 12,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: index == selectedDateIndex
                                                ? 38
                                                : 34,
                                            width: index == selectedDateIndex
                                                ? 38
                                                : 34,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: index == selectedDateIndex
                                                  ? primaryColor
                                                  : white,
                                              boxShadow: index ==
                                                      selectedDateIndex
                                                  ? [
                                                      const BoxShadow(
                                                        color: grey,
                                                        offset: Offset(
                                                          5.0,
                                                          5.0,
                                                        ),
                                                        blurRadius: 10.0,
                                                        spreadRadius: 2.0,
                                                      ), //BoxShadow
                                                      const BoxShadow(
                                                        color: Colors.white,
                                                        offset:
                                                            Offset(0.0, 0.0),
                                                        blurRadius: 0.0,
                                                        spreadRadius: 0.0,
                                                      ), //BoxShadow
                                                    ]
                                                  : null,
                                            ),
                                            child: ReusableText(
                                              title: todayDate
                                                  .add(Duration(days: index))
                                                  .day
                                                  .toString(),
                                              color: index == selectedDateIndex
                                                  ? white
                                                  : black,
                                              weight: FontWeight.w500,
                                              size: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            Divider(thickness: 2, color: lightGreyColor),
                            ReusableText(
                              title: DateFormat.yMMMEd()

                                  // displaying formatted date
                                  .format(todayDate
                                      .add(Duration(days: selectedDateIndex))),
                              color: black,
                              weight: FontWeight.w500,
                              size: 14,
                            ),
                            Divider(thickness: 6, color: lightGreyColor),
                            displaySlots.isEmpty
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      ReusableText(
                                        title: "No slots available!",
                                        size: 20,
                                        weight: FontWeight.bold,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  )
                                : Flexible(
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      padding:
                                          EdgeInsets.only(left: 16, right: 16),
                                      itemCount: displaySlots.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Radio(
                                                  activeColor:
                                                      (selectedSlotIndex ==
                                                                  index &&
                                                              displaySlots[index]
                                                                      .limit !=
                                                                  "0")
                                                          ? primaryColor
                                                          : white,
                                                  fillColor: WidgetStateProperty
                                                      .resolveWith(
                                                          (Set states) {
                                                    if (states.contains(
                                                        WidgetState.disabled)) {
                                                      return white;
                                                    }
                                                    return primaryColor;
                                                  }),
                                                  value: index,
                                                  groupValue: selectedSlotIndex,
                                                  onChanged: (value) {
                                                    if (displaySlots[index]
                                                            .limit !=
                                                        "0") {
                                                      if (mounted) {
                                                        setState(() {
                                                          selectedSlotIndex =
                                                              index;
                                                          slotController
                                                                  .selectedSlot
                                                                  .value =
                                                              displaySlots[
                                                                  index];
                                                        });
                                                      }
                                                    }
                                                  }),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              ReusableText(
                                                title:
                                                    "${displaySlots[index].starttime} - ${displaySlots[index].endtime}",
                                                color:
                                                    displaySlots[index].limit ==
                                                            "0"
                                                        ? grey
                                                        : blackLight,
                                                weight: FontWeight.w500,
                                                size: 12,
                                              ),
                                              Spacer(),
                                              ReusableText(
                                                title:
                                                    displaySlots[index].limit ==
                                                            "0"
                                                        ? "Slot Full"
                                                        : "",
                                                color: Color(0xFFA41217),
                                                weight: FontWeight.w700,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Divider(
                                            thickness: 2,
                                            color: lightGreyColor);
                                      },
                                    ),
                                  ),
                            Divider(thickness: 2, color: lightGreyColor),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(bottom: 30, left: 10, right: 10),
                        child: ReusableButton1(
                          onPressed: () {
                            if (selectedSlotIndex != null)
                              slotController.checkSlotAvailability(
                                  selectedSlotIndex!, selectedDateIndex);
                          },
                          title: "Select Slot",
                        ),
                      )
                    ],
                  ),
          )),
    );
  }
}
