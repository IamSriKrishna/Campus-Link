import 'package:flutter/material.dart';

class OnBoardElevatedButton2 extends StatelessWidget {
  final Color backgroundColor;
  final void Function() onPressed;
  final String txt;
  const OnBoardElevatedButton2({
    super.key,
    required this.backgroundColor,
    required this.onPressed,
    this.txt = 'Next'
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
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
      onPressed: onPressed, 
      child: Text(txt)
  );
  }
}