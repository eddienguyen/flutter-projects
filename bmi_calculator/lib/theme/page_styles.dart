import 'package:flutter/material.dart';
import 'package:bmi_calculator/config/widget_utils.dart';

/// Since we're not using material's AppBar - which was handling the status bar by its own, we have to take it into account by ourself
/// To add status bar height to custom app bar, use 'MediaQuery.of(context).padding.top' - it will make sure that not drawing behind the status bar icons or the notch
double appBarHeight(BuildContext context) {
  return screenAwareSize(80.0, context) + MediaQuery.of(context).padding.top;
}
