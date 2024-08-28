import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campuslink/Util/util.dart';
import 'package:campuslink/l10n/AppLocalization.dart';

class ApprovalButton extends StatelessWidget {
  final TextEditingController message;
  final void Function() onTap;
  const ApprovalButton({super.key,required this.message,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:15.0,bottom:15.0,left:15.0),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(
              MediaQuery.of(context).size.width * 0.85, 
              MediaQuery.of(context).size.height * 0.06
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            foregroundColor: Colors.white,
            backgroundColor: themeColor.appThemeColor2
          ),
          onPressed: onTap,
          child: Text(
            S.current.send,
            style: GoogleFonts.merriweather()
          ),
        ),
      ),
    );
  }
}