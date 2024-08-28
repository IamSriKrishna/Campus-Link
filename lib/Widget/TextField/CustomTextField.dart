import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    required this.labelText
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 5),
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.5)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:8.0),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            enableSuggestions: true,
            textCapitalization: textCapitalization,
            style: GoogleFonts.merriweather(
              color: Colors.black,
              fontSize: 14
            ),
            decoration: InputDecoration(
              hintStyle: GoogleFonts.merriweather(
              color: Colors.black54,
              fontSize: 14
              ),
              labelStyle: GoogleFonts.merriweather(
              color: Colors.black54,
              fontSize: 14
              ),
              labelText: labelText,
              hintText: hintText,
              border: InputBorder.none
            ),
          ),
        )),
    );
  }
}

