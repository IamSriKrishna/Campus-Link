import 'package:flutter/material.dart';
import 'package:campuslink/Util/FontStyle/RobotoMediumFont.dart';
import 'package:campuslink/Util/FontStyle/RobotoRegularFont.dart';
import 'package:campuslink/l10n/AppLocalization.dart';

class CustomApprovalWidget extends StatefulWidget {
  final Gradient color;
  final String title;
  final String detail;
  final int credit;
  final String image;
  const CustomApprovalWidget({
    super.key,
    required this.color,
    required this.title,
    required this.detail,
    required this.credit,
    required this.image
  });

  @override
  State<CustomApprovalWidget> createState() => _CustomApprovalWidgetState();
}

class _CustomApprovalWidgetState extends State<CustomApprovalWidget> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: widget.color
        ),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 15,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.26,
                child: RobotoRegularFont(
                  text: widget.title,
                  textColor: const Color.fromRGBO(238, 234, 247, 1),
                  size: 18,
                ),
              )
            ),
            Positioned(
              top: 10,
              right:5,
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  shape: BoxShape.circle
                ),
                child: Image.asset(widget.image,height: MediaQuery.of(context).size.height * 0.03,),
              )
            ),
            Align(
              alignment: const Alignment(0, 0.2),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal:15,vertical: 20),
                height: MediaQuery.of(context).size.height * 0.15,
                width: double.infinity,
                child: RobotoRegularFont(
                  text: widget.detail,
                  textColor: Colors.white,
                  ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 15,
              child: RobotoMediumFont(
                text: '${S.current.credit}: ${widget.credit}', 
                size: 15,
                textColor: Colors.white,
              )
            )
          ],
        ),
      ),
    );
  }
}