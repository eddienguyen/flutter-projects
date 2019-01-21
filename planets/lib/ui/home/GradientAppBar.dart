import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 66.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return new Container(
      height: barHeight + statusBarHeight,
      decoration: BoxDecoration(
          gradient: new LinearGradient(

              ///colors: an array of the colors to be used in the gradient, in this case, two shades of blue.
              colors: [
                const Color(0xFF3383FC),
                const Color(0xFF00C6FF),
              ],
              //begin, end: position of the first color and the last color,
              //in this case, FractionalOffset allows us to treat the coordinates as a range from 0 to 1 both for x and y.
              //As we want an horizontal gradient, we use same Y for both measures, and the x changes from 0.0 (left) to 1.0 (right).
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              //stops: this array should have the same size than colors. It defines how the colors will distribute. [0.0, 1.0] will fill it from left to right. [0.0, 0.5] will fill the colors from left to half bar, etc.
              stops: [0.0, 1.0],
              //tileMode: what to do if the stops do not fill the whole area. In this case, we added clamp (it will reuse the last color used), but as our gradient goes from 0.0 to 1.0, it’s not really necessary.
              tileMode: TileMode.clamp)),
      child: Center(
        child: new Text(
          title,
          style: TextStyle(
            color: Color(0xFFF9F7F0),
            fontFamily: 'Poppins',
            fontSize: 36.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
