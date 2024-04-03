import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../utils/colors.dart';
import '../../widget/commonWidget/reusable_text.dart';

class PdfViewScreen extends StatelessWidget {
  const PdfViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          Container(
            padding: const EdgeInsets.all(0),
            color: white,
            width: double.maxFinite,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: double.maxFinite,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Stack(
                    children: [
                      Center(
                        child: ReusableText(
                          title: "Flayer".tr,
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
                const Divider(
                  thickness: 1,
                  color: lightGreyColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: SfPdfViewer.network(
                'https://dev.rawabihypermarket.com/b2c/pdf/1.pdf'),
          )
        ],)
        );
  }
}
