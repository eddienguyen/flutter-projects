import 'package:flutter/material.dart';
import 'package:bmi_calculator/models/gender.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bmi_calculator/widgets/card_title.dart';
import 'package:bmi_calculator/config/widget_utils.dart' show screenAwareSize;

double _circleSize(BuildContext context) => screenAwareSize(80.0, context);

class GenderCard extends StatefulWidget {
  final Gender initialGender;

  const GenderCard({Key key, this.initialGender}) : super(key: key);

  _GenderCardState createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard>
    with SingleTickerProviderStateMixin {
  AnimationController _arrowAnimationController;
  Gender selectedGender;

  @override
  void initState() {
    // Conditional expression: expr1 ?? expr2 -> If expr1 is non-null, returns its value; otherwise, evaluate and returns the value of expr2.
    selectedGender = widget.initialGender ?? Gender.other;
    _arrowAnimationController = new AnimationController(
      vsync: this,
      lowerBound: -_defaultGenderAngle,
      upperBound: _defaultGenderAngle,
      value: _genderAngles[selectedGender],
    );
    super.initState();
  }

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CardTitle("Gender"),
            Padding(
              padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
              child: _drawMainStack(),
            )
          ],
        ),
      ),
    ));
  }

  Widget _drawMainStack() {
    return Container(
      width: double.infinity, //<--- Expand stack width
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _drawCircleIndicator(),
          GenderIconTranslated(
            gender: Gender.female,
          ),
          GenderIconTranslated(
            gender: Gender.male,
          ),
          GenderIconTranslated(
            gender: Gender.other,
          ),
          _drawGestureDetector()
        ],
      ),
    );
  }

  Widget _drawCircleIndicator() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GenderCircle(),
        GenderArrow(
          listenable:
              _arrowAnimationController, // make arrow display current gender
        ),
      ],
    );
  }

  /// Use Positioned.fill to make TapHandler fill whole Stack, and then just handle the taps
  Widget _drawGestureDetector() {
    return Positioned.fill(
      child: TapHandler(
        onGenderTapped: _setSelectedGender,
      ),
    );
  }

  void _setSelectedGender(Gender gender) {
    setState(() => selectedGender = gender);
    _arrowAnimationController.animateTo(_genderAngles[gender],
        duration: Duration(milliseconds: 100));
  }
}

class GenderCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // this Widget will suprisingly draw a circle.
    // note: at first time when there are no content, the circle is placed on top no matter how we align the stack,
    // the circle will move down when we add gender icons.
    return Container(
      width: _circleSize(context),
      height: _circleSize(context),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Color.fromRGBO(244, 244, 244, 1.0)),
    );
  }
}

/// Line below each gender icon
class GenderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: screenAwareSize(6.0, context),
          top: screenAwareSize(8.0, context)),
      child: Container(
        height: screenAwareSize(8.0, context),
        width: 1.0,
        color: Color.fromRGBO(216, 217, 223, 0.54),
      ),
    );
  }
}

/// Each Gender icon with a line below

/// The default angle is the angle between the middle gender icon and side ones and it is equal to 45 degress (pi/4);
const double _defaultGenderAngle = math.pi / 4;

/// We store angles for each gender outside the widget because we will reuse it when drawing an indicator arrow
const Map<Gender, double> _genderAngles = {
  Gender.male: _defaultGenderAngle,
  Gender.female: -_defaultGenderAngle,
  Gender.other: 0.0,
};

class GenderIconTranslated extends StatelessWidget {
  static final Map<Gender, String> _genderImages = {
    Gender.male: 'assets/images/male.svg',
    Gender.female: 'assets/images/female.svg',
    Gender.other: 'assets/images/other.svg'
  };

  final Gender gender;

  bool get _isOtherGender => gender == Gender.other;

  const GenderIconTranslated({Key key, this.gender}) : super(key: key);

  String get _assetName => _genderImages[gender];

  double _iconSize(BuildContext context) {
    return screenAwareSize(_isOtherGender ? 22.0 : 16.0, context);
  }

  // We'll want to move the centered icon (the other gender) a bit to the right so that it nicely aligns with the grey line
  double _genderLeftPadding(BuildContext context) {
    return screenAwareSize(_isOtherGender ? 8.0 : 0.0, context);
  }

  @override
  Widget build(BuildContext context) {
    // 1.Draw svg icon
    // 2.Rotate it in the opposite dirction to where it will be placed
    // 3.Add a line below the icon(with paddings).
    // 4.Rotate icon with a line in the target direction(at this point icon is straight again but the line remainded rotated in the desired direction).
    // 5.Lift 'base' of the widget up half the size of the circle. This will make all icons look like they are centered around the middle of the circle.
    Widget icon = Padding(
      padding: EdgeInsets.only(left: _genderLeftPadding(context)),
      child: SvgPicture.asset(
        _assetName,
        height: _iconSize(context),
        width: _iconSize(context),
      ),
    );

    Widget rotatedIcon = Transform.rotate(
      angle: -_genderAngles[gender],
      child: icon,
    );

    Widget iconWithALine = Padding(
      padding: EdgeInsets.only(bottom: _circleSize(context) / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[rotatedIcon, GenderLine()],
      ),
    );

    Widget rotatedIconWithALine = Transform.rotate(
      alignment: Alignment.bottomCenter,
      angle: _genderAngles[gender],
      child: iconWithALine,
    );

    Widget centeredIconWithALine = Padding(
      padding: EdgeInsets.only(bottom: _circleSize(context) / 2),
      child: rotatedIconWithALine,
    );

    return centeredIconWithALine;
  }
}

/// The Arrow
/// 1. Draw an svg image
/// 2. Since the image is rotated by default, we want to rotate it back so that the arrow is pointing towards the middle
/// 3. Move (translate) the arrow so that it is 'pinned' to the center of the screen
/// 4. Rotate the arrow to the angle provided in constructor
class GenderArrow extends AnimatedWidget {
  // final double angle;
  // this widget extends AnimatedWidget. This way it will rebuild itself on every controller update.

  const GenderArrow({Key key, Listenable listenable})
      : super(key: key, listenable: listenable);

  double _arrowLength(BuildContext context) => screenAwareSize(32.0, context);

  double _translationOffset(BuildContext context) =>
      _arrowLength(context) * 0.2;
  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;
    return Transform.translate(
      offset: Offset(0.0, -_translationOffset(context)),
      child: Transform.rotate(
        angle: animation.value, // <--- use animation value
        origin: Offset(0.0, _translationOffset(context)),
        child: SvgPicture.asset('assets/images/arrow.svg',
            height: _arrowLength(context), width: _arrowLength(context)),
      ),
    );
  }
}

/// Add Interactivity to gender selection, the solution is to split the gender card in to 3 equal columns,
/// each column assigned to one gender. This way it will be easy for the user to change the gender
class TapHandler extends StatelessWidget {
  final Function(Gender) onGenderTapped;

  const TapHandler({Key key, this.onGenderTapped}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              onGenderTapped(Gender.female);
            },
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              onGenderTapped(Gender.other);
            },
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              onGenderTapped(Gender.male);
            },
          ),
        ),
      ],
    );
  }
}
