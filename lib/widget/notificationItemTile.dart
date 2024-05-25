import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../model/response/notificationListResponse.dart';

// ignore: must_be_immutable
class NotificationItemTile extends StatelessWidget {
  Notifications notifications;

  NotificationItemTile({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // AppUtils.navigateToPage(OrderDetailsScreen(
        //   orderid: myOrder.orderid,
        // ));
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
            //alignment: Alignment.center,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(
                //     width: 60,
                //     child: Image.asset("assets/images/ajmi.png")),
                // const SizedBox(
                //   width: 5,
                // ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        title: "${notifications.title}",
                        size: 13,
                        weight: FontWeight.bold,
                        color: darkGrey,
                      ),
                      Html(data: notifications.message),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 0.1,
          )
        ],
      ),
    );
  }
}
