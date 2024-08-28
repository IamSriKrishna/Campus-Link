import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RobotoBoldFont extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? textColor;
  final double? size;
  final TextOverflow? textOverflow;
  const RobotoBoldFont({
    super.key,
    required this.text,
    this.textAlign,
    this.textColor,
    this.textOverflow = TextOverflow.visible,
    this.size,
    });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: textOverflow,
      style:GoogleFonts.merriweather (
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: size
        ),
      );
  }
}