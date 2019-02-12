import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bmi_calculator/config/widget_utils.dart' show screenAwareSize;
import 'package:bmi_calculator/widgets/card_title.dart';

class WeightCard extends StatefulWidget {
  _WeightCardState createState() => _WeightCardState();
}

class _WeightCardState extends State<WeightCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(32.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CardTitle(
              "Weight",
              subtitle: ('(kg)'),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: _drawSlider(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _drawSlider() {
    return WeightBackground();
  }
}

/// The background itself will be a simple container with proper decoration.
/// Designed it tot accept child parameter which will be the actual sldier.
class WeightBackground extends StatelessWidget {
  final Widget child;

  const WeightBackground({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: screenAwareSize(100.0, context),
          decoration: BoxDecoration(
              color: Color.fromRGBO(244, 244, 244, 1.0),
              borderRadius:
                  new BorderRadius.circular(screenAwareSize(50.0, context))),
          child: child,
        ),
        SvgPicture.asset(
          'assets/images/weight_arrow.svg',
          height: screenAwareSize(18.0, context),
          width: screenAwareSize(18.0, context)
        )
      ],
    );
  }
}
