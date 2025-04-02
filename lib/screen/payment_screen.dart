import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controller/cartController.dart';
import '../model/response/checkoutResponse.dart';
import '../utils/app_utils.dart';
import '../utils/colors.dart';
import '../utils/commonUtils.dart';
import '../widget/Commonwidget/reusable_text.dart';
import 'orderPlacedScreen.dart';

// ignore: must_be_immutable
class PaymentScreen extends StatefulWidget {
  String url, confirmUrl;
  bool isPreOrder;
  final cartController = Get.put(CartController());

  PaymentScreen({super.key, required this.url, required this.confirmUrl,required this.isPreOrder});

  @override
  // ignore: no_logic_in_create_state
  State<PaymentScreen> createState() => _PaymentScreenState(url, confirmUrl);
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final WebViewController controller;

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String url, confirmUrl;
  bool _loading = true;

  _PaymentScreenState(this.url, this.confirmUrl);

  @override
  void initState() {
    super.initState();

    // if (!url.contains("https://") && !url.contains("http://")) {
    //   url = "https://$url";
    // }

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            // var html = await controller.runJavaScript(
            //     source: "window.document.getElementsByTagName('html')[0].outerHTML;");
            // dynamic data = getData(controller);
            // print("------------" + data.toString());
            // if (url.contains(confirmUrl)) {}
            setState(() {
              _loading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   debugPrint('blocking navigation to ${request.url}');
            //   return NavigationDecision.prevent;
            // }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(url),
      );
  }

  Future<void> getData(WebViewController controller) {
    return controller.runJavaScript(
        "window.document.getElementsByTagName('html')[0].outerHTML;");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Flutter WebView'),
      // ),
      body: Column(children: [
        Container(
          color: white,
          width: double.maxFinite,
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 45,
              ),
              Container(
                height: 40,
                width: double.maxFinite,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Stack(
                  children: [
                    Center(
                      child: ReusableText(
                        title: "Payment".tr,
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
                          // Get.delete<WishListController>();
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
            ],
          ),
        ),
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: _loading
                    ? Container(
                        margin: const EdgeInsets.only(top: 95),
                        height: MediaQuery.of(context).size.height - 180,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      )
                    : InAppWebView(
                        initialUrlRequest: URLRequest(url: WebUri(url)),
                        initialOptions: InAppWebViewGroupOptions(
                            crossPlatform: InAppWebViewOptions(
                          clearCache: true,
                          cacheEnabled: false,
                          useShouldOverrideUrlLoading: false,
                        )),
                        onWebViewCreated: (InAppWebViewController controller) {
                          // webView = controller;
                        },
                        onLoadStart: (controller, url) => {},
                        onLoadStop: (controller, url) async {
                          {
                            print(
                                "---------------url---------" + url.toString());
                            if (url.toString().contains(confirmUrl)) {
                              var html = await controller.evaluateJavascript(
                                  source: "window.document.body.innerText;");
                              print("--------------html----------" + html);

                              var responseData = CheckoutResponse.fromJson(
                                  json.decode(html.toString()));

                              if (responseData.code == "200") {
                                widget.cartController.getCartList();
                                AppUtils.navigateToPage(OrderPlacedScreen(isPreOrder: widget.isPreOrder,
                                  orderId: responseData.orderId,
                                ));
                              } else {
                                Get.back();
                                CommonUtils.showErrorDialog(
                                    responseData.message);
                              }
                            }
                          }
                        },
                      )))
      ]),
    );
  }
}
