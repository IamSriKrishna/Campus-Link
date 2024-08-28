import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RobotoMediumFont extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? size;
  const RobotoMediumFont({
    super.key,
    required this.text,
     this.textAlign,
     this.textColor,
     this.fontWeight,
     required this.size
    });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.merriweather (
        color: textColor,
        fontWeight: fontWeight,
        fontSize: size,
      ),
      );
  }
}