// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/notificationListController.dart';
import 'package:rawabi/widget/headerWidget.dart';
import 'package:rawabi/widget/notificationItemTile.dart';

import '../../utils/colors.dart';
import '../../widget/Commonwidget/reusable_text.dart';

class NotificationListScreen extends StatelessWidget {
  var title;

  NotificationListScreen({super.key, this.title});

  final notificationListController = Get.put(NotificationListController());

  @override
  Widget build(BuildContext context) {
    notificationListController.getNotificationList();
    return Scaffold(
      backgroundColor: silver,
      body: Column(
        children: [
          HeaderWidget(
            onBack: () {},
            title: title,
          ),
          Obx(() => notificationListController.loading.value
              ? SizedBox(
                  height: MediaQuery.of(context).size.height - 280,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                )
              : notificationListController.notifications.isNotEmpty
                  ? ListView.separated(
                      padding: const EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          notificationListController.notifications.length,
                      itemBuilder: (context, index) => NotificationItemTile(
                            notifications:
                                notificationListController.notifications[index],
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
                    ))
        ],
      ),
    );
  }
}
