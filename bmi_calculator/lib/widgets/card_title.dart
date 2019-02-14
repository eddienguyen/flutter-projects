import 'package:bmi_calculator/config/widget_utils.dart';
import 'package:flutter/material.dart';

/// For A Card that use title and a subtitle, with unit displayed,
/// and in order to have 2 texts side by side but with different fonts, we will use RichText Widget
class CardTitle extends StatelessWidget {
  final String title;

  final String subtitle;

  CardTitle(this.title, {Key key, this.subtitle}) : super(key: key);

  // build a column with 2 elements: a Row and a divider.
  // the Row consists 2 texts with different styles
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(
            screenAwareSize(8.0, context),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title.toUpperCase(),
                style: _titleStyle,
              ),
              Text(
                subtitle != null ? subtitle.toUpperCase() : "",
                style: _subtitleStyle,
              )
            ],
          ),
        ),
        Divider(
          height: 1.0,
          color: Color.fromRGBO(143, 144, 156, 0.22),
        ),
      ],
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
