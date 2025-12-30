import 'dart:ui';

class GrowthData {
  final String title;
  final double value;
  final double maxValue;
  final Color color;

  const GrowthData({
    required this.title,
    required this.value,
    this.maxValue = 1000,
    required this.color,
  });

  double get percentage => (value / maxValue) * 100;
}