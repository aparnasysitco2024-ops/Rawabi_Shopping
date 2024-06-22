import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rawabi/utils/colors.dart';

// ignore: must_be_immutable
class RoundCard extends StatelessWidget {
  final String image;
  bool isPng = false;

  RoundCard({super.key, required this.image, this.isPng = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: grey, width: 1),
      ),
      child: isPng
          ? Image.asset(
              image,
              fit: BoxFit.fill,
            )
          : SvgPicture.asset(
              image,
              fit: BoxFit.fill,
            ),
    );
  }
}
