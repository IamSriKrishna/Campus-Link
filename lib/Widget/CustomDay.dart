import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Function to determine the relative date
String getRelativeDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);

  if (date.year == today.year &&
      date.month == today.month &&
      date.day == today.day) {
    return 'Today';
  } else if (date.year == today.year &&
      date.month == today.month &&
      date.day == today.day + 1) {
    return 'Yesterday';
  } else if (date.year == yesterday.year &&
      date.month == yesterday.month &&
      date.day == yesterday.day) {
    return 'Tomorrow';
  } else {
    final difference = now.difference(date);
    return '${difference.inDays} days ago';
  }
}

// Your Widget where you want to display the date
Widget dateWidget(DateTime createdAt, BuildContext context) {
  final theme = Provider.of<DarkThemeProvider>(context);
  final dateFormat = DateFormat('dd-MM-yyyy');
  final formattedDate = dateFormat.format(createdAt);
  final relativeDate = getRelativeDate(createdAt);

  return Text(
    '${relativeDate.isNotEmpty ? relativeDate : formattedDate} (${DateFormat('dd-MM-yyyy').format(createdAt)})',
    style: GoogleFonts.merriweather(
      color: theme.getDarkTheme ? Colors.white : Colors.black,
    ),
  );
}
