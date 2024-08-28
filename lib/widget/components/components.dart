import 'dart:ui';

import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class Components {
  static Widget googleFonts({
    String text = "",
    Color color = AppPalette.mette,
    double fontSize = 14,
    int maxlines = 1,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    EdgeInsets padding = EdgeInsets.zero,
    bool isContainer = false,
    TextOverflow overflow = TextOverflow.clip,
    Alignment alignment = Alignment.centerLeft,
  }) {
    // Split the text into parts based on the presence of '@' or '#'
    List<TextSpan> spans = [];
    final regex = RegExp(r'(@\w+|#\w+)');
    final matches = regex.allMatches(text);

    int lastMatchEnd = 0;

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        // Add the text before the special character(s)
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: fontFamily(
              color: color, fontSize: fontSize, fontWeight: fontWeight),
        ));
      }

      // Add the special character(s) with blue color
      spans.add(TextSpan(
        text: match.group(0),
        style: fontFamily(
            color: Colors.blue, fontSize: fontSize, fontWeight: fontWeight),
      ));

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      // Add the remaining text after the last match
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd),
        style: fontFamily(
            color: color, fontSize: fontSize, fontWeight: fontWeight),
      ));
    }

    final richText = RichText(
      text: TextSpan(
        children: spans,
      ),
      maxLines: maxlines,
      overflow: overflow,
      textAlign: textAlign,
    );

    return isContainer
        ? Container(
            alignment: alignment,
            padding: padding,
            child: richText,
          )
        : richText;
  }

  static const fontFamily = GoogleFonts.robotoFlex;

  //textfield like username emailaddress password
  static Widget customTextField(
      {bool isPadding = false,
      bool isPassword = false,
      EdgeInsets padding = EdgeInsets.zero,
      EdgeInsets contentPadding = EdgeInsets.zero,
      Function(String)? onChanged,
      String hint = '',
      double radius = 0.0}) {
    return isPadding
        ? Padding(
            padding: padding,
            child: TextField(
              cursorColor: AppPalette.mette,
              style: GoogleFonts.poppins(color: AppPalette.mette),
              obscureText: isPassword ? true : false,
              onChanged: onChanged,
              decoration: textfieldDecoration(
                  radius: radius, padding: contentPadding, hint: hint),
            ),
          )
        : TextField(
            cursorColor: AppPalette.mette,
            obscureText: isPassword ? true : false,
            decoration: textfieldDecoration(
                radius: radius, padding: contentPadding, hint: hint),
          );
  }

  //Textfield text decoration
  static InputDecoration textfieldDecoration(
      {required double radius,
      required EdgeInsets padding,
      required String hint}) {
    return InputDecoration(
        contentPadding: padding,
        hintText: hint,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(width: 1.5, color: AppPalette.mette)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(width: 1.5, color: AppPalette.mette)));
  }

  static Widget spinkit() {
    return Positioned.fill(
      child: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 50.0.sp,
        ),
      ),
    );
  }

  static Widget blurBackground() {
    return Positioned.fill(
      child: Stack(
        children: [
          // Blur background
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Center spinner
          Components.spinkit(),
        ],
      ),
    );
  }

  static void topSnackBar(BuildContext context, {required String text}) {
    return awesomeTopSnackbar(context, text,
        textStyle: fontFamily(color: Colors.white),
        backgroundColor: AppPalette.mette,
        icon: const Icon(
          Iconsax.close_circle,
          color: Colors.white,
        ));
  }
}
