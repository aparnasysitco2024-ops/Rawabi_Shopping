import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/homeController.dart';
import 'package:rawabi/screen/account/ourStoreScreen.dart';
import 'package:rawabi/screen/address/myAddressesScreen.dart';
import 'package:rawabi/screen/emptyScreen.dart';
import 'package:rawabi/screen/home/flayerListScreen.dart';
import 'package:rawabi/screen/loginScreen.dart';
import 'package:rawabi/screen/myOrder/myOrdersTabScreen.dart';
import 'package:rawabi/screen/myProfileScreen.dart';
import 'package:rawabi/screen/notificationsScreen.dart';
import 'package:rawabi/screen/splashScreen.dart';
import 'package:rawabi/screen/webViewScreen.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/utils/storage_manager.dart';
import 'package:rawabi/widget/commonwidget/profile_tile.dart';
import 'package:rawabi/widget/commonwidget/square_card.dart';

import '../../widget/commonwidget/reusable_text.dart';
import 'languageScreen.dart';

class AccountScreen extends StatelessWidget {
  final GlobalKey globalKey;
  final VoidCallback onOffersSelected;
  final VoidCallback onCartSelected;
  AccountScreen({super.key, required this.globalKey,required this.onOffersSelected, required this.onCartSelected });

  final homeController = Get.put(HomeController());

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
                    child: SquareCard(
                        image: "assets/icons/checklist.svg",
                        title: "My Orders".tr),
                  ),
                  GestureDetector(
                    onTap: () {
                      AppUtils.navigateToPage(EmptyScreen(
                        title: "Ahlan Rewards".tr,
                      ));
                    },
                    child: Container(
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
                  ),
                  GestureDetector(
                    onTap: () {
                      onOffersSelected();
                      // globalKey.currentWidget.;  //<-This is the line where use
                    },
                    child: SquareCard(
                        image: "assets/icons/offers.svg",
                        title: "My Offers".tr),
                  ),
                  GestureDetector(
                    onTap: () {
                      onCartSelected();
                      // globalKey.currentWidget.;  //<-This is the line where use
                    },
                    child: SquareCard(
                        image: "assets/icons/mycart.svg", title: "My Cart".tr),
                  ),
                ],
              )),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 96,
                    color: white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
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
                                    colors: [
                                      primaryColor,
                                      Colors.transparent,
                                      pink
                                    ]),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 24,
                          top: 14,
                          right: 24,
                          child: InkWell(
                            onTap: () =>
                                AppUtils.navigateToPage(FlayerListScreen()),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        homeController.userID == '0'
                            ? SizedBox()
                            : Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // AppUtils.navigateToPage(const DeliveryModeScreen());
                                    },
                                    child: ProfileTile(
                                        image: "assets/icons/eReceipt.svg",
                                        title: "E-Receipt".tr),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                ],
                              ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/WishlistScreen');
                            //AppUtils.navigateToPage(WishlistScreen());
                          },
                          child: ProfileTile(
                              image: "assets/icons/love.svg",
                              title: "Wishlist".tr),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        homeController.userID == '0'
                            ? SizedBox()
                            : Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        AppUtils.navigateToPage(
                                            MyAddressesScreen());
                                      },
                                      child: ProfileTile(
                                          image: "assets/icons/location.svg",
                                          title: "Address".tr)),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                ],
                              ),
                        ProfileTile(
                            onPressed: () =>
                                AppUtils.navigateToPage(LanguageScreen()),
                            image: "assets/icons/globe.svg",
                            title: "Language".tr),
                        const Divider(
                          thickness: 1,
                        ),
                        homeController.userID == '0'
                            ? SizedBox()
                            : Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      AppUtils.navigateToPage(
                                          MyProfileScreen());
                                    },
                                    child: ProfileTile(
                                        image: "assets/icons/user.svg",
                                        title: "My Profile".tr),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  ProfileTile(
                                      image: "assets/icons/gift-card.svg",
                                      title: "Gift Cards".tr),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                ],
                              ),
                        InkWell(
                          onTap: () {
                            AppUtils.navigateToPage(NotificationsScreen());
                          },
                          child: ProfileTile(
                              image: "assets/icons/notification2.svg",
                              title: "Notifications".tr),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        ProfileTile(
                            onPressed: () =>
                                AppUtils.navigateToPage(OurStoreScreen()),
                            image: "assets/icons/My-shops.svg",
                            title: "Our Store".tr),
                        const Divider(
                          thickness: 1,
                        ),
                        homeController.userID == '0'
                            ? SizedBox()
                            : Column(
                                children: [
                                  ProfileTile(
                                      image: "assets/icons/returns.svg",
                                      title: "My Returns".tr),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                ],
                              ),
                        ProfileTile(
                            image: "assets/icons/feedback.svg",
                            title: "Feedback".tr),
                        const Divider(
                          thickness: 1,
                        ),
                        ProfileTile(
                            onPressed: () => AppUtils.navigateToPage(WebViewScreen(
                                url:
                                    "https://dev.rawabihypermarket.com/b2c/other/faq.php",
                                title: "Help")),
                            image: "assets/icons/Help.svg",
                            title: "Help".tr),
                        const Divider(
                          thickness: 1,
                        ),
                        ProfileTile(
                            onPressed: () => AppUtils.navigateToPage(WebViewScreen(
                                url:
                                    "https://dev.rawabihypermarket.com/b2c/other/about.php",
                                title: "About Us")),
                            image: "assets/icons/information.svg",
                            title: "About Us".tr),
                        const Divider(
                          thickness: 1,
                        ),
                        ProfileTile(
                          onPressed: () => AppUtils.navigateToPage(WebViewScreen(
                              url:
                                  "https://dev.rawabihypermarket.com/b2c/other/terms.php",
                              title: "Terms & Conditions")),
                          image: "assets/icons/contract.svg",
                          title: "Terms & Conditions".tr,
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        ProfileTile(
                            onPressed: () => AppUtils.navigateToPage(WebViewScreen(
                                url:
                                    "https://dev.rawabihypermarket.com/b2c/other/return.php",
                                title: "Return Policy")),
                            image: "assets/icons/turn-back.svg",
                            title: "Return Policy".tr),
                        const Divider(
                          thickness: 1,
                        ),
                        ProfileTile(
                            onPressed: () => AppUtils.navigateToPage(WebViewScreen(
                                url:
                                    "https://dev.rawabihypermarket.com/b2c/other/service.php",
                                title: "Service & Warranty")),
                            image: "assets/icons/verified2.svg",
                            title: "Service & Warranty".tr),
                        const Divider(
                          thickness: 1,
                        ),
                        homeController.userID == '0'
                            ? InkWell(
                                onTap: () {
                                  AppUtils.navigateToPage(LoginScreen());
                                },
                                child: ProfileTile(
                                    image: "assets/icons/signin.svg",
                                    title: "Sign In".tr),
                              )
                            : InkWell(
                                onTap: () async {
                                  await showDialog(
                                    context: Get.context!,
                                    builder: (context) => AlertDialog(
                                      title: Text("Rawabi Shopping".tr),
                                      content: Text(
                                          'Are you sure you would like to Sign out ?'
                                              .tr),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Text('No'.tr),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            StorageManager.clearData();
                                            Get.deleteAll();
                                            AppUtils.navigateToPageRemoveUntil(
                                                const SplashScreen());
                                          }, // <-- SEE HERE
                                          child: Text('Yes'.tr),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: ProfileTile(
                                    image: "assets/icons/exit.svg",
                                    title: "Sign Out".tr),
                              ),
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
