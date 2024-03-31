// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';
import 'package:rawabi/widget/productItem.dart';

import '../controller/cartController.dart';
import '../model/products.dart';
import '../utils/constants.dart';

class ItemsWidget extends StatefulWidget {
  String? title;
  List<Products>? products;
  bool hideViewAll;
  final cartController = Get.put(CartController());

  ItemsWidget({super.key, this.title, this.products, this.hideViewAll = false});

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      color: Colors.white,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.hideViewAll
              ? const SizedBox(
                  width: double.infinity,
                )
              : Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    ReusableText(
                      title: widget.title,
                      weight: FontWeight.bold,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/ProductsFromHomeScreen',
                          arguments: {
                            'title': widget.title,
                            'products': widget.products,
                          },
                        );
                      },
                      child: ReusableText(
                        title: "See All".tr,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              height: productItemHeight,
              child: ListView.builder(

                  shrinkWrap: true,
                  itemCount: widget.products?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ProductItem(
                          products: widget.products![index],
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/ProductDetailsScreen',
                          arguments: {
                            'productID': widget.products![index].productId,
                          },
                        );
                        /*AppUtils.navigateToPage(
                              ProductDetailsScreen(
                                  productID: widget.products![index].productId));*/
                      })),)
        ],
      ),
    );
  }
}
