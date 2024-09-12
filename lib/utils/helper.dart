import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class Helper {
  static DateTime combineDateTimeWithTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  static String formatDateToString(DateTime date) {
    final DateFormat formatter = DateFormat('EEE, ddMMMM yyyy');
    return formatter.format(date);
  }

  static String formatTimeOfDayToString(TimeOfDay time) {
    // Create a DateTime object with a fixed date and the provided time
    final DateTime dateTime = DateTime(
      0,
      1,
      1,
      time.hour,
      time.minute,
    );

    final DateFormat formatter = DateFormat('hh:mm a');
    return formatter.format(dateTime);
  }

  static String formatTimeOfDayToStringfromDateTime(DateTime time) {
    final DateFormat formatter = DateFormat('hh:mm a');
    return formatter.format(time);
  }

  static DateTime parseDateString(String dateString) {
    final DateFormat formatter = DateFormat('EEE, ddMMMM yyyy');
    try {
      return formatter.parse(dateString);
    } catch (e) {
      log('Error parsing date: $e');
      return DateTime.now();
    }
  }

  static TimeOfDay parseTimeOfDayString(String timeString) {
    final DateFormat formatter = DateFormat('hh:mm a');
    try {
      final DateTime dateTime = formatter.parse(timeString);
      return TimeOfDay(
        hour: dateTime.hour,
        minute: dateTime.minute,
      );
    } catch (e) {
      log('Error parsing time: $e');
      return TimeOfDay.now();
    }
  }
}
