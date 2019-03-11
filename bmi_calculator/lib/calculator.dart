import 'dart:math' as math;

double calculateBMI({int weight, int height}) => weight / _heightSquare(height);

double calculateMinNormalWeight({int height}) => 18.5 * _heightSquare(height);

double calculateMaxNormalWeight({int height}) => 25 * _heightSquare(height);

double _heightSquare(int height) => math.pow(height / 100, 2);
