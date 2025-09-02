import 'package:flutter/material.dart';

class AppSizes {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static const double pagePadding = 28.0;
  static const double widgetSpacing = 16.0;
  static const double borderRadius = 8.0;
}
