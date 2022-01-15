import 'package:flutter/material.dart';

class PositionedPicture extends StatelessWidget {
  const PositionedPicture({
    Key? key,
    required this.height,
    this.left,
    this.right,
    this.top,
    this.bottom,
    this.fit,
    required this.tag,
    required this.image,
  }) : super(key: key);

  final double? height;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final String tag;
  final String image;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: height,
      left: left,
      right: right,
      bottom: bottom,
      top: top,
      child: Hero(
        tag: tag,
        child: Image.asset(
          image,
          fit: fit,
        ),
      ),
    );
  }
}
