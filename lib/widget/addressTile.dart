import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/model/addressListResponse.dart';
import 'package:rawabi/utils/colors.dart';

import '../controller/myAddressController.dart';
import 'commonwidget/reusable_text.dart';

// ignore: must_be_immutable
class AddressTile extends StatefulWidget {
  AddressList addressList;
  final myAddressController = Get.put(MyAddressController());

  AddressTile({super.key, required this.addressList});

  @override
  State<AddressTile> createState() => _AddressTileState();
}

class _AddressTileState extends State<AddressTile> {
  bool defaultSelection = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableText(
                title: widget.addressList.addressType,
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
            title:
                "${widget.addressList.addressName!}\n${widget.addressList.address}\n${widget.addressList.zone}\n${widget.addressList.phone}",
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
              const Spacer(),
              InkWell(
                onTap: () => widget.myAddressController
                    .deleteAddress(widget.addressList.addressId),
                child: ReusableText(
                  title: "Delete".tr,
                  size: 10,
                  weight: FontWeight.w600,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
