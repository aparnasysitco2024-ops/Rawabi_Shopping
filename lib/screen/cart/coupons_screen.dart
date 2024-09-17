import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/utils/commonUtils.dart';
import 'package:rawabi/widget/commonWidget/reusable_button.dart';
import 'package:rawabi/widget/commonWidget/reusable_button1.dart';
import 'package:rawabi/widget/commonWidget/reusable_textformfieldbox.dart';

import '../../controller/cartController.dart';
import '../../controller/couponsController.dart';
import '../../widget/Commonwidget/reusable_text.dart';

// ignore: must_be_immutable
class CouponScreen extends StatelessWidget {
  final String amount;
  var couponID = 0;

  CouponScreen({Key? key, required this.amount}) : super(key: key);
  final couponController = Get.put(CouponsController());
  final cartController = Get.put(CartController());

  void getDiscount() {
    if (couponController.couponType == "fixed") {
      cartController.discount.value = couponController.couponValue.value;
    } else if (couponController.couponType == "percentage") {
      var offPercentage =
          int.parse(couponController.couponValue.value.toString());
      cartController.discount.value =
          double.parse(amount) * offPercentage / 100;
    }
    cartController.couponText.value = couponController.codeController.text;
    print("-----------4-------------"  );
    cartController.setTotal();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    couponController.getCoupons();
    return PopScope(
      onPopInvoked: (didPop) {
        Get.delete<CouponsController>();
      },
      child: Scaffold(
        backgroundColor: white,
        body: Column(
          children: [
            Container(
              color: white,
              padding: const EdgeInsets.only(bottom: 10),
              width: double.maxFinite,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  // const Divider(
                  //   thickness: 1,
                  //   color: lightGreyColor,
                  // ),
                  Container(
                    height: 40,
                    width: double.maxFinite,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Stack(
                      children: [
                        Center(
                          child: ReusableText(
                            title: "Coupons",
                            size: 18,
                            weight: FontWeight.bold,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 0,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: blackLight,
                              size: 24,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Flexible(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  width: double.maxFinite,
                  color: silver,
                  child: couponController.coupons!.isEmpty
                      ? Center(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/icons/logo.svg",height: 80,),
                                  ReusableText(
                                    title: "No Coupon available".tr,
                                  )
                                ]),
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.all(0),
                          physics: const BouncingScrollPhysics(),
                          itemCount: couponController.coupons!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: white,
                              surfaceTintColor: white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: silver),
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: couponController
                                              .coupons![index]!.image
                                              .toString(),
                                          placeholder: (context, url) => Center(
                                              child:
                                                  new CircularProgressIndicator(
                                            color: primaryColor,
                                          )),
                                          errorWidget: (context, url, error) =>
                                              new Image.asset(
                                                  'assets/images/logo.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        ReusableText(
                                          title: couponController
                                              .coupons![index]!.couponcode,
                                          weight: FontWeight.w700,
                                          size: 14,
                                        ),
                                        ReusableText(
                                          title: couponController
                                              .coupons![index]!.instructions,
                                          weight: FontWeight.w700,
                                          size: 10,
                                          maxLine: 3,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 120,
                                      height: 30,
                                      child: ReusableButton1(
                                        onPressed: () async {
                                          couponController.codeController.text =
                                              couponController
                                                  .coupons![index]!.couponcode
                                                  .toString();
                                          // var res = await couponController
                                          //     .validateCoupon(
                                          //         couponController
                                          //             .coupons![index]!
                                          //             .couponcode
                                          //             .toString(),
                                          //         amount);
                                          // if (res) {
                                          //   getDiscount();
                                          // }
                                        },
                                        title: "Apply Coupon".tr,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 5,
                            );
                          },
                        ),
                ),
              ),
            ),
            Container(
              height: 150,
              width: double.maxFinite,
              color: white,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ReusableTextFormBox(
                    controller: couponController.codeController,
                    borderColor: primaryColor,
                    hintText: "Coupon Code",
                    borderRadius: 3.0,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ReusableButton(
                    onTap: () async {
                      if (couponController.codeController.text.isEmpty) {
                        CommonUtils().messageBox("Please enter coupon code!");
                      } else {
                        var res = await couponController.validateCoupon(
                            couponController.codeController.text, amount);
                        if (res) {
                          getDiscount();
                        }
                      }
                    },
                    title: "Apply Coupon",
                    borderRadius: 3.0,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
