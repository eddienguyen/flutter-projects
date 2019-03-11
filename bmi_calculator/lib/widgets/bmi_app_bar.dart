import 'package:bmi_calculator/theme/page_styles.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/config/widget_utils.dart' show screenAwareSize;
import 'package:bmi_calculator/models/pageType.dart';

/// AppBar's content is a 'Row' packed into a 'Padding' and contains 2 elements: the label && the icon.
class BmiAppBar extends StatelessWidget {
  final PageType pageType;

  const BmiAppBar({Key key, this.pageType = PageType.input});

  /// paste the Unicode emoji: https://unicode.org/emoji/charts/full-emoji-list.html
  /// in the texts, only use 4-digit => split one 5-digit symbol into 4-digit ones: http://www.russellcottrell.com/greek/utilities/SurrogatePairCalculator.htm
  static const String wavingHandEmoji = "\uD83D\uDC4B";
  static const String whiteSkinTone = "\uD83C\uDFFB";

  String getEmoji(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? wavingHandEmoji
        : wavingHandEmoji + whiteSkinTone;
  }

  Padding _buildIcon(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenAwareSize(11.0, context)),
      child: Container(
        width: screenAwareSize(20.0, context),
        height: screenAwareSize(20.0, context),
        // using 'Placeholder' instead of icon until get an actual icon
        child: Placeholder(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  RichText _buildLabel(BuildContext context) {
    // emoji will disappear when using bold font weight => use RichText and apply bold weight only to the text.
    return RichText(
      text: TextSpan(
          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 34.0),
          children: [
            TextSpan(
                text: this.pageType == PageType.input
                    ? 'BmiC'.toUpperCase()
                    : 'Your BMI',
                style: TextStyle(fontWeight: FontWeight.bold)),
            // space
            TextSpan(
              text: ' ',
            ),
            // TextSpan(text: getEmoji(context)) //<-- https://github.com/flutter/flutter/issues/9652
            TextSpan(
                text: this.pageType == PageType.input ? wavingHandEmoji : '')
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    // using 'Material' in order to add 'elevation'
    return Material(
      elevation: 2.0,
      child: Container(
        height: appBarHeight(context),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(screenAwareSize(16.0, context)),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildLabel(context),
              _buildIcon(context),
            ],
          ),
        ),
      ),
    );
  }
}
