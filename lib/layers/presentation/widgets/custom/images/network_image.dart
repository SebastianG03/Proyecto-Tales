import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit boxFit;
  final double borderRadius;
  final double height;

  ///Create an Network Image with [borderRadius] = [20.0], [boxFit] = [BoxFit.cover] and a loading Builder
  const CustomNetworkImage({
    super.key,
    required this.url,
    this.height = 50,
    this.boxFit = BoxFit.cover,
    this.borderRadius = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(url, fit: boxFit, height: height, loadingBuilder:
          (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
