import 'package:flutter/material.dart';

class DraggableScrollBar extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final double scrollThumbHeight;

  DraggableScrollBar({this.child, this.controller, this.scrollThumbHeight});
  @override
  _DraggableScrollBarState createState() => _DraggableScrollBarState();
}

class _DraggableScrollBarState extends State<DraggableScrollBar> {
  //this counts offset for scroll thumb for Vertical axis
  double _barOffset;
  //this counts offset for list in Vertical axis
  double _viewOffset;
  //variable to track when scrollbar is dragged
  bool _isDragInProcess;

  @override
  void initState() {
    super.initState();
    _barOffset = 0.0;
    _viewOffset = 0.0;
    _isDragInProcess = false;
  }

  double get barMinScrollExtent => 0.0;
  double get barMaxScrollExtent =>
      context.size.height - widget.scrollThumbHeight;

  // get length (min, max) of list/grid
  double get viewMinScrollExtent => widget.controller.position.minScrollExtent;
  double get viewMaxScrollExtent => widget.controller.position.maxScrollExtent;

  /// What is delta for list?
  /// It is a proportion — ratio of scrollbar delta to scrollbar length is the same as ratio scroll list delta to list length.
  double getScrollViewDelta(
      double barDelta, double viewScroll, double barScroll) {
    // viewSroll = viewMaxScrollExtent
    // barScroll = barMaxScrollExtent
    // propotion : barDelta / barScroll = viewDelta / viewScroll
    return barDelta * viewScroll / barScroll;
  }

  /// same as getScrollViewDelta
  /// get barDelta propotion when the viewDelta is exist
  double getBarDelta(double viewDelta, double viewScroll, double barScroll) {
    return viewDelta * barScroll / viewScroll;
  }

  /// this function process events when scroll controller changes it's position
  /// by scrollController.jumpTo or scrollController.animateTo functions.
  /// It can be when user scrolls, drags scrollbar (see line 139)
  /// or any other manipulation with scrollController outside this widget.
  void changePosition(ScrollNotification notification) {
    //if notification was fired when user drags we don't need to update scrollThumb position
    if (_isDragInProcess) return;

    setState(() {
      // dart: 'is': the test operator: True if the object has the specified type
      if (notification is ScrollUpdateNotification) {
        _barOffset += getBarDelta(
            notification.scrollDelta, viewMaxScrollExtent, barMaxScrollExtent);

        // clamp
        if (_barOffset <= barMinScrollExtent) _barOffset = barMinScrollExtent;
        if (_barOffset >= barMaxScrollExtent) _barOffset = barMaxScrollExtent;

        _viewOffset += notification.scrollDelta;
        if (_viewOffset <= viewMinScrollExtent)
          _viewOffset = viewMinScrollExtent;
        if (_viewOffset >= viewMaxScrollExtent)
          _viewOffset = viewMaxScrollExtent;
      }
    });
  }

  void _onVerticalDragStart(DragStartDetails details) {
    print('drag start: $details');
    setState(() {
      _isDragInProcess = true;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    print('drag end: $details');
    setState(() {
      _isDragInProcess = false;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _barOffset += details.delta.dy;

      // clamp
      if (_barOffset <= barMinScrollExtent) _barOffset = barMinScrollExtent;
      if (_barOffset >= barMaxScrollExtent) _barOffset = barMaxScrollExtent;

      double viewDelta = getScrollViewDelta(
          details.delta.dy, viewMaxScrollExtent, barMaxScrollExtent);

      _viewOffset = widget.controller.position.pixels + viewDelta;
      if (_viewOffset <= viewMinScrollExtent) _viewOffset = viewMinScrollExtent;
      if (_viewOffset >= viewMaxScrollExtent) _viewOffset = viewMaxScrollExtent;

      widget.controller.jumpTo(_viewOffset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        changePosition(notification);
      },
      child: new Stack(
        children: <Widget>[
          widget.child,
          GestureDetector(
            //we've add functions for onVerticalDragStart and onVerticalDragEnd
            //to track when dragging starts and finishes
            onVerticalDragStart: _onVerticalDragStart,
            onVerticalDragEnd: _onVerticalDragEnd,
            onVerticalDragUpdate: _onVerticalDragUpdate,
            child: Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: _barOffset),
              child: _buildScrollThumb(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildScrollThumb() {
    return new Container(
      height: widget.scrollThumbHeight,
      width: 20.0,
      color: Colors.blue,
    );
  }
}
