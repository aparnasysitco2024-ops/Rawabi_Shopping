
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../controller/homeController.dart';
import '../../utils/colors.dart';
import '../../widget/commonWidget/reusable_text.dart';

// ignore: must_be_immutable
class PdfViewScreen extends StatefulWidget {
  String file;
  PdfViewScreen({super.key, required this.file});

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  final homeController = Get.put(HomeController());

  bool isDownloading = false;
  double downloadProgress = 0.0;

  Future<void> _downloadFile() async {
    if (isDownloading) return;

    setState(() {
      isDownloading = true;
      downloadProgress = 0.0;
    });

    try {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = widget.file.split('/').last.split('?').first;
      final savePath = '${dir.path}/$fileName';

      await Dio().download(
        widget.file,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              downloadProgress = received / total;
            });
          }
        },
      );

      setState(() {
        isDownloading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('File saved successfully'),
            action: SnackBarAction(
              label: 'OPEN',
              onPressed: () => OpenFilex.open(savePath),
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        isDownloading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Download failed. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
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
                            title: homeController.languageParam.value.flayer,
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
                        ),
                        Positioned(
                          right: 20,
                          top: 0,
                          child: InkWell(
                            onTap: isDownloading ? null : _downloadFile,
                            child: isDownloading
                                ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                value: downloadProgress > 0
                                    ? downloadProgress
                                    : null,
                              ),
                            )
                                : const Icon(
                              Icons.download_rounded,
                              color: blackLight,
                              size: 24,
                            ),
                          ),
                        ),
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
              child: SfPdfViewer.network(widget.file),
            )
          ],
        ));
  }
}