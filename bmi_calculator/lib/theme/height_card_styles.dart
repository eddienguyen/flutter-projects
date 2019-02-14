import 'package:flutter/material.dart';
import 'package:bmi_calculator/config/widget_utils.dart';

export 'package:bmi_calculator/theme/height_card_styles.dart';

const double marginBottom = 16.0;
const double marginTop = 26.0;
const double labelsFontSize = 13.0;
const double selectedLabelFontSize = 16.0;
double circleSizeAdapted(context) => 32.0;
const Color labelsGrey = const Color.fromRGBO(216, 217, 223, 1.0);

double marginBottomAdapted(BuildContext context) =>
    screenAwareSize(marginBottom, context);

double marginTopAdapted(BuildContext context) =>
    screenAwareSize(marginTop, context);

const TextStyle labelsTextStyle =
    const TextStyle(color: labelsGrey, fontSize: labelsFontSize);
