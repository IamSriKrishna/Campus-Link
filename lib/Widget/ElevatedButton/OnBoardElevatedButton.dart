import 'package:flutter/material.dart';
import 'package:campuslink/Feature/Screen/OverScreen/OverScreen.dart';

class OnBoardElevated extends StatelessWidget {
  final PageController controller;
  final Color backgroundColor;
  final String txt;
  const OnBoardElevated({
    super.key,
    required this.controller,
    required this.backgroundColor,
    this.txt = 'Next'
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 10,
        shadowColor: backgroundColor,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        fixedSize: Size(
          MediaQuery.of(context).size.width * 0.5, 
          MediaQuery.of(context).size.height * 0.06
        )
      ),
      onPressed: (){
        txt=='Next'?
        controller.nextPage(duration: Duration(
          milliseconds: 250
        ), curve: Curves.linear):Navigator.pushNamed(context, OverScreen.route);
      }, 
      child: Text(txt)
  );
  }
}