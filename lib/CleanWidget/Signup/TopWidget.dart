import 'package:flutter/material.dart';
import 'package:campuslink/Util/FontStyle/RobotoBoldFont.dart';
import 'package:campuslink/Util/FontStyle/RobotoRegularFont.dart';
import 'package:campuslink/Util/util.dart';
import 'package:lottie/lottie.dart';

class SignUpTopWidget extends StatelessWidget {
  const SignUpTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: themeColor.appBarColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.07,),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: RobotoBoldFont(text: 'Create an Account',size: 30,textColor: themeColor.appThemeColor2,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: RobotoRegularFont(
              text: 'Unlock New Horizons',
              size: 22,
              textColor: Color.fromARGB(255, 236, 236, 236),
            ),
          ),
          Lottie.asset('asset/lottie/signup.json',height: MediaQuery.of(context).size.height * 0.22)
        ],
      ),
    );
  }
}