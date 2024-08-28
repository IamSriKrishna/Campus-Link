import 'package:flutter/material.dart';
import 'package:campuslink/Feature/Screen/Auth/Login.dart';
import 'package:campuslink/Util/FontStyle/RobotoBoldFont.dart';
import 'package:campuslink/Util/FontStyle/RobotoRegularFont.dart';
import 'package:campuslink/Widget/ElevatedButton/OnBoardElevatedButton2.dart';

class ScreenThree extends StatelessWidget {
  static const route = '/ScreenThree';
  const ScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 133, 70, 1),
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, 1),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:40.0,top:40),
                    child: RobotoRegularFont(
                      text: 'Empower Your ',
                      textColor: Color.fromRGBO(150, 128, 116, 1),
                      size: 30,
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:40.0),
                    child: RobotoBoldFont(
                        text: 'College Experience',
                        textColor: Color.fromRGBO(255, 98, 15, 1),
                        size: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:40.0,top: 12.5),
                    child: RobotoRegularFont(
                      text: 'Track attendance and grades, empowering students academically.',
                      size: 22.5,
                      textColor: Colors.grey,
                      fontWeight: FontWeight.w100,
                      ),
                  )
                ],
              ),
            ),
          ),
          
          Align(
            alignment: Alignment(0, -0.6),
            child: Image.asset('asset/onboard/screen3.png')),
            
            Align(
            alignment: Alignment(0.85, 0.95),
            child: OnBoardElevatedButton2(
              txt: 'Get Started',
              onPressed: () {
                Navigator.pushReplacementNamed(context, Login.route);
              },
              backgroundColor: Color.fromRGBO(250, 133, 70, 1),
              ),
          )
        ],
      ),
    );
  }
}