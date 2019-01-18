import 'package:flutter/material.dart';
import 'package:showcase_app/widgets/image_holder.dart';

class CarouselImageSlider extends StatefulWidget {
  final bool hasIndicator;
  final List<String> list;

  CarouselImageSlider({Key key, this.hasIndicator, this.list})
      : super(key: key);

  @override
  _CarouselImageSliderState createState() => _CarouselImageSliderState();
}

class _CarouselImageSliderState extends State<CarouselImageSlider> {
  final _controller = new PageController();

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        //TODO: clone example on : https://pub.dartlang.org/packages/carousel_slider#-readme-tab-
        // read this: https://steemit.com/utopian-io/@tensor/building-custom-scroll-physics-and-simulations-with-dart-s-flutter-framework

        // the slider


        new ListView.builder(
            physics: new AlwaysScrollableScrollPhysics(),
            controller: _controller,
            itemCount: widget.list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return ImageHolder(
                index: index,
                url: widget.list[index % widget.list.length],
                height: 200.0,
                width: MediaQuery.of(context).size.width,
              );
            }),
        // the buttons

        // the indicators
      ],
    );
  }
}
