import 'package:flutter/material.dart';

/// Because we want to support every possible screen size, and we have design specs with specific margins and sizes for a device with height (for example) 650dp.
/// In order to keep propotions similar for every device, we came up with this util method:
const double baseHeight = 650.0;

/// This method uses 'MediaQuery.of(context).size.height' which returns the actual device size in logical pixels.
/// It means, we can convert the device value so that the porpotions will remain the same.
double screenAwareSize(double size, BuildContext context) =>
    size * MediaQuery.of(context).size.height / baseHeight;
