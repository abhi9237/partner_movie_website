import 'dart:ui';

import 'package:flutter/material.dart';

class BarData {
  /// The position on the X-axis (e.g., 0 for Monday, 1 for Tuesday).
  final int x;

  /// The value on the Y-axis (the height of the bar).
  final double y;

  /// The label to display below the X-axis for this bar.
  final String label;

  /// The color of the bar.
  final Color color;

  const BarData({
    required this.x,
    required this.y,
    required this.label,
    this.color = Colors.blue,
  });
}