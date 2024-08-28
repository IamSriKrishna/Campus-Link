
import 'package:campuslink/Util/util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: themeColor.appThemeColor
      ),
      child: Text(
        text,
        style: GoogleFonts.merriweather(
          color: color == null ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}