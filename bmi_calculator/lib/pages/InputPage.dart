import 'package:bmi_calculator/widgets/pacman_slider.dart';
import 'package:flutter/material.dart';

import '../config/widget_utils.dart' show screenAwareSize;
import 'package:bmi_calculator/theme/input_page_styles.dart';
import 'package:bmi_calculator/models/gender.dart';
import 'package:bmi_calculator/widgets/gender_card.dart';
import 'package:bmi_calculator/widgets/weight_card.dart';
import 'package:bmi_calculator/widgets/height_card.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender gender = Gender.other;
  int weight = 70;
  int height = 170;

  // We will wrap everything in MediaQuery.padding so that we are sure the view will not overlap with platform UI elements(smarter: use SafeArea instead).
  // The title and bottom button will take 'fixed' amount of space and then the input cards will take the rest(Expanded) in the middle
  // Widget _buildTitle(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       left: 24.0,
  //       top: screenAwareSize(56.0, context),
  //     ),
  //     child: Text('BMIC',
  //         style: new TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
  //   );
  // }

  // In the bottom part we will use a Switch as a placeholder
  Widget _buildBottom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        screenAwareSize(16.0, context),
        screenAwareSize(14.0, context),
        screenAwareSize(16.0, context),
        screenAwareSize(22.0, context),
      ),
      // child: Placeholder(
      //   fallbackHeight: screenAwareSize(52.0, context),
      //   color: Theme.of(context).primaryColor,
      // ),
      child: PacmanSlider(
        
      ),
    );
  }

  // When it comes to building the middle part, it is just the combination of Rows,
  // Columns, and Expaned to male the cards split evenly:
  Widget _buildCards(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 14.0,
        right: 14.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                    child: GenderCard(
                  gender: gender,
                  onChange: (newGenderChanged) =>
                      setState(() => gender = newGenderChanged),
                )),
                Expanded(
                  child: WeightCard(
                    weight: weight,
                    onChange: (newWeight) => setState(() => weight = newWeight),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: HeightCard(
              height: height,
              onChange: (newHeight) => setState(() => height = newHeight),
            ),
          )
        ],
      ),
    );
  }

  // temporary card, replacing GenderCard, WeightCard and HeightCard
  // Widget _tempCard(String label) {
  //   return Card(
  //     child: Container(
  //       width: double.infinity,
  //       height: double.infinity,
  //       child: Text(label),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // because material's AppBar is smaller than the design, create own appbar
      // to do that, need to pass 'PrefferedSizeWidget'
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight(context)),
        child: BmiAppBar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // _buildTitle(context),  <--- switch to custom appbar
          InputSummaryCard(
            gender: gender,
            weight: weight,
            height: height,
          ),
          Expanded(child: _buildCards(context)),
          _buildBottom(context)
        ],
      ),
    );
  }
}

/// AppBar's content is a 'Row' packed into a 'Padding' and contains 2 elements: the label && the icon.
class BmiAppBar extends StatelessWidget {
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
                text: 'BmiC'.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold)),
            // space
            TextSpan(
              text: ' ',
            ),
            // TextSpan(text: getEmoji(context)) //<-- https://github.com/flutter/flutter/issues/9652
            TextSpan(text: wavingHandEmoji)
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

/// Summary will take 3 values as parameters: gender, weight, height.
/// the row will contains this 3 values, each will be wrapped inside 'Expanded' to take same amount of space.
class InputSummaryCard extends StatelessWidget {
  final Gender gender;
  final int weight;
  final int height;

  const InputSummaryCard({Key key, this.gender, this.weight, this.height})
      : super(key: key);

  Widget _divider() {
    return Container(
      width: 1.0,
      color: Color.fromRGBO(151, 151, 151, 0.2),
    );
  }

  Widget _text(String text) {
    return Text(
      text,
      style:
          TextStyle(color: Color.fromRGBO(143, 144, 156, 1.0), fontSize: 15.0),
      textAlign: TextAlign.center,
    );
  }

  Widget _genderText() {
    String genderText = gender == Gender.other
        ? '-'
        : (gender == Gender.male ? 'Male' : 'Female');
    return _text(genderText);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(screenAwareSize(16.0, context)),
      child: SizedBox(
        height: screenAwareSize(32.0, context),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _genderText(),
            ),
            _divider(),
            Expanded(
              child: _text("${weight}(kg)"),
            ),
            _divider(),
            Expanded(
              child: _text("${height}(cm)"),
            ),
          ],
        ),
      ),
    );
  }
}
