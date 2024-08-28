import 'package:flutter/material.dart';

class Approval{
  final int credit;
  final String image;
  final String approval;
  final String approvalElaborate;
  final Gradient color;
  final double percent;
  Approval({
    required this.image,
    required this.approval,
    required this.color,
    required this.credit,
    required this.approvalElaborate,
    required this.percent
  });
}