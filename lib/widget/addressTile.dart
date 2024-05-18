import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/model/response/addressListResponse.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/utils/storage_manager.dart';

import '../controller/homeController.dart';
import '../controller/myAddressController.dart';
import 'commonwidget/reusable_text.dart';

// ignore: must_be_immutable
class AddressTile extends StatefulWidget {
  AddressList addressList;

  final myAddressController = Get.put(MyAddressController());
  final homeController = Get.put(HomeController());

  AddressTile({super.key, required this.addressList});

  @override
  State<AddressTile> createState() => _AddressTileState();
}

class _AddressTileState extends State<AddressTile> {
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
                value: widget.myAddressController.defaultAddressId.value ==
                    widget.addressList.addressId,
                onChanged: (bool? value) {
                  setState(() {
                    widget.myAddressController.defaultAddressId.value =
                        widget.addressList.addressId!;
                    StorageManager.saveData(StorageManager.keyDefaultAddressId,
                        widget.addressList.addressId!);
                    StorageManager.saveData(StorageManager.keyDefaultAddress,
                        "${widget.addressList.addressType!}, ${widget.addressList.addressName}, ${widget.addressList.address}");
                    StorageManager.saveData(StorageManager.keyDefaultAddressLat,
                        widget.addressList.lat);
                    StorageManager.saveData(StorageManager.keyDefaultAddressLng,
                        widget.addressList.long);

                    widget.myAddressController.addressListData.refresh();
                    widget.homeController.getStorageData();
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
