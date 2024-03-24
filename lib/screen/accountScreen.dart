import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/filtersScreen.dart';
import 'package:rawabi/screen/address/myAddressesScreen.dart';
import 'package:rawabi/screen/myOrder/myOrdersTabScreen.dart';
import 'package:rawabi/screen/myProfileScreen.dart';
import 'package:rawabi/screen/notificationsScreen.dart';
import 'package:rawabi/screen/wishlistScreen.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/profile_tile.dart';
import 'package:rawabi/widget/commonwidget/square_card.dart';

import '../widget/commonwidget/reusable_text.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: silver,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ReusableText(
                title: "Profile".tr, size: 18, weight: FontWeight.bold),
          ),
          Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: 113,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [blue, lightBlue, pink]),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      AppUtils.navigateToPage(const MyOrdersTabScreen());
                    },
                    child: const SquareCard(
                        image: "assets/icons/checklist.svg",
                        title: "My Orders"),
                  ),
                  Container(
                    height: 83,
                    width: 83,
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: grey, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/ahlan.png",
                          fit: BoxFit.fill,
                          width: 28,
                          height: 28,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReusableText(
                            title: "Ahlan Rewards".tr,
                            size: 10,
                            weight: FontWeight.w500),
                      ],
                    ),
                  ),
                  /*SquareCard(
                      image: "assets/icons/ahlan2.svg",
                      title: "Ahlan Rewards"),*/
                  const SquareCard(
                      image: "assets/icons/offers.svg", title: "My Offers"),
                  const SquareCard(
                      image: "assets/icons/mycart.svg", title: "My Cart"),
                ],
              )),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 96,
                    color: white,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFF142158),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          child: Opacity(
                            opacity: 0.32,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [primaryColor, Colors.transparent, pink]),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 24,
                          top: 14,
                          right: 24,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/images/promotion.png",
                                fit: BoxFit.fill,
                                width: 72,
                                height: 52,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ReusableText(
                                      title: "our latest deals here".tr,
                                      size: 14,
                                      color: white,
                                      weight: FontWeight.bold),
                                  ReusableText(
                                      title: "20 - 28 dec".tr,
                                      size: 10,
                                      color: white,
                                      weight: FontWeight.w600),
                                ],
                              ),
                              Container(
                                height: 22,
                                width: 48,
                                margin: const EdgeInsets.only(right: 16),
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                    color: primaryColor,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                                child: Center(
                                  child: ReusableText(
                                    title: "View".tr,
                                    size: 10,
                                    color: white,
                                    weight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // AppUtils.navigateToPage(const DeliveryModeScreen());
                          },
                          child: const ProfileTile(
                              image: "assets/icons/eReceipt.svg", title: "E-Receipt"),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        InkWell(
                          onTap: () {
                            AppUtils.navigateToPage(const WishlistScreen());
                          },
                          child: const ProfileTile(
                              image: "assets/icons/love.svg", title: "Wishlist"),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        InkWell(
                            onTap: () {
                              AppUtils.navigateToPage(MyAddressesScreen());
                            },
                            child: const ProfileTile(
                                image: "assets/icons/location.svg",
                                title: "Address")),
                        const Divider(
                          thickness: 1,
                        ),
                        const ProfileTile(
                            image: "assets/icons/globe.svg", title: "Language"),
                        const Divider(
                          thickness: 1,
                        ),
                        InkWell(
                          onTap: () {
                            AppUtils.navigateToPage(const MyProfileScreen());
                          },
                          child: const ProfileTile(
                              image: "assets/icons/user.svg", title: "My Profile"),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        const ProfileTile(
                            image: "assets/icons/gift-card.svg", title: "Gift Cards"),
                        const Divider(
                          thickness: 1,
                        ),
                        InkWell(
                          onTap: () {
                            AppUtils.navigateToPage( NotificationsScreen());
                          },
                          child: const ProfileTile(
                              image: "assets/icons/notification2.svg",
                              title: "Notifications"),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        const ProfileTile(
                            image: "assets/icons/My-shops.svg", title: "Our Store"),
                        const Divider(
                          thickness: 1,
                        ),
                        const ProfileTile(
                            image: "assets/icons/returns.svg", title: "My Returns"),
                        const Divider(
                          thickness: 1,
                        ),
                        const ProfileTile(
                            image: "assets/icons/feedback.svg", title: "Feedback"),
                        const Divider(
                          thickness: 1,
                        ),
                        InkWell(
                          onTap: () {
                            AppUtils.navigateToPage(const FiltersScreen());
                          },
                          child: const ProfileTile(
                              image: "assets/icons/Help.svg", title: "Help"),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        const ProfileTile(
                            image: "assets/icons/information.svg", title: "About Us"),
                        const Divider(
                          thickness: 1,
                        ),
                        const ProfileTile(
                            image: "assets/icons/contract.svg",
                            title: "Terms & Conditions"),
                        const Divider(
                          thickness: 1,
                        ),
                        const ProfileTile(
                            image: "assets/icons/turn-back.svg",
                            title: "Return Policy"),
                        const Divider(
                          thickness: 1,
                        ),
                        const ProfileTile(
                            image: "assets/icons/verified2.svg",
                            title: "Service & Warranty"),
                        const Divider(
                          thickness: 1,
                        ),
                        const ProfileTile(
                            image: "assets/icons/exit.svg", title: "Sign Out"),

                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
