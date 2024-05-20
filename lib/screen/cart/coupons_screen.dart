import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import '../../controller/couponsController.dart';
import '../../utils/storage_manager.dart';
import '../../widget/Commonwidget/reusable_text.dart';

class ApplyCoupons extends StatelessWidget {
  ApplyCoupons({Key? key}) : super(key: key);
  final couponController = Get.put(CouponsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              alignment: Alignment.center,
              //padding: EdgeInsets.all(18),

              // width: double.maxFinite,
              height: 400,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: white,
              ),
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
                                        StorageManager.saveData(
                                            StorageManager.keyCouponCode,
                                            couponController
                                                .coupons![index]!.couponcode);
                                        Navigator.pop(context);
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
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 20, top: 10),
              color: Colors.white.withAlpha(150),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 36,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
