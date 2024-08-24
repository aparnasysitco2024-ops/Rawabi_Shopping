import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/wishlistController.dart';
import 'package:rawabi/widget/productItem.dart';

import '../controller/homeController.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../widget/commonwidget/reusable_text.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});

  final wishListController = Get.put(WishListController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    wishListController.getWishList();
    return PopScope(
      onPopInvoked: (didPop) => Get.delete<WishListController>(),
      child: Obx(() => Scaffold(
          backgroundColor: silver,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: white,
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 45,
                      ),
                      Container(
                        height: 40,
                        width: double.maxFinite,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Stack(
                          children: [
                            Center(
                              child: ReusableText(
                                title: homeController.languageParam.value.wishlist,
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
                                  // Get.delete<WishListController>();
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
                wishListController.loading.value
                    ? const Flexible(
                        child: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          ),
                        ),
                      )
                    : wishListController.productList.isNotEmpty
                        ? Flexible(
                            child: Container(
                              height: double.infinity,
                              color: silver,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: GridView.builder(
                                  padding: const EdgeInsets.only(top: 15),
                                  shrinkWrap: true,
                                  itemCount:
                                      wishListController.productList.length,
                                  // physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 12,
                                          mainAxisExtent: productItemHeight,
                                          crossAxisSpacing: 12,
                                          childAspectRatio: 0.5),
                                  itemBuilder: (_, index) {
                                    return ProductItem(
                                      products:
                                          wishListController.productList[index],
                                    );
                                  }),
                            ),
                          )
                        : Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/icons/logo.svg",height: 80,),
                                     ReusableText(
                                      title: "No Item Found!!".tr,
                                    )
                                  ]),
                            ),
                          ),
              ],
            ),
          ))),
    );
  }
}
