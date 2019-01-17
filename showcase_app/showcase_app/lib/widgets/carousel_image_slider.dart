import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselImageSlider extends StatefulWidget {
  final bool hasIndicator;

CarouselImageSlider({this.hasIndicator}) : super();
  @override
  _CarouselImageSliderState createState() => _CarouselImageSliderState();
}

class _CarouselImageSliderState extends State<CarouselImageSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarouselSlider()
      //TODO: clone example on : https://pub.dartlang.org/packages/carousel_slider#-readme-tab-
        // read this: https://steemit.com/utopian-io/@tensor/building-custom-scroll-physics-and-simulations-with-dart-s-flutter-framework
      ],
    );
  }
}


