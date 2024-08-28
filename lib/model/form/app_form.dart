import 'package:flutter/material.dart';

class AppFormUI {
  final int id;
  final String title;
  final List<String> dp;
  final Color color;
  final int cost;
  AppFormUI(
      {required this.id,
      required this.title,
      required this.color,
      required this.dp,
      required this.cost});
}

final List<AppFormUI> formUI = [
  AppFormUI(
      id: 0,
      cost: 100,
      title: "Gatepass\nForm",
      color: const Color.fromRGBO(255, 197, 197, 1),
      dp: [
        '',
        '',
        '',
        '',
        '',
      ]),
  AppFormUI(
      id: 1,
      cost: 200,
      title: "On-Duty\nForm",
      color: const Color.fromRGBO(255, 235, 216, 1),
      dp: [
        '',
        '',
        '',
        '',
        '',
      ]),
  AppFormUI(
      id: 2,
      cost: 500,
      title: "Leave\nForm",
      color: const Color.fromRGBO(199, 220, 167, 1),
      dp: [
        '',
        '',
        '',
        '',
        '',
      ]),
];
