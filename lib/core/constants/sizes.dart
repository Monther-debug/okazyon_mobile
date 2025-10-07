import 'package:flutter/material.dart';

class AppSizes {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static const double pagePadding = 28.0;
  static const double widgetSpacing = 16.0;
  static const double borderRadius = 8.0;
  static const double borderRadiusL = 12.0;
  static const double formSpacing = 30.0;
  static const double defaultPadding = 16.0; // legacy name
  static const double spaceBtwSections = 32.0;
  static const double defaultSpace = defaultPadding; // alias
  static const double spaceBtwItems = 16.0; // horizontal item spacing
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double borderRadiusSm = 6.0;
  static const double borderRadiusLg = 16.0;
}
