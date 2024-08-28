import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campuslink/Util/util.dart';

class LeaveCustomField extends StatelessWidget {
  final String label;
  final String hint;
  const LeaveCustomField({
    super.key,
    required this.label,
    required this.hint
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
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
                    '${label}:',
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
                    hintText: '${hint}'
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}


class LeaveCustomFieldTwo extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController reason;
  const LeaveCustomFieldTwo({
    super.key,
    required this.label,
    required this.hint,
    required this.reason
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
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
                    '${label}:',
                    style: GoogleFonts.merriweather(
                        color: themeColor.darkTheme
                      ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: TextField(
                  controller: reason,
                  style: GoogleFonts.merriweather(
                    color:Colors.black
                  ),
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelStyle: GoogleFonts.merriweather(
                      color: themeColor.appThemeColor
                    ),
                    hintStyle: GoogleFonts.merriweather(
                      color: themeColor.darkTheme.withOpacity(0.2)
                    ),
                    hintText: '${hint}'
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}