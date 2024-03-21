import 'package:flutter/cupertino.dart';

import '../../utils/colors.dart';

class ReusableBorderContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;

  final Widget? child;

  const ReusableBorderContainer({super.key,
  this.width,
  this.height,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
height: height,
      width: width,
      decoration: BoxDecoration(
        color: fillColor??white,
        borderRadius: BorderRadius.circular(borderRadius??5),
        border: Border.all(color: borderColor??white,width: 1),

      ),
        child:child??const SizedBox(),
    );
  }
}
