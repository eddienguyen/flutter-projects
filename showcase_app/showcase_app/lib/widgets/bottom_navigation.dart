import 'package:flutter/material.dart';
import 'package:showcase_app/widgets/bottom_navigation_button.dart';

typedef ButtonPressCallBack(int id);

class BottomNavigation extends StatelessWidget {
  int currentIndex;
  BottomNavigation({this.onPressed});

  final ButtonPressCallBack onPressed;
  void _handleItemChanged(bool newValue) {

  }
  // void onPressed(int id) {
  //   print(id);
  // }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = <Widget>[];

    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).bottomAppBarColor.withOpacity(0.5),
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavigationButton(
            label: 'about.',
            active: false,
            onChanged: _handleItemChanged,
            
          ),
          BottomNavigationButton(
            label: 'store.',
            active: false,
            onChanged: _handleItemChanged,
          ),
          BottomNavigationButton(
            label: 'discover.',
            active: false,
            onChanged: _handleItemChanged,
          ),
          BottomNavigationButton(
            label: 'story.',
            active: true,
            onChanged: _handleItemChanged,
          )
        ],
      ),
    );
  }
}
