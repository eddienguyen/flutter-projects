import 'package:bmi_calculator/pages/ResultPage.dart';
import 'package:bmi_calculator/theme/page_styles.dart';
import 'package:bmi_calculator/widgets/bmi_app_bar.dart';
import 'package:bmi_calculator/widgets/pacman_slider.dart';
import 'package:bmi_calculator/widgets/transition_dot.dart';
import 'package:flutter/material.dart';

import '../config/widget_utils.dart' show screenAwareSize;
import 'package:bmi_calculator/models/gender.dart';
import 'package:bmi_calculator/widgets/gender_card.dart';
import 'package:bmi_calculator/widgets/weight_card.dart';
import 'package:bmi_calculator/widgets/height_card.dart';
import 'package:bmi_calculator/models/pageType.dart';
import 'FadeRoute.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() {
    return new _InputPageState();
  }
}

class _InputPageState extends State<InputPage> with TickerProviderStateMixin {
  Gender gender = Gender.other;
  int weight = 70;
  int height = 170;
  AnimationController _submitAnimationController;

  @override
  initState() {
    super.initState();
    _submitAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _submitAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _goToResultPage().then((_) => _submitAnimationController
                .reset() // reset controller when coming back
            );
      }
    });
  }

  @override
  dispose() {
    _submitAnimationController.dispose();
    super.dispose();
  }

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
        onSubmit: _onPacmanSubmit,
        submitAnimationController: _submitAnimationController,
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
    // Move the dots(when done slider animation) to the middle of the screen:
    // - Create a Widget that will cover the whole Scaffold after the slider finishes its animation.
    return Stack(children: [
      Scaffold(
        // because material's AppBar is smaller than the design, create own appbar
        // to do that, need to pass 'PrefferedSizeWidget'
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight(context)),
          child: BmiAppBar(
            pageType: PageType.input,
          ),
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
      ),
      TransitionDot(animation: _submitAnimationController),
    ]);
  }

  void _onPacmanSubmit() {
    _submitAnimationController.forward();
  }

  _goToResultPage() async {
    return Navigator.of(context).push(FadeRoute(
        builder: (context) =>
            ResultPage(weight: weight, height: height, gender: gender)));
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
              child: _text("$weight(kg)"),
            ),
            _divider(),
            Expanded(
              child: _text("$height(cm)"),
            ),
          ],
        ),
      ),
    );
  }
}
