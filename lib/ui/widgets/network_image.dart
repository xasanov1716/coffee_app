import 'package:cached_network_image/cached_network_image.dart';
import 'package:chandlier/utils/size/screen_size.dart';
import 'package:flutter/material.dart';

class NetworkImageItem extends StatelessWidget {
  const NetworkImageItem({Key? key, required this.image, required this.imageHeight, required this.imageWidth, this.fit}) : super(key: key);
  final String image;
  final double imageHeight;
  final double imageWidth;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,height: height * imageHeight / figmaHeight,width: width * imageWidth / figmaWidth,fit: fit,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.coffee),
    );
  }
}
