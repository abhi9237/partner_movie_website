import 'dart:developer';

import 'package:intl/intl.dart';

String formatMinutesIntoHours(String? totalMinutesStr) {
  if (totalMinutesStr == null || totalMinutesStr.isEmpty) {
    return '';
  }
  final int? totalMinutes = int.tryParse(totalMinutesStr);
  if (totalMinutes == null || totalMinutes <= 0) {
    return '';
  }
  final int hours = totalMinutes ~/ 60;
  final int minutes = totalMinutes % 60;
  final StringBuffer buffer = StringBuffer();
  if (hours > 0) {
    buffer.write('${hours}h ');
  }
  if (minutes > 0 || hours == 0) {
    buffer.write('${minutes}m');
  }
  return buffer.toString().trim();
}

Map<String, int> convertToWeekdayMap(Map<String, dynamic> dateData) {

  final Map<String, int> weeklyTotals = {
    "Sun": 0,
    "Mon": 0,
    "Tue": 0,
    "Wed": 0,
    "Thu": 0,
    "Fri": 0,
    "Sat": 0,
  };

  for (final entry in dateData.entries) {
    try {
      final DateTime date = DateTime.parse(entry.key);

      final String weekday = weekdayName(date.weekday);

      final int value = int.tryParse(entry.value.toString()) ?? 0;
      weeklyTotals[weekday] = (weeklyTotals[weekday] ?? 0) + value;
    } catch (e) {
      log('Could not parse date or value for entry: ${entry.key}. Error: $e');
    }
  }

  return weeklyTotals;
}

String weekdayName(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return "Mon";
    case DateTime.tuesday:
      return "Tue";
    case DateTime.wednesday:
      return "Wed";
    case DateTime.thursday:
      return "Thu";
    case DateTime.friday:
      return "Fri";
    case DateTime.saturday:
      return "Sat";
    case DateTime.sunday:
      return "Sun";
    default:
      return "";
  }
}
