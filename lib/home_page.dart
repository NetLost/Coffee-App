import 'package:coffee_app/coffee.dart';
import 'package:coffee_app/coffee_list.dart';
import 'package:flutter/material.dart';

import 'widgets/background.dart';
import 'widgets/positioned_picture.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 650),
              pageBuilder: (context, animation, _) {
                return FadeTransition(
                  opacity: animation,
                  child: const CoffeeList(),
                );
              },
            ),
          );
        },
        child: Stack(
          children: [
            const Background(),
            PositionedPicture(
              height: size.height * .4,
              right: 0,
              left: 0,
              top: size.height * .15,
              tag: coffees[8].name,
              image: coffees[8].image,
            ),
            PositionedPicture(
              height: size.height * .7,
              left: 0,
              right: 0,
              bottom: 0,
              tag: coffees[9].name,
              image: coffees[9].image,
              fit: BoxFit.cover,
            ),
            PositionedPicture(
              height: size.height,
              left: 0,
              right: 0,
              bottom: -size.height * .8,
              tag: coffees[10].name,
              image: coffees[10].image,
              fit: BoxFit.cover,
            ),
            Positioned(
              height: 140,
              left: 0,
              right: 0,
              bottom: size.height * .25,
              child: Image.asset('assets/coffee/logo.png'),
            )
          ],
        ),
      ),
    );
  }
}
