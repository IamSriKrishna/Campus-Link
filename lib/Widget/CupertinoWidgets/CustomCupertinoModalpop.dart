import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campuslink/l10n/AppLocalization.dart';

void CustomCupertinoModalPop({
  required BuildContext context,
  required String content
  }){
  showCupertinoModalPopup(
    context: context, 
    builder:(context) => CupertinoAlertDialog(
      title: Text(
        S.current.warning,
        style: GoogleFonts.merriweather()
      ),
      content: Text(
        content,
        style: GoogleFonts.merriweather()
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
        child: Text(
          S.current.ok,
          style: GoogleFonts.merriweather(),
        )
      )
      ],
    ),
  );
}

void CustomCupertinoModalPopDeleteChat({
  required BuildContext context,
  required void Function() ok
  }){
  showCupertinoModalPopup(
    context: context, 
    builder:(context) => CupertinoAlertDialog(
      title: Text(
        S.current.warning,
        style: GoogleFonts.merriweather()
      ),
      content: Text(
        'Want to Delete This Particular Chat?',
        style: GoogleFonts.merriweather()
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
        child: Text(
          S.current.cancel,
          style: GoogleFonts.merriweather(),
        )
      ),
        TextButton(
          onPressed: ok, 
        child: Text(
          S.current.ok,
          style: GoogleFonts.merriweather(),
        )
      ),
      ],
    ),
  );
}