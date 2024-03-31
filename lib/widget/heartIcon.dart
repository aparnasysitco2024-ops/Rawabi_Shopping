import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controller/cartController.dart';
import '../utils/colors.dart';

// ignore: must_be_immutable
class HeartIcon extends StatefulWidget {
  final productId;
  var wishlist;

  HeartIcon({super.key, required this.productId, required this.wishlist});

  final cartController = Get.put(CartController());

  @override
  State<HeartIcon> createState() => _HeartIconState();
}

class _HeartIconState extends State<HeartIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.wishlist == 0
            ? widget.cartController.addToWishList(widget.productId)
            : widget.cartController.removeFromWishList(widget.productId);
        setState(() {
          widget.wishlist = widget.wishlist == 0 ? 1 : 0;
        });
      },
      child: SvgPicture.asset(
        "assets/icons/heart.svg",
        fit: BoxFit.fill,
        colorFilter: ColorFilter.mode(
            widget.wishlist == 0 ? silver : primaryColor, BlendMode.srcIn),
      ),
    );
  }
}
