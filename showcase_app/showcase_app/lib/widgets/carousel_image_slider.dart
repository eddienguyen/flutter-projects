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
  int _current = 0;

  void onPageChanged(int newPageIndex) {
    setState(() {
      _current = newPageIndex;
//      print(_controller.initialPage);
    });
  }

  void previousImage() {
    if (_current <= 0) return;
    setState(() {
      _current = _current - 1;
      _controller.animateToPage(_current,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    });
  }

  void nextImage() {
    if (_current >= widget.list.length - 1) return;

    setState(() {
      _current = _current + 1;
      _controller.animateToPage(_current,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        // the slider
        new PageView.builder(
            onPageChanged: onPageChanged,
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
        Positioned(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Previous
                FlatButton(
                  child: Icon(Icons.navigate_before),
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: previousImage,
                ),
                // Next
                FlatButton(
                  child: Icon(Icons.navigate_next),
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: nextImage,
                )
              ],
            ),
          ),
        ),
        // the indicators
        widget.hasIndicator
            ? DotIndicator(
                list: widget.list,
                controller: _controller,
              )
            : IgnorePointer(),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  final List<String> list;
  final PageController controller;

  DotIndicator({this.list, this.controller});

  Widget _buildDot(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (controller.page ?? controller.initialPage).round() %
                      list.length ==
                  index
              ? Color.fromRGBO(255, 255, 255, 0.9)
              : Color.fromRGBO(255, 255, 255, 0.4)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: new List.generate(list.length, _buildDot)),
    );
  }
}
