import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/productFromItemGroupController.dart';
import 'package:rawabi/screen/search/mySearchDelegate.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';
import 'package:rawabi/widget/productItem.dart';

import '../../controller/homeController.dart';
import '../../controller/searchController.dart';
import '../../utils/app_utils.dart';
import '../../utils/commonUtils.dart';
import '../../utils/constants.dart';
import 'notificationListScreen.dart';

// ignore: must_be_immutable
class ProductsFromHomeScreen extends StatelessWidget {
  // String? grp_id;

  ProductsFromHomeScreen({super.key});

  final homeController = Get.put(HomeController());

  final productFromItemGroupController =
      Get.put(ProductFromItemGroupController());

  final searchController = Get.put(SearchResultController());

  /* String _scanBarcode = '';

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }*/
  @override
  Widget build(BuildContext context) {
    // final catID = ModalRoute.of(context)?.settings.arguments;
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    // final products = arguments['products'];
    if (arguments['title'].toString().isNotEmpty)
      productFromItemGroupController.groupName.value = arguments['title'];

    if (productFromItemGroupController.productList.isEmpty)
      productFromItemGroupController.getItemGroupDetails(arguments['grp_id']);

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        // Navigator.of(context).popUntil(ModalRoute.withName('/'));
        Get.delete<ProductFromItemGroupController>();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          const SizedBox(
            height: 60,
          ),
          Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              InkWell(
                child: SizedBox(
                    width: 30,
                    child: SvgPicture.asset("assets/icons/back.svg")),
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.of(context).popUntil(ModalRoute.withName('/'));
                  // Get.delete<ProductController>();
                  /*Get.back();
                      Get.delete<ProductController>();*/
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 50,
                  decoration: const BoxDecoration(
                      color: silver,
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showSearch(
                              context: context,
                              delegate: MySearchDelegate(),
                            );
                          },
                          child: Row(children: [
                            SvgPicture.asset("assets/icons/search.svg"),
                            const SizedBox(
                              width: 5,
                            ),
                            Obx(
                              () => Expanded(
                                child: ReusableText(
                                  title: productFromItemGroupController
                                      .groupName.value,
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                      InkWell(
                          onTap: () async {
                            searchController.searchType.value = "barcode";
                            await searchController
                                .scanBarcodeNormal()
                                .whenComplete(() {
                              searchController.searchProductList.isNotEmpty
                                  ? Navigator.pushNamed(
                                      context,
                                      '/ProductDetailsScreen',
                                      arguments: {
                                        'productID': searchController
                                            .searchProductList[0].productId,
                                      },
                                    )
                                  : CommonUtils()
                                      .messageBox("Unable to identify item!");
                            });
                          },
                          child: SvgPicture.asset("assets/icons/scan.svg"))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () => AppUtils.navigateToPage(NotificationListScreen(
                        title: "Notification",
                      )),
                  child: SvgPicture.asset("assets/icons/notification.svg")),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () {
              return productFromItemGroupController.loading.value
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height - 250,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    )
                  : productFromItemGroupController.productList.isNotEmpty
                      ? Flexible(
                          child: Container(
                            height: double.infinity,
                            color: silver,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: GridView.builder(
                                padding: const EdgeInsets.only(top: 15),
                                shrinkWrap: true,
                                itemCount: productFromItemGroupController
                                    .productList.length,
                                // physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 12,
                                        mainAxisExtent: productItemHeight,
                                        crossAxisSpacing: 12,
                                        childAspectRatio: 0.5),
                                itemBuilder: (_, index) {
                                  return InkWell(
                                      onTap: () async {},
                                      child: ProductItem(
                                        products: productFromItemGroupController
                                            .productList[index],
                                      ));
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
                                  SvgPicture.asset(
                                    "assets/icons/logo.svg",
                                    height: 80,
                                  ),
                                  ReusableText(
                                    title: "No Item Found!!".tr,
                                  )
                                ]),
                          ),
                        );
            },
          ),
        ]),
      ),
    );
  }
}
