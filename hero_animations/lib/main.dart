import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/rendering.dart';

class PhotoHero extends StatelessWidget {
  PhotoHero({Key key, this.imageSrc, this.width, this.onTap}) : super(key: key);

  final String imageSrc;
  final double width;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: imageSrc,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              imageSrc,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0; // 1.0 = normal speed
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic hero animation'),
      ),
      body: Center(
        child: PhotoHero(
          imageSrc: 'assets/images/banner.jpg',
          width: 100.0,
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute<void>(builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('detail hero image'),
                ),
                body: Container(
                  color: Colors.blueGrey[500],
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.topLeft,
                  child: PhotoHero(
                    imageSrc: 'assets/images/banner.jpg',
                    width: 300.0,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            }));
          },
        ),
      ),
    );
  }
}

void main() {
  debugPaintSizeEnabled = true;
  runApp(MaterialApp(
    home: HeroAnimation(),
  ));
}
