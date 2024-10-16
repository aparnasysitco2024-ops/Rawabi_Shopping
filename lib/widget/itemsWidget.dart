// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';
import 'package:rawabi/widget/productItem.dart';

import '../controller/cartController.dart';
import '../model/response/products.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class ItemsWidget extends StatefulWidget {
  String? title, groupImage, grp_id;
  List<Products>? products;
  bool hideViewAll;
  final cartController = Get.put(CartController());

  ItemsWidget(
      {super.key,
      this.title,
      this.products,
      this.hideViewAll = false,
      this.groupImage,
      this.grp_id});

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
                    Expanded(
                      child: ReusableText(
                        title: widget.title,
                        weight: FontWeight.bold,
                      ),
                    ),
                    // const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/ProductsFromHomeScreen',
                          arguments: {
                            'title': widget.title,
                            'products': widget.products,
                            "grp_id": widget.grp_id
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
          widget.groupImage != null && widget.groupImage!.isNotEmpty
              ? Container(
                  height: 90,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/ProductsFromHomeScreen',
                        arguments: {
                          'title': widget.title,
                          'products': widget.products,
                          "grp_id": widget.grp_id
                        },
                      );
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            height: double.infinity,
                            width: double.infinity,
                            placeholder: (context, url) => Center(
                                    child: new CircularProgressIndicator(
                                  color: primaryColor,
                                )),
                            imageUrl: widget.groupImage.toString())),
                  ),
                )
              : SizedBox(),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: productItemHeight,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    widget.products!.length > 10 ? 10 : widget.products?.length,
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
                    })),
          )
        ],
      ),
    );
  }
}
