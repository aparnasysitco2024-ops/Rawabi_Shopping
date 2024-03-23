import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/wishlistGridItem.dart';

import '../utils/colors.dart';
import '../widget/commonwidget/reusable_text.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: silver,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 110,
                color: white,
                width: double.maxFinite,
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Divider(
                      thickness: 1,
                      color: lightGreyColor,
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
                              title: "Wishlist".tr,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 6,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.5),
                      itemBuilder: (_, index) {
                        return InkWell(
                            onTap: () async {},
                            child: WishlistGridItem(
                              title: index == 0
                                  ? "Best seller"
                                  : index == 1
                                      ? "35% off"
                                      : null,
                              image: index == 0
                                  ? "assets/images/pasta.png"
                                  : index == 1
                                      ? "assets/images/pizza.png"
                                      : index == 2
                                          ? "assets/images/ajmiPathiri.png"
                                          : "assets/images/bakingsoda.png",
                            ));
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
