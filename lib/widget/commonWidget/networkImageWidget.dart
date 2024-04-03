import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class NetworkImageWidget extends StatelessWidget {
  final image;
  final height;
  BoxFit fit;

   NetworkImageWidget(
      {super.key,
      required this.image,
      this.height = 50.0,
      this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: FadeInImage.assetNetwork(
          fit: fit,
          placeholder: 'assets/images/logo.png',
          image: image.toString()),
    );
  }
}
