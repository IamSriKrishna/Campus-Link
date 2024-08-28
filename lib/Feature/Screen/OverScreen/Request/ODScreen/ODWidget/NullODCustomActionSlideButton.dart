import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campuslink/l10n/AppLocalization.dart';

//Null Condition
class NullODCustomActionSlideButton extends StatelessWidget {
  final int StudentCredit;
  final int perCredit;
  final Gradient color;
  final int daySelected;
  const NullODCustomActionSlideButton({
    super.key,
    required this.daySelected,
    required this.color,
    required this.perCredit,
    required this.StudentCredit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if(daySelected * perCredit==0){
              showCupertinoModalPopup(
                context: context, 
                builder:(context) => CupertinoAlertDialog(
                  title: Text(
                    S.current.warning,
                    style: GoogleFonts.merriweather()
                  ),
                  content: Text(
                    S.current.pleaseselectoneormoredaystocontinue,
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
            else if(StudentCredit==0){
              showCupertinoModalPopup(
                context: context, 
                builder:(context) => CupertinoAlertDialog(
                  title: Text(
                    S.current.warning,
                    style: GoogleFonts.merriweather()
                  ),
                  content: Text(
                    S.current.kindlyrefillyourcredit,
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
            else{
            } 
        },
        child: FadeInUp(
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.05,
            width:  MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
              gradient: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              S.current.continues,
              style: GoogleFonts.merriweather(
                color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }
}