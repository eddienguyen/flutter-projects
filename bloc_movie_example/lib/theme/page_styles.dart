import 'package:bloc_movie_example/config/widget_utils.dart';
import 'package:flutter/material.dart';

double appBarHeight(BuildContext context) =>
    screenAwareSize(80.0, context) + MediaQuery.of(context).padding.top;
