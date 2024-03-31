import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/homeController.dart';
import '../../controller/storePickupController.dart';
import '../../utils/app_utils.dart';
import '../../utils/colors.dart';
import '../../utils/storage_manager.dart';
import '../../widget/storeTile.dart';
import '../navigator/bottomNavBar.dart';

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
                  onTap: () {
                    StorageManager.saveData(StorageManager.keyStoreID,
                        storePickupController.storeList[index].storeId);
                    StorageManager.saveData(StorageManager.keyStoreAddress,
                        storePickupController.storeList[index].storeName);
                    StorageManager.saveData(StorageManager.keyIsPickup, true);

                    if (Get.isRegistered<HomeController>()) {
                      final homeController = Get.put(HomeController());
                      homeController.storeAddress.value = storePickupController
                          .storeList[index].storeName
                          .toString();
                      homeController.isPickup.value = true;
                      homeController.getHomeData();
                      Navigator.pop(context);
                    } else {
                      AppUtils.navigateToPageRemoveUntil(BottomNavBar());
                    }
                  },
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
