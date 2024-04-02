import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../../controller/cartController.dart';
import '../../model/response/cartListResponse.dart';

class CartItemDetails extends StatelessWidget {
  final Products products;

  final cartController = Get.put(CartController());

  CartItemDetails({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
          //alignment: Alignment.center,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: 50,
                  child: FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: 'assets/images/logo.png',
                      image: products.productImage.toString())),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      title: products.productName,
                      size: 10,
                      weight: FontWeight.w600,
                      color: darkGrey,
                    ),
                    ReusableText(
                      title: "QAR ${products.subtotal}",
                      size: 12,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  if (products.quantity == "1") {
                    cartController.removeCartItem(products.cartId);
                  } else {
                    cartController.updateQty(products.productId,
                        int.parse(products.quantity.toString()) - 1);
                  }
                },
                child: const SizedBox(
                  width: 25,
                  child: CircleAvatar(
                    backgroundColor: pink,
                    radius: 15,
                    child:
                        ClipOval(child: Icon(size: 15, Icons.remove_outlined)),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              ReusableText(
                title: products.quantity,
                size: 12,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  cartController.addToCart(products.productId.toString(),
                      products.storeId.toString(), products.itemPrice, "1");
                },
                child: const SizedBox(
                  width: 25,
                  child: CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: 15,
                    child: ClipOval(child: Icon(size: 15, Icons.add)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
