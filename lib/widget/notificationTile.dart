import 'package:flutter/cupertino.dart';
import 'package:rawabi/utils/colors.dart';

import 'commonwidget/reusable_text.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.maxFinite,
      color: white,
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReusableText(
            title: "Mid-week deals to delight you",
            color: blue,
            size: 10,
            weight: FontWeight.w600,
          ),
          ReusableText(
            title: "Get up to 55% off your favorite's picks from fresh food.\n"
                "pantry essentials, grocery & more..",
            size: 10,
            weight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
