import 'package:flutter/material.dart';
import 'package:bmi_calculator/config/widget_utils.dart';
import 'package:bmi_calculator/config/height_card_styles.dart';
import 'card_title.dart';
import 'package:flutter/material.dart';

class HeightCard extends StatefulWidget {
  final int height;

  const HeightCard({Key key, this.height}) : super(key: key);
  @override
  _HeightCardState createState() => _HeightCardState();
}

class _HeightCardState extends State<HeightCard> {
  int height;

  @override
  void initState() {
    super.initState();
    height = widget.height ?? 140;
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
              'Height',
              subtitle: '(cm)',
            ),
            Expanded(
              /// This task we'll work on widget's actual height.
              /// To view that height, we will use 'LayoutBuilder', this gives us
              /// access to view constraints so that we can use the widget's height;

              child: Padding(
                padding: EdgeInsets.only(bottom: screenAwareSize(8.0, context)),
                child: LayoutBuilder(builder: (context, constraints) {
                  return HeightPicker(
                    // get the widget's height:
                    widgetHeight: constraints.maxHeight,
                    height: height,
                    onChange: (newHeight) => setState(() => height = newHeight),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeightPicker extends StatefulWidget {
  final int maxHeight;
  final int minHeight;
  final int height;
  final double widgetHeight;
  final ValueChanged<int> onChange;

  const HeightPicker(
      {Key key,
      this.maxHeight = 190,
      this.minHeight = 130,
      this.height,
      this.widgetHeight,
      this.onChange})
      : super(key: key);

  int get totalUnits => maxHeight - minHeight;

  @override
  _HeightPickerState createState() => _HeightPickerState();
}

/// HeightCard will stores actual height. To cope with that, we'll pass the height to HeightPicker
/// and listen to changes with 'ValueChanged<int>' - this way we won't get lost on where is the actual height stored.
class _HeightPickerState extends State<HeightPicker> {
  /// HeightSlider is the indicator of the selected height. It contains 3 elements: label, circle and line.
  /// how the slider will be placed: we'll use 'Positioned' widget which will
  /// specify the slider's position from the bottom. To do that we'll need to do following things:
  /// - Calculate 'drawingHeight': the distance in pixels between the middle of the lowerst label and the middle of the highest label.
  /// - width 'drawingHeight', we can calculate 'pixelsPerUnits' which will represent how many pixels are between 2 units of height.
  /// - last, we can calculate 'sliderPosition' which defines where should the slider be placed.

  double get _pixelsPerUnits => _drawingHeight / widget.totalUnits;

  double get _sliderPosition {
    double halfOfLowestLabel = labelsFontSize / 2;
    int unitsFromBottom = widget.height - widget.minHeight;
    return halfOfLowestLabel + unitsFromBottom * _pixelsPerUnits;
  }

  /// returns actual height of slider to be able to slide by pixels
  /// equals totalHeigt - marginBottom - marginTop - labelsFontSize
  double get _drawingHeight {
    double totalHeight = widget.widgetHeight;
    double marginBottom = marginBottomAdapted(context);
    double marginTop = marginTopAdapted(context);

    return totalHeight - (marginBottom + marginTop + labelsFontSize);
  }

  Widget _drawSlider() {
    return Positioned(
      child: HeightSlider(
        height: widget.height,
      ),
      left: 0.0,
      right: 0.0,
      bottom: _sliderPosition,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Stack will be handy later on when we will have more widgets to display
    return Stack(
      children: <Widget>[_drawLabels(), _drawSlider()],
    );
  }

  /// displaying labels on the right. We want them to be evenly distributed and to display
  /// values from 'minHeight' to 'maxHeight' and incremented by 5
  Widget _drawLabels() {
    // specified how many labels to display, the assumption is that the total number of units is dividable by 5.
    int labelsToDisplay = widget.totalUnits ~/ 5 + 1;
    // create a list of texts displaying each label
    List<Widget> labels = List.generate(labelsToDisplay, (index) {
      //show heights from high to low
      return Text(
        '${widget.maxHeight - 5 * index}',
        style: labelsTextStyle,
      );
    });

    // use Align with Alignment.centerRight so that our labels will stick to the right
    return Align(
      alignment: Alignment.centerRight,
      // IgnorePointer will causes the widget to ignore all gestures on it. It will be useful later on.
      child: IgnorePointer(
        child: Padding(
          padding: EdgeInsets.only(
              right: screenAwareSize(12.0, context),
              bottom: marginBottomAdapted(context),
              top: marginTopAdapted(context)),
          // use Column to place labels inside it. Specified MainAxisAlignment.spacebetween to male the labels distribute evenly
          // but also to not have any unnecessary margins on the edges.
          child: Column(
            children: labels,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
      ),
    );
  }
}

class HeightSlider extends StatelessWidget {
  final int height;

  const HeightSlider({Key key, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SliderLabel(height: height),
          Row(
            children: <Widget>[
              SliderCircle(),
              Expanded(
                child: SliderLine(),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SliderLabel extends StatelessWidget {
  final int height;

  const SliderLabel({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(
        left: screenAwareSize(4.0, context),
        bottom: screenAwareSize(2.0, context),
      ),
      child: Text(
        '$height',
        style: TextStyle(
          fontSize: selectedLabelFontSize,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class SliderCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: circleSizeAdapted(context),
      width: circleSizeAdapted(context),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor, shape: BoxShape.circle),
      child: Icon(
        Icons.unfold_more,
        color: Colors.white,
        size: 0.6 * circleSizeAdapted(context),
      ),
    );
  }
}

class SliderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(
          40,
          (i) => Expanded(
                child: Container(
                    height: 2.0,
                    decoration: BoxDecoration(
                        color: i.isEven
                            ? Theme.of(context).primaryColor
                            : Colors.white)),
              )),
    );
  }
}
