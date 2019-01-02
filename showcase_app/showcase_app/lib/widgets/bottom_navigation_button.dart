import 'package:flutter/material.dart';

class BottomNavigationButton extends StatelessWidget {
  BottomNavigationButton({
    Key key,
    // @required this.index,
    @required this.label,
    this.active = false,
    this.onTap,
  }) : super(key: key);

  // final int index;
  final String label;
  final bool active;
  final VoidCallback onTap;

  // void _handleTap() {
  //   onChanged(!active);
  //   onTap();
  // }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.title.copyWith(
            color: active ? Colors.yellow : Colors.white,
            fontSize: active ? 18 : 16),
      ),
    );
  }
}