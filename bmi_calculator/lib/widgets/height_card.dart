import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:bmi_calculator/config/widget_utils.dart';
import 'package:bmi_calculator/theme/height_card_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'card_title.dart';

class HeightCard extends StatelessWidget {
  final int height;

  final ValueChanged<int> onChange;

  const HeightCard({Key key, this.height = 150, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(8.0, context)),
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
                    onChange: (newHeight) => onChange(newHeight),
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

  /// Add a person image that will scale with the slider. When we can calculate the position of the slider(below),
  /// all we need to do is draw an svg image with the height equals to slider position plus bottom margin. Then align the image to the bottom.
  Widget _drawPersonImage() {
    double personImageHeight = _sliderPosition + marginBottomAdapted(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: SvgPicture.asset(
        'assets/images/person.svg',
        height: personImageHeight,
        width: personImageHeight / 4,
      ),
    );
  }

  /// add Gesture: taps - because 'onTap' event of GestureDetector doesn't provide information about the position of the event.
  /// So using onTapDown which provides GestureTapDownDetails.
  @override
  Widget build(BuildContext context) {
    // Stack will be handy later on when we will have more widgets to display
    return GestureDetector(
      // HitTestBehavior.translucent so height will be increase on tap down,
      // without it , height can only be decrease on tap down
      behavior: HitTestBehavior.translucent,
      onTapDown: _onTapDown,
      onVerticalDragStart: _onDragStart,
      onVerticalDragUpdate: _onDragUpdate,
      child: Stack(
        children: <Widget>[_drawPersonImage(), _drawLabels(), _drawSlider()],
      ),
    );
  }

  // Handling vertical drags. We'll use 2 callbacks from the gesture detector
  _onDragStart(DragStartDetails dragStartDetails) {
    // when the drag starts, update the new height and save that height
    // and y-offset in HeightPicker, because when the drag updates, check the difference between the start offset saved on start
    // and the update offset.
    // Then calculate the new height and update by widget.onChange method
    int newHeight = _globalOffsetToHeight(dragStartDetails.globalPosition);
    widget.onChange(_normalizeHeight(newHeight));
  }

  _onDragUpdate(DragUpdateDetails dragUpdateDetails) {
    int newHeight = _globalOffsetToHeight(dragUpdateDetails.globalPosition);
    widget.onChange(_normalizeHeight(newHeight));
  }

  _onTapDown(TapDownDetails tapDownDetails) {
    int height = _globalOffsetToHeight(tapDownDetails.globalPosition);
    widget.onChange(_normalizeHeight(height));
  }

  /// normalize the obtained value, so th
  int _normalizeHeight(int height) {
    return math.max(widget.minHeight, math.min(widget.maxHeight, height));
  }

  int _globalOffsetToHeight(Offset globalOffset) {
    // take the RenderBox from context
    RenderBox getBox = context.findRenderObject();
    // get the global position of tapDownDetails and parse global position to a local one
    Offset localPosition = getBox.globalToLocal(globalOffset);
    // take the y component of the offset. Remember that it is increasing down the screen (top = 0.0)
    double dy = localPosition.dy;
    // since this localPosition is connected from the HeightPicker widget, should subtract top margin and half of the label size.
    // this way max height value (ie. 190) can be the reference point.
    dy = dy - marginTopAdapted(context) - labelsFontSize / 2;
    // Divide the number of pixels from the top by the number of pixels per unit,
    // so that we have the number of units from the top,
    // then subtract the units from the top from the maximum height
    int height = widget.maxHeight - (dy ~/ _pixelsPerUnits);
    return height;
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
