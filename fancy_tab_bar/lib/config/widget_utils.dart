import 'package:flutter/material.dart';

const double baseHeight = 650.0;

double screenAwareSize(double size, BuildContext context) =>
    size * MediaQuery.of(context).size.height / baseHeight;

const int ANIMATION_DURATION = 500;