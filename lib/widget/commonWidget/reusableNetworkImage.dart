import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class ReusableNetworkImage extends StatelessWidget {
  String image;
  double height;

  ReusableNetworkImage({super.key, required this.image, this.height = 130});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/logo.png',
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/images/logo.png',
                width: height, height: height);
          },
          image: image),
    );
  }
}
