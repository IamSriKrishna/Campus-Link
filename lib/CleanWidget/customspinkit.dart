import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:campuslink/Util/util.dart';

class CustomSpinkit extends StatelessWidget {
  const CustomSpinkit({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0),
      child: SizedBox(
        height: 70,
        width: 70,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          color: Colors.black.withOpacity(0.1),
          child: Center(
            child: SpinKitFadingFour(
              color: themeColor.backgroundColor,
              size: 50.0,
            ),
          ),
        ),
      ),
    );
  }
}