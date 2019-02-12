import 'package:flutter/material.dart';

/// For A Card that use title and a subtitle, with unit displayed,
/// and in order to have 2 texts side by side but with different fonts, we will use RichText Widget
class CardTitle extends StatelessWidget {
  final String title;

  final String subtitle;

  CardTitle(this.title, {Key key, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: title.toUpperCase(),
          style: _titleStyle,
          children: <TextSpan>[
            TextSpan(
                text: subtitle != null ? subtitle.toUpperCase() : "",
                style: _subtitleStyle)
          ]),
    );
  }
}

const TextStyle _titleStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(14, 24, 35, 1.0));

const TextStyle _subtitleStyle = TextStyle(
    fontSize: 8.0,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(78, 102, 114, 1.0));
