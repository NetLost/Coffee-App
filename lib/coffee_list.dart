import 'package:coffee_app/coffee.dart';
import 'package:coffee_app/coffee_detail.dart';
import 'package:flutter/material.dart';

import 'widgets/coster.dart';

const _duration = Duration(milliseconds: 300);
const _initialPage = 10.0;

class CoffeeList extends StatefulWidget {
  const CoffeeList({Key? key}) : super(key: key);

  @override
  State<CoffeeList> createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  final _pageCoffeeContoroller = PageController(
    viewportFraction: .35,
    initialPage: _initialPage.toInt(),
  );

  final _pageTextController = PageController(initialPage: _initialPage.toInt());
  double? _currentPage = _initialPage;
  double? _textPage = _initialPage;

  void _coffeeScrollListener() {
    setState(() {
      _currentPage = _pageCoffeeContoroller.page;
    });
  }

  void _textSrollListener() {
    _textPage = _currentPage;
  }

  @override
  void initState() {
    _pageCoffeeContoroller.addListener(_coffeeScrollListener);
    _pageTextController.addListener(_textSrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeeContoroller.removeListener(_coffeeScrollListener);
    _pageTextController.removeListener(_textSrollListener);
    _pageCoffeeContoroller.dispose();
    _pageTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          const Coaster(),
          Transform.scale(
            alignment: Alignment.bottomCenter,
            scale: 1.6,
            child: PageView.builder(
              controller: _pageCoffeeContoroller,
              scrollDirection: Axis.vertical,
              onPageChanged: (value) {
                if (value < coffees.length) {
                  _pageTextController.animateToPage(
                    value,
                    duration: _duration,
                    curve: Curves.easeOut,
                  );
                }
              },
              itemCount: coffees.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox.shrink();
                }
                final coffee = coffees[index - 1];
                final result = _currentPage! - index + 1;
                final value = -.4 * result + 1;
                final opacity = value.clamp(.0, 1.0);
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 650),
                        pageBuilder: (context, animation, _) {
                          return FadeTransition(
                            opacity: animation,
                            child: CoffeeDetail(coffee: coffee,),
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, .001)
                        ..translate(
                          .0,
                          size.height / 2.6 * (1 - value).abs(),
                        )
                        ..scale(value),
                      child: Opacity(
                        opacity: opacity,
                        child: Hero(
                          tag: coffee.name,
                          child: Image.asset(
                            coffee.image,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 100,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 0.0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(.0, -100 * value),
                  child: child,
                );
              },
              duration: _duration,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: coffees.length,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageTextController,
                      itemBuilder: (context, index) {
                        final opacity =
                            (1 - (index - _textPage!).abs()).clamp(.0, 1.0);
                        return Opacity(
                          opacity: opacity,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: size.width * .2),
                            child: Hero(
                              tag: "text_${coffees[index].name}",
                              child: Material(
                                child: Text(
                                  coffees[index].name,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AnimatedSwitcher(
                    duration: _duration,
                    key: Key(coffees[_currentPage!.toInt()].name),
                    child: Text(
                      '\$${coffees[_currentPage!.toInt()].price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
