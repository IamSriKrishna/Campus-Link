import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RobotoRegularFont extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? size;
  const RobotoRegularFont({
    super.key,
    required this.text,
    this.textAlign,
    this.textColor,
    this.size,
    this.fontWeight,
    });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
        overflow: TextOverflow.visible,
      style: GoogleFonts.merriweather(
        color: textColor,
        fontWeight: fontWeight,
        fontSize: size,
      ),
      );
  }
}