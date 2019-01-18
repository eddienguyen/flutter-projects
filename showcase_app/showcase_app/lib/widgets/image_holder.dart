import 'package:flutter/material.dart';

class ImageHolder extends Container {
  final int index;
  final double height;
  final double width;
  final String url;

  ImageHolder({this.width, this.index, this.url, this.height})
      : super(width: width);

  @override
  Widget build(BuildContext context) {
    Widget imageHolder = Container(
      height: this.height,
      width: this.width,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
//        borderRadius: BorderRadius.circular(20.0),
        image: new DecorationImage(
            image: ExactAssetImage(
              this.url,
            ),
            fit: BoxFit.cover),
//          image: new DecorationImage(
//              image: new NetworkImage(
//                (this.url != null ? this.url : ''),
//              ),
//              fit: BoxFit.cover)
      ),
    );

    return imageHolder;
  }
}
