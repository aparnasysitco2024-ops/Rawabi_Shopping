import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String image;
  final Color color;
  final double? height;

  const SvgIcon({Key? key, required this.image, this.color=Colors.transparent, this.height = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: 30,
      child: SvgPicture.asset(
        image,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
