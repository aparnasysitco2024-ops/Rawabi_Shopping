import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/search/mySearchDelegate.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';
import '../controller/categoryController.dart';
import '../controller/searchController.dart';

// ignore: must_be_immutable
class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final categoryController = Get.put(CategoryController());
  final searchController = Get.put(SearchResutController());
  /*String _scanBarcode = '';

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
    categoryController.getCategory();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ReusableText(
                title: "Offers".tr, size: 18, weight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
            height: 42,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: const BoxDecoration(
                color: silver,
                borderRadius: BorderRadius.all(Radius.circular(7))),
            child: Row(children: [
              InkWell(
                onTap: (){
                  showSearch(
                    context: context,
                    delegate: MySearchDelegate(),
                  );},
                /*onTap: () async {
                            searchController.searchType.value = "word";
                            AppUtils.navigateToPage( MySearchDelegate());
                          },*/
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/search.svg"),
                    const SizedBox(
                      width: 5,
                    ),
                     ReusableText(
                      title: "Search".tr,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                  onTap: () async {
                    searchController.searchType.value = "barcode";
                    searchController.scanBarcodeNormal();
                    searchController.getProductsByBarcodeSearch();
                    Navigator.pushNamed(
                      context,
                      '/BarcodeResultScreen',
                    );
                    // AppUtils.navigateToPage(const BarcodeResultScreen());
                  },
                  child: SvgPicture.asset("assets/icons/scan.svg"))
            ]),
          ),
          Flexible(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/logo.svg"),
                     ReusableText(
                      title: "No offer available !!".tr,
                    )
                  ]),
            ),
          ),

        ],
      ),
    );
  }
}
