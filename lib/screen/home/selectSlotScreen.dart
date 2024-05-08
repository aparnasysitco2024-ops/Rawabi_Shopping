import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:intl/intl.dart';
import '../../controller/slotController.dart';
import '../../widget/Commonwidget/reusable_text.dart';

class SelectSlotScreen extends StatefulWidget {
  const SelectSlotScreen({super.key});

  @override
  State<SelectSlotScreen> createState() => _SelectSlotScreenState();
}

class _SelectSlotScreenState extends State<SelectSlotScreen> {
  final slotController = Get.put(SlotController());

  late int selectedDateIndex = 0;
  late int? selectedSlotIndex = 0;
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
void getDefaultSlot(){
slotController.slots.forEach((element) {
  if(element.limit!="0"){
    selectedSlotIndex=int.parse(element.slotid.toString())-1;
    return;
  }
});
selectedSlotIndex=null;
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(thickness: 3, color: lightGreyColor),
          Container(
            alignment: Alignment.center,
            height: 100,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16, right: 16),
                itemCount: 7,
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          selectedDateIndex = index;
                        });
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                          title: weekdayName[
                              todayDate.add(Duration(days: index)).weekday],
                          color: blackLight,
                          weight: FontWeight.w500,
                          size: 12,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: index == selectedDateIndex ? 38 : 34,
                          width: index == selectedDateIndex ? 38 : 34,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == selectedDateIndex
                                ? primaryColor
                                : white,
                            boxShadow: index == selectedDateIndex
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
                                      offset: Offset(0.0, 0.0),
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
                            color: index == selectedDateIndex ? white : black,
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
                .format(todayDate.add(Duration(days: selectedDateIndex))),
            color: black,
            weight: FontWeight.w500,
            size: 14,
          ),
          Divider(thickness: 6, color: lightGreyColor),
          selectedSlotIndex==null
              ?
              ReusableText(
                title: "No slots available!",
                size: 20,
                weight: FontWeight.bold,
              )
          :Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(left: 16, right: 16),
              itemCount: slotController.slots.length,
              itemBuilder: (BuildContext context, index) {
                print(slotController.slots.length,);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Radio(
                        activeColor: (selectedSlotIndex==index && slotController.slots[index].limit!="0")?primaryColor:white,
                          fillColor:  MaterialStateProperty.resolveWith ((Set  states) {
                            if (states.contains(MaterialState.disabled)) {
                              return white;
                            }
                            return primaryColor;
                          }),
                          value:index,
                          groupValue: selectedSlotIndex,
                          onChanged: (value) {
                            if(slotController.slots[index].limit!="0"){
                              if(mounted){
                                setState(() {
                                  selectedSlotIndex=index;
                                });
                              }
                            }
                          }),
                      SizedBox(width: 10,),
                      ReusableText(
                        title: "${slotController.slots[index].starttime} - ${slotController.slots[index].endtime}",
                        color: slotController.slots[index].limit=="0"?grey:blackLight,
                        weight: FontWeight.w500,
                        size: 12,
                      ),
                      Spacer(),
                      ReusableText(
                        title: slotController.slots[index].limit=="0"?"Slot Full":"",
                        color: Color(0xFFA41217),
                        weight: FontWeight.w700,
                        size: 12,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(thickness: 2, color: lightGreyColor);
              },
            ),
          ),
          Divider(thickness: 2, color: lightGreyColor),
        ],
      ),
    );
  }
}
