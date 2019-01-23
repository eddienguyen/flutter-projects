import 'package:flutter/material.dart';
import 'package:movie_db/src/ui/theme.dart' as Theme;

class GradientAppbar extends StatelessWidget {
  final String title;

  final double barHeight = 66.0;

  GradientAppbar(this.title);
  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: new EdgeInsets.only(top: statusbarHeight, left: 20.0),
      height: statusbarHeight + barHeight,
      alignment: Alignment.centerLeft,
      child: new Text(
        title.toUpperCase(), 
        style: Theme.Style.headerTextStyle,
      ),
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Theme.Colors.purple, Theme.Colors.pink],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          boxShadow: <BoxShadow>[
            new BoxShadow(
                blurRadius: 10.0,
                offset: new Offset(0.0, 5.0),
                color: Colors.black26)
          ]),
    );
  }
}
