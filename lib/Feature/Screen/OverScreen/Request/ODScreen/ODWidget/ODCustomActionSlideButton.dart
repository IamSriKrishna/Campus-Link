
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Request/ODScreen/ODWidget/ODExpandWidget.dart';
import 'package:campuslink/Feature/Service/Credit.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';

class ODCustomActionSlideButton extends StatefulWidget {
  final Gradient color;
  final int StudentCredit;
  final int perCredit;
  final int daySelected;
  final DateTime? startDate;
  final DateTime? endDate;
  const ODCustomActionSlideButton({
    super.key,
    required this.daySelected,
    required this.color,
    required this.perCredit,
    required this.StudentCredit,
    this.startDate,
    this.endDate,
  });

  @override
  State<ODCustomActionSlideButton> createState() => _ODCustomActionSlideButtonState();
}

class _ODCustomActionSlideButtonState extends State<ODCustomActionSlideButton> {
  StudentCredit studentCredit = StudentCredit();

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<StudentProvider>(context).user;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
            if(widget.daySelected * widget.perCredit==0){
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
            else if(widget.StudentCredit<=0){
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
              //Navigating to the Details page

              studentCredit.updateStudentCredit(student.id, widget.daySelected * widget.perCredit);
              Navigator.pushNamed(
                context, 
                ODEXpandWidget.route,
                arguments: {
                  'spent':widget.daySelected * widget.perCredit,
                  'from': widget.startDate,
                  'to':widget.endDate,
                  'days':widget.daySelected,
                }
              );
            } 
        },
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.05,
          width:  MediaQuery.of(context).size.width * 0.1,
          decoration: BoxDecoration(
            gradient: widget.color,
            borderRadius: BorderRadius.circular(10)
          ),
            child: Text(
              S.current.continues,
              style: GoogleFonts.merriweather(
                color: Colors.white
              ),
            ),
        ),
      ),
    );

  }
}
