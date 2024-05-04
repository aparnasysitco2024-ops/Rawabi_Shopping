import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/navigator/bottomNavBar.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/widget/commonwidget/reusable_button1.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../utils/colors.dart';
import 'myOrder/orderDetailsScreen.dart';

// ignore: must_be_immutable
class OrderPlacedScreen extends StatelessWidget {
  var orderId;

  OrderPlacedScreen({super.key, this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                SvgPicture.asset(
                  "assets/icons/orderPlaced.svg",
                  height: 150,
                ),
                const SizedBox(
                  height: 30,
                ),
                ReusableText(
                  title: "Order Placed Successfully".tr,
                  size: 20,
                  weight: FontWeight.bold,
                  fontFamily: 'DMSans',
                ),
                const SizedBox(
                  height: 10,
                ),
                ReusableText(
                  textAlign: TextAlign.center,
                  size: 12,
                  color: darkGrey,
                  title:
                      "Thanks for your shopping, your order has placed successfully, please continue your orders"
                          .tr,
                ),
                const Spacer(),
                ReusableButton1(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  title: "Continue shopping".tr,
                  onPressed: () =>
                      AppUtils.navigateToPageRemoveUntil(BottomNavBar()),
                ),
                const SizedBox(
                  height: 10,
                ),
                ReusableButton1(
                  onPressed: () {
                    AppUtils.navigateToPageReplace(OrderDetailsScreen(
                      orderid: orderId,
                    ));
                  },
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.white,
                  txtColor: darkGrey,
                  title: "Track order".tr,
                ),
                const SizedBox(
                  height: 30,
                ),
              ]),
        ),
      ),
    );
  }
}
