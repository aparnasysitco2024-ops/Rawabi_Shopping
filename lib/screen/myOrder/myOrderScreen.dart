import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/myOrdersController.dart';
import '../../utils/colors.dart';
import '../../widget/orderItemTile.dart';

class MyOrderScreen extends StatelessWidget {
  MyOrderScreen({super.key});

  final myOrdersController = Get.put(MyOrdersController());

  @override
  Widget build(BuildContext context) {
    myOrdersController.getMyOrder();
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
            : const SizedBox());
  }
}
