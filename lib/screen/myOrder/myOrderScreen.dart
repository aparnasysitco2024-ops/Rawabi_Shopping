import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controller/myOrdersController.dart';
import '../../utils/colors.dart';
import '../../widget/commonWidget/reusable_text.dart';
import '../../widget/orderItemTile.dart';

// ignore: must_be_immutable
class MyOrderScreen extends StatelessWidget {
  var status;

  MyOrderScreen({super.key, this.status});

  final myOrdersController = Get.put(MyOrdersController());

  @override
  Widget build(BuildContext context) {
    myOrdersController.getMyOrder(status);
    return Obx(() => myOrdersController.loading.value
        ? SizedBox(
            height: MediaQuery.of(context).size.height - 280,
            child: const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          )
        : myOrdersController.myOrderList.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: myOrdersController.myOrderList.length,
                itemBuilder: (context, index) => OrderItemTile(
                      myOrder: myOrdersController.myOrderList[index],
                    ),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                      height: 5,
                    ))
            : SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/logo.svg"),
                      ReusableText(
                        title: "No orders!!".tr,
                      )
                    ]),
              ));
  }
}
