  import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatTimeOfDay(TimeOfDay time) {
    // Create a DateTime object using the current date and the TimeOfDay
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);

    // Use intl package to format the DateTime to a string
    final formatter = DateFormat.jm(); // You can choose a different time format if needed
    return formatter.format(dateTime);
  }