import 'package:flutter/cupertino.dart';

T responsive<T>(
    BuildContext context,
    T mobile, {
      T? tablet,
      T? desktop,
    }) {
  final double width = MediaQuery.of(context).size.width;

  if (width >= 1100 && desktop != null) {
    // If desktop value is provided and screen is large, return it
    return desktop;
  } else if (width >= 650 && tablet != null) {
    // If tablet value is provided and screen is medium, return it
    return tablet;
  } else {
    // Otherwise, return the mobile value
    return mobile;
  }
}

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width < 650;
}
bool isTablet(BuildContext context) {
  return MediaQuery.of(context).size.width < 1100;
}