import 'dart:math';

import 'package:flutter/material.dart';

class SlideIndicator extends AnimatedWidget {
  final PageController pageController;
  SlideIndicator({this.pageController}) : super(listenable: pageController);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(4, buildIndicator),
    );
  }

  Widget buildIndicator(int index) {
    double select = max(
        0.0,
        1.0 - ((pageController.page ?? pageController.initialPage) - index).abs(),
    );
    double decrease = 10 * select;
    return Container(
      width: 30,
      child: Center(
        child: Container(
          width: 20 - decrease,
          height: 5,
          decoration: BoxDecoration(
              color: decrease == 10.0 ?  Colors.grey[700] : Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}