import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:rawabi/controller/flayerListController.dart';
import 'package:rawabi/screen/home/pdfViewScreen.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/widget/headerWidget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
            title: "Flayer",
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
                        child: SfPdfViewer.network(
                          flayerListController.flayersList[index].file
                              .toString(),
                          onTap: (details) {
                            AppUtils.navigateToPage(PdfViewScreen(
                              file: flayerListController.flayersList[index].file
                                  .toString(),
                            ));
                          },
                        ),
                        // child: PdfViewer.openFutureFile(
                        //   () async => (await DefaultCacheManager()
                        //           .getSingleFile(flayerListController
                        //               .flayersList[index].file
                        //               .toString()))
                        //       .path,
                        //   // viewerController: controller,
                        //   params: const PdfViewerParams(padding: 0),
                        // ),
                      )
                      // Container(
                      //   width: double.maxFinite,
                      //   decoration: BoxDecoration(
                      //     color: white,
                      //     borderRadius: BorderRadius.circular(4),
                      //   ),
                      //   margin: const EdgeInsets.symmetric(
                      //       horizontal: 14, vertical: 2),
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 10, vertical: 5),
                      //   child: PdfThumbnail.fromFile("https://dev.rawabihypermarket.com/b2c/pdf/1.pdf",
                      //     // flayerListController.flayersList[index].file
                      //     //     .toString(),
                      //     currentPage: 0,
                      //   ),
                      // ),
                      ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      mainAxisExtent: productItemHeight,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.5),
                ))
        ],
      ),
    );
  }
}
