import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import '../../controller/cartController.dart';
import '../../controller/couponsController.dart';
import '../../widget/Commonwidget/reusable_text.dart';

class CouponScreen extends StatelessWidget {
  final String amount;
  CouponScreen({Key? key, required this.amount}) : super(key: key);
  final couponController = Get.put(CouponsController());
  final cartController = Get.put(CartController());


  void getDiscount(){
    if(couponController.couponType=="fixed"){
      cartController.discount.value=couponController.couponValue.value;
    }
    else if(couponController.couponType=="percentage"){
      var offPercentage = int.parse(couponController.couponValue.value.toString());
      cartController.discount.value = double.parse(amount) * offPercentage / 100;
    }
  }
  @override
  Widget build(BuildContext context) {
    couponController.getCoupons();
    return Scaffold(
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
          Flexible(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              width: double.maxFinite,
              color: silver,
              child: couponController.coupons!.isEmpty
                  ? Center(
                      child: ReusableText(
                        title: "Sorry... No Active Coupons Available !!!".tr,
                        weight: FontWeight.w700,
                        size: 20,
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: couponController.coupons!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: white,
                          surfaceTintColor: white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
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
                                                  new CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              new Image.asset(
                                                  'assets/images/logo.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    ReusableText(
                                      title: couponController
                                          .coupons![index]!.instructions,
                                      weight: FontWeight.w700,
                                      size: 14,
                                      maxLine: 3,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ReusableText(
                                      title: couponController
                                          .coupons![index]!.couponcode,
                                      weight: FontWeight.w700,
                                      size: 16,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        var res = await couponController
                                            .validateCoupon(couponController
                                                .coupons![index]!.couponcode
                                                .toString(),amount);
                                        if (res) {
                                          getDiscount();
                                          /*StorageManager.saveData(
                                              StorageManager.keyCouponCode,
                                              couponController
                                                  .coupons![index]!.couponcode);*/
                                        }
                                        //Navigator.pop(context);
                                      },
                                      child: ReusableText(
                                        title: "Apply Coupon".tr,
                                        weight: FontWeight.w700,
                                        color: primaryColor,
                                        size: 16,
                                      ),
                                    ),
                                  ],
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
        ],
      ),
    );
  }
}
