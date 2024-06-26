import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/colors.dart';

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
      child: CachedNetworkImage(
        imageUrl: image
            .toString(),
        placeholder: (context, url) => Center(
            child: new CircularProgressIndicator(
              color: primaryColor,
            )),
        errorWidget: (context, url, error) =>
        new Image.asset('assets/images/logo.png'),
        fit: fit,
      ),
      // FadeInImage.assetNetwork(
      //     fit: fit,
      //     placeholder: 'assets/images/logo.png',
      //     image: image.toString()),
    );
  }
}
