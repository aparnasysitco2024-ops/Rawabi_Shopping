import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/flayerListController.dart';
import 'package:rawabi/screen/home/pdfViewScreen.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/widget/commonWidget/networkImageWidget.dart';
import 'package:rawabi/widget/headerWidget.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class FlayerListScreen extends StatelessWidget {
  FlayerListScreen({super.key});

  final flayerListController = Get.put(FlayerListController());

  @override
  Widget build(BuildContext context) {
    flayerListController.getFlayers();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          HeaderWidget(
            title: "Flyer".tr,
            onBack: () {},
          ),
          Obx(() => flayerListController.loading.value
              ? SizedBox(
                  height: MediaQuery.of(context).size.height - 280,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: flayerListController.flayersList.length,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        AppUtils.navigateToPage(PdfViewScreen(
                          file: flayerListController.flayersList[index].file
                              .toString(),
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            AppUtils.navigateToPage(PdfViewScreen(
                              file: flayerListController.flayersList[index].file
                                  .toString(),
                            ));
                          },
                          child: NetworkImageWidget(
                            image:
                                flayerListController.flayersList[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      mainAxisExtent: productItemHeight,
                      crossAxisSpacing: 0,
                      childAspectRatio: 0.5),
                ))
        ],
      ),
    );
  }
}
