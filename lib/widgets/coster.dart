import 'package:flutter/material.dart';

class Coaster extends StatelessWidget {
  const Coaster({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      left: 20,
      right: 20,
      bottom: -size.height * .22,
      height: size.height * .3,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.brown,
              blurRadius: 90,
              offset: Offset.zero,
              spreadRadius: 45,
            )
          ],
        ),
      ),
    );
  }
}