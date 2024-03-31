import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewScreen extends StatelessWidget {
  const PdfViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfPdfViewer.network(
            'https://dev.rawabihypermarket.com/b2c/pdf/1.pdf'));
  }
  }
