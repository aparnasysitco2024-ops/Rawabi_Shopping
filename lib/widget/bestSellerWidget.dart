import 'package:flutter/cupertino.dart';

import '../utils/colors.dart';
import '../utils/colors.dart' as Colors;
import 'Commonwidget/reusable_text.dart';

class BestSellerWidget extends StatelessWidget {
  var title;

  BestSellerWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
      decoration: const BoxDecoration(
          color: lightGreen,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: ReusableText(
        title: title,
        color: Colors.white,
        size: 10,
      ),
    );
  }
}
