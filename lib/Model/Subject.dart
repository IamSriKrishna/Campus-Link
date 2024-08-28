import 'package:flutter/material.dart';

class Subject{
  final String subject;
  final String subjectCode;
  final String teacherName;
  final Gradient color = LinearGradient(
      colors: [
        const Color.fromRGBO(254, 138, 138, 1).withOpacity(0.5),
        const Color.fromRGBO(237, 90, 90, 1).withOpacity(0.5),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
      );
  Subject({
    required this.subject,
    required this.subjectCode,
    required this.teacherName,
  });
}