import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campuslink/Util/util.dart';

class LeaveDetailsWidget extends StatelessWidget {
  final String text;
  final String hint;
  const LeaveDetailsWidget({super.key,required this.text,required this.hint});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left:8.0,right:8.0,top: 7),
          child: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * -0.01,
                left:  MediaQuery.of(context).size.width * -0.017,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${text}:',
                    style: GoogleFonts.merriweather(
                        color: themeColor.appThemeColor
                      ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: TextField(
                  readOnly: true,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelStyle: GoogleFonts.merriweather(
                      color: themeColor.appThemeColor
                    ),
                    hintStyle: GoogleFonts.merriweather(
                      color: themeColor.darkTheme
                    ),
                    hintText: ' ${hint}'
                  ),
                ),
              ),
            ],
          ),
        )
      );
  }
}