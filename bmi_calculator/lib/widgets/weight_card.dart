import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'package:bmi_calculator/config/widget_utils.dart' show screenAwareSize;
import 'package:bmi_calculator/widgets/card_title.dart';

class WeightCard extends StatefulWidget {
  final int initialWeight;
  const WeightCard({Key key, this.initialWeight}) : super(key: key);
  _WeightCardState createState() => _WeightCardState();
}

class _WeightCardState extends State<WeightCard> {
  int weight;

  @override
  void initState() {
    weight = widget.initialWeight ?? 70;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
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
    return WeightBackground(
      // add slider inside
      child: LayoutBuilder(builder: (context, constraints) {
        /// whenever run app in release mode LayoutBuilder is returning (0;0) constraints on the first build.
        /// so assure that only non-zero constraints are passed with this code:
        return constraints.isTight
            ? Container()
            : WeightSlider(
                minValue: 30,
                maxValue: 110,
                value: weight,
                onChanged: (newWeight) => setState(() => weight = newWeight),
                width: constraints.maxWidth,
              );
      }),
    );
  }
}

/// The background itself will be a simple container with proper decoration.
/// Designed it to accept child parameter which will be the actual sldier.
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
        SvgPicture.asset('assets/images/weight_arrow.svg',
            height: screenAwareSize(18.0, context),
            width: screenAwareSize(18.0, context))
      ],
    );
  }
}

/// The core of the widget, a slider which allows user to pick the weight, user can swipe horizontally of clicks on numbers to change the value.
/// The easiest approach would be to use horizontal ListView
/// This WeightSlider accpets 'min' and 'max' value, based on those, we can calculate how many items there are to display.
/// Also, pass 'width' of the widget. Because we want to display only 3 items, so we need to know how much space ine item needs to place(and set it in itemExtent)
class WeightSlider extends StatelessWidget {
  WeightSlider(
      {Key key,
      @required this.minValue,
      @required this.maxValue,
      @required this.width,
      @required this.value,
      this.onChanged})
      : scrollController = new ScrollController(
            initialScrollOffset: (value - minValue) * width / 3),
        super(key: key);

  final int minValue;
  final int maxValue;
  final double width;

  // NumberPicker mechanism: let the WeightSlider remain Stateless and just pass a value to it and
  // also get the callback when the value in the middle changes.
  final int value;
  final ValueChanged<int> onChanged;

  double get itemExtent => width / 3;

  int _indexToValue(int index) => minValue + (index - 1);

  final ScrollController scrollController;

  // calculating the offset ti middle element
  // Arithmetic operator "~/" : Divide, then returning an integer result
  int _offsetToMiddleIndex(double offset) => (offset + width / 2) ~/ itemExtent;

  int _offsetToMiddleValue(double offset) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    int middleValue = _indexToValue(indexOfMiddleElement);

    /// when the user scrolled to the edge the calculated value was higher than 'maxValue',
    /// fixed with this line:
    middleValue = math.max(minValue, math.min(maxValue, middleValue));
    return middleValue;
  }

  bool _onNotification(Notification noti) {
    if (noti is ScrollNotification) {
      // calculate the value of the middle element based on notification's Offset.
      int middleValue = _offsetToMiddleValue(noti.metrics.pixels);

      if (_isStoppedScrolling(noti)) {
        _animatedTo(middleValue);
      }

      // If the calculated value is different than the passed value, call onChanged method:
      if (middleValue != value) {
        // <-- the value has changed after scroll
        onChanged(middleValue); // update selection
      }
    }
    return true;
  }

  /// The overscroll
  /// Detect if the user stopped scrolling and if so, animate to the selected value
  bool _isStoppedScrolling(Notification noti) {
    return noti is UserScrollNotification &&
        noti.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }

  _animatedTo(int valueToSelect, {int durationMillis = 200}) {
    double targetExtent = (valueToSelect - minValue) * itemExtent;
    scrollController.animateTo(targetExtent,
        duration: new Duration(milliseconds: durationMillis),
        curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    // add 2 extra items to the ListView at the start and at the end so that we can have the boundary values displayed in the middle of the widget.
    int itemCount = (maxValue - minValue) + 3;
    return NotificationListener(
      // <-- this will invoke _onNotification on every scroll event.
      onNotification: _onNotification,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemExtent: itemExtent,
        itemCount: itemCount,
        physics: BouncingScrollPhysics(), // <-- default iOS scroll physics
        itemBuilder: (BuildContext context, int index) {
          final int value = _indexToValue(index);

          // 2 extra items to the ListView at the start and at the end so that we can have the boundary values displayed in the middle of the widget.
          bool _isExtra = index == 0 || index == itemCount - 1;

          return _isExtra
              ? new Container() // <-- empty first and last element
              /// wrap list items with GestureDetector and handle taps to add "tap to select weight" feature

              : GestureDetector(
                  behavior: HitTestBehavior
                      .translucent, // <-- using translucent hit test behavior so that both taps on texts as well as outside of them are being captured.
                  onTap: () => _animatedTo(value, durationMillis: 200),
                  child: FittedBox(
                    // <-- wrap text inside FittedBox so that if the number is over 100 or resolution is smaller, it will not be wrap(The initial position)
                    child: Text(
                      value.toString(),
                      style: _getTextStyle(value),
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                );
        },
      ),
    );
  }

  TextStyle _getDefaultTextStyle() {
    return new TextStyle(
        color: Color.fromRGBO(196, 197, 203, 1.0), fontSize: 13.0);
  }

  TextStyle _getHightlightTextStyle() {
    return new TextStyle(
        color: Color.fromRGBO(77, 123, 243, 1.0), fontSize: 24.0);
  }

  TextStyle _getTextStyle(int itemValue) {
    return itemValue == value
        ? _getHightlightTextStyle()
        : _getDefaultTextStyle();
  }
}
