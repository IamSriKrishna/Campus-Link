import 'package:flutter/material.dart';
import 'package:campuslink/Util/FontStyle/RobotoBoldFont.dart';
import 'package:campuslink/Util/FontStyle/RobotoRegularFont.dart';
import 'package:campuslink/Util/util.dart';
import 'package:lottie/lottie.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: themeColor.appThemeColor2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: RobotoBoldFont(text: 'Authentication Hub',size: 30,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: RobotoRegularFont(
              text: 'Step into the Realm',
              size: 22,
              textColor: Color.fromARGB(255, 236, 236, 236),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0995,
          ),
          Lottie.asset('asset/lottie/login.json',height: MediaQuery.of(context).size.height * 0.18,),
        ],
      ),
    );
  }
}