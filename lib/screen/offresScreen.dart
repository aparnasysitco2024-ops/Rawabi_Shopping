import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/homeController.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../controller/offerListController.dart';
import '../widget/itemsWidgetOffer.dart';
import '../widget/offerCategoryItemTile.dart';

// ignore: must_be_immutable
class OffersScreen extends StatelessWidget {
  OffersScreen({super.key});

  final offerListController = Get.put(OfferListController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    offerListController.getOffers();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ReusableText(
                    title: homeController.languageParam.value.offers,
                    size: 18,
                    weight: FontWeight.bold),
              ),
              !offerListController.loading.value
                  ? offerListController.offerList.isNotEmpty
                      ? Expanded(
                          child: Container(
                            color: silver,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      margin: const EdgeInsets.all(10),
                                      //Main category
                                      child: MainCategory()),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
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
                                    title: "No offers!!".tr,
                                  )
                                ]),
                          ),
                        )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height - 280,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    ),
            ],
          )),
    );
  }
}

class MainCategory extends StatelessWidget {
  final offerListController = Get.put(OfferListController());

  MainCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ExpandedTileList.builder(
          padding: const EdgeInsets.all(0),
          itemCount: offerListController.offerList.length,
          maxOpened: 1,
          itemBuilder: (context, index, controller) {
            return ExpandedTile(
                theme: const ExpandedTileThemeData(
                  headerColor: Colors.white,
                  // headerRadius: 8,
                  headerPadding: EdgeInsets.all(5),
                  leadingPadding: EdgeInsets.all(0),
                  // headerSplashColor: lightPink,
                  // contentBackgroundColor: Colors.white,
                  contentPadding: EdgeInsets.only(bottom: 5),
                  // contentRadius: 8
                ),
                controller: index == 2
                    ? controller.copyWith(isExpanded: true)
                    : controller,
                title: OfferCategoryItemTile(
                    category: offerListController.offerList[index]),
                content: ItemsWidgetOffer(
                  category: offerListController.offerList[index],
                  products: offerListController.offerList[index].products,
                ));
          },
        ));
  }
}

void navigation(BuildContext context, String catId, String subCatId,
    String subSubCatId, String subSubSubCatId) {
  Navigator.pushNamed(
    context,
    '/ProductsByCategory',
    arguments: {
      'catId': catId,
      'subCatId': subCatId,
      'subSubCatId': subSubCatId,
      'subSubSubCatId': subSubSubCatId
    },
  );
}
