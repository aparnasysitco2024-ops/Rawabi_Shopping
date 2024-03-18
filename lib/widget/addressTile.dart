import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';

import 'commonwidget/reusable_text.dart';

class AddressTile extends StatefulWidget {
  const AddressTile({super.key});

  @override
  State<AddressTile> createState() => _AddressTileState();
}

class _AddressTileState extends State<AddressTile> {
  bool defaultSelection=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116,
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 20,top: 0,right: 20,bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableText(
                title: "Home".tr,
                size: 12,
                weight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              ReusableText(
                title: "Edit".tr,
                size: 10,
                weight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          ReusableText(
            title: "Ilyas Doodler, A 38, A wakra Shopping Complex, Al wakra, Doha,Qatar.".tr,
            size: 12,
            weight: FontWeight.w400,
            textAlign: TextAlign.left,
          ),
          Row(
            children: [
              Checkbox(
                checkColor: white,
                activeColor: primaryColor,

                value: defaultSelection,
                onChanged: (bool? value) {
                  setState(() {
                    defaultSelection = value!;
                  });
                },
              ),
              ReusableText(
                title: "Set as default".tr,
                size: 10,
                weight: FontWeight.w600,
                textAlign: TextAlign.left,
              ),
              Spacer(),
              ReusableText(
                title: "Delete".tr,
                size: 10,
                weight: FontWeight.w600,
                textAlign: TextAlign.left,
              ),
            ],
          )
        ],
      ),
    );
  }
}
