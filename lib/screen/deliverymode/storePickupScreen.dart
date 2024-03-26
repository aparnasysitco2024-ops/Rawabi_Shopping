import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../controller/storePickupController.dart';
import '../../utils/colors.dart';
import '../../widget/storeTile.dart';

class StorePickupScreen extends StatelessWidget {
  StorePickupScreen({super.key});

  final storePickupController = Get.put(StorePickupController());

  @override
  Widget build(BuildContext context) {
    storePickupController.getStore();
    return Obx(() => storePickupController.loading.value
        ? SizedBox(
            height: MediaQuery.of(context).size.height - 280,
            child: const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: storePickupController.storeList.length,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {},
                  child: StoreTile(
                      title: storePickupController.storeList[index].storeName
                          .toString()),
                ),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
                  height: 5,
                )));
  }
}
