import 'package:flutter/widgets.dart';

class NetworkImageWidget extends StatelessWidget {
  final image;
  final height;
  const NetworkImageWidget({super.key, required this.image,this.height=50.0});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/logo.png',
          image: image
              .toString()),
    );
  }
}
