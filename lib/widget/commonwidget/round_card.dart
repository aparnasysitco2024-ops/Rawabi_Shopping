import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rawabi/utils/colors.dart';

class RoundCard extends StatelessWidget {
  final String image;
  const RoundCard({
    super.key, required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: grey,width: 1),
      ),
      child: SvgPicture.asset(
          image,fit: BoxFit.fill,),

    );
  }
}