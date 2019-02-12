import 'package:flutter/material.dart';

import '../config/widget_utils.dart' show screenAwareSize;

import 'package:bmi_calculator/widgets/gender_card.dart';
import 'package:bmi_calculator/widgets/weight_card.dart';

class InputPage extends StatelessWidget {
  // We will wrap everything in MediaQuery.padding so that we are sure the view will not overlap with platform UI elements(smarter: use SafeArea instead).
  // The title and bottom button will take 'fixed' amount of space and then the input cards will take the rest(Expanded) in the middle
  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.0,
        top: screenAwareSize(56.0, context),
      ),
      child: Text('BMIC',
          style: new TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
    );
  }

  // In the bottom part we will use a Switch as a placeholder
  Widget _buildBottom(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: screenAwareSize(100.0, context),
      width: double.infinity,
      child: Switch(
        value: true,
        onChanged: (val) {
          print(val);
        },
      ),
    );
  }

  // When it comes to building the middle part, it is just the combination of Rows,
  // Columns, and Expaned to male the cards split evenly:
  Widget _buildCards(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 14.0, right: 14.0, top: screenAwareSize(32.0, context)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(child: GenderCard()),
                Expanded(
                  child: WeightCard(),
                )
              ],
            ),
          ),
          Expanded(
            child: _tempCard('Height'),
          )
        ],
      ),
    );
  }

  Widget _tempCard(String label) {
    return Card(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: MediaQuery.of(context).padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(context),
            Expanded(child: _buildCards(context)),
            _buildBottom(context)
          ],
        ),
      ),
    );
  }
}
