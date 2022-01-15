import 'package:coffee_app/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainCoffeeApp());
}

class MainCoffeeApp extends StatelessWidget {
  const MainCoffeeApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}