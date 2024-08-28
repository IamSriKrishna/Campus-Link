import 'package:flutter/material.dart';
import 'package:campuslink/Util/FontStyle/RobotoBoldFont.dart';

class profileButton extends StatelessWidget {
  final Color foregroundColor;
  final Color backgroundColor;
  final void Function() onPressed; 
  final String text;
  const profileButton({
    super.key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: Size(
          MediaQuery.of(context).size.width * 0.4, 
          MediaQuery.of(context).size.height * 0.04
        ),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor
      ),
      onPressed: onPressed, 
      child: RobotoBoldFont(text: text,size: 12,)
    );
  }
}