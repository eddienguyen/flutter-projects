import 'package:fancy_tab_bar/config/widget_utils.dart';
import 'package:fancy_tab_bar/theme/page_styles.dart';
import 'package:flutter/material.dart';

class TabItem extends StatefulWidget {
  final String title;
  final IconData iconData;
  final bool selected;
  Function onPress;

  TabItem(
      {Key key,
      this.title,
      this.iconData,
      this.selected = false,
      @required this.onPress})
      : super(key: key);

  @override
  _TabItemState createState() => _TabItemState();
}

const double ICON_ON = -2.5;
const double ICON_OFF = 0;
const double TEXT_ON = 0;
const double TEXT_OFF = 1;
const double ALPHA_ON = 1;
const double ALPHA_OFF = 0;

class _TabItemState extends State<TabItem> with SingleTickerProviderStateMixin {
  double iconYAlign = ICON_OFF;
  double textYAlign = TEXT_OFF;
  double iconAlpha = ALPHA_ON;
  double textAlpha = ALPHA_OFF;
  // AnimationController _animationController;
  // Tween<double> _activeTween;
  // Animation<double> _activeAnimation;

  @override
  void initState() {
    // _animationController = new AnimationController(
    //     vsync: this, duration: Duration(milliseconds: ANIMATION_DURATION));

    _tabItemRefresh();
    super.initState();
  }

  @override
  void didUpdateWidget(TabItem oldWidget) {
    _tabItemRefresh();
    super.didUpdateWidget(oldWidget);
  }

  _tabItemRefresh() {
    setState(() {
      iconYAlign = widget.selected ? ICON_ON : ICON_OFF;
      iconAlpha = widget.selected ? ALPHA_OFF : ALPHA_ON;
      textYAlign = widget.selected ? TEXT_ON : TEXT_OFF;
      textAlpha = widget.selected ? ALPHA_ON : ALPHA_OFF;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        overflow: Overflow.clip,
        fit: StackFit.expand,
        children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              child: AnimatedAlign(
                duration: Duration(milliseconds: ANIMATION_DURATION),
                alignment: Alignment(0, textYAlign),
                child: AnimatedOpacity(
                  opacity: textAlpha,
                  duration: Duration(milliseconds: ANIMATION_DURATION),
                  child: Text(
                    widget.title.toUpperCase(),
                    style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                ),
              )),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: AnimatedAlign(
              duration: Duration(milliseconds: ANIMATION_DURATION),
              curve: Curves.easeIn,
              alignment: Alignment(0, iconYAlign),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: ANIMATION_DURATION),
                opacity: iconAlpha,
                child: IconButton(
                    icon: Icon(widget.iconData),
                    color: PURPLE,
                    onPressed: widget.onPress),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
