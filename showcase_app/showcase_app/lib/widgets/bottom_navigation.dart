import 'package:flutter/material.dart';
import 'package:showcase_app/widgets/bottom_navigation_button.dart';

typedef ButtonPressCallBack(int id);

class BottomNavigation extends StatefulWidget {
  BottomNavigation(
      {@required this.items,
      this.currentIndex = 0,
      // this.onPressed,
      this.onTap});

  /// The index into [items] of the current active item.
  final int currentIndex;

  /// The interactive items laid out within the bottom navigation bar
  // where each item has an icon and title.
  final List<BottomNavigationButton> items;

  //  The callback that is called when a item is tapped.
  // The widget creating the bottom navigation bar needs to keep track of the
  // current index and call `setState` to rebuild it with the newly provided
  // index.
  final ValueChanged<int> onTap;

  @override
  State<StatefulWidget> createState() {
    return _BottomNavigationState();
  }
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  void initState() {
    super.initState();
    _resetState();
  }

  @override
  void didUpdateWidget(BottomNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      setState(() {});
      // print('updated!');
    }
  }

  void _resetState() {
    _rebuild();
  }

  void _rebuild() {
    setState(() {});
  }

  List<Widget> _createButtons() {
    final List<BottomNavigationButton> children = <BottomNavigationButton>[];
    for (int i = 0; i < widget.items.length; i++) {
      children.add(BottomNavigationButton(
        label: widget.items[i].label,
        active: i == widget.currentIndex,
        // onChanged: _handleItemChanged,
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap(i);
          }
        },
        // onTap: () {
        //   if (widget.onTap != null) {
        //     widget.onTap(i);
        //     setState(() {});
        //   }
        // }
      ));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).bottomAppBarColor.withOpacity(0.5),
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _createButtons(),
        //  <Widget>[
        //   // => replace with createButtons()
        //   BottomNavigationButton(
        //     label: 'about.',
        //     active: false,
        //     onChanged: _handleItemChanged,
        //   ),
        //   BottomNavigationButton(
        //     label: 'store.',
        //     active: false,
        //     onChanged: _handleItemChanged,
        //   ),
        //   BottomNavigationButton(
        //     label: 'discover.',
        //     active: false,
        //     onChanged: _handleItemChanged,
        //   ),
        //   BottomNavigationButton(
        //     label: 'story.',
        //     active: true,
        //     onChanged: _handleItemChanged,
        //   )
        // ],
      ),
    );
  }
}
