import 'package:flutter/material.dart';
import 'package:campuslink/Feature/Screen/OnBoard/Screen3.dart';
import 'package:campuslink/Util/FontStyle/RobotoBoldFont.dart';
import 'package:campuslink/Util/FontStyle/RobotoRegularFont.dart';
import 'package:campuslink/Widget/ElevatedButton/OnBoardElevatedButton2.dart';

class ScreenTwo extends StatelessWidget {
  static const route = '/ScreenTwo';
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(134, 252, 210, 1),
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
                      text: 'Exquisite College',
                      textColor: Color.fromRGBO(111, 150, 140, 1),
                      size: 30,
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:40.0),
                    child: RobotoBoldFont(
                        text: 'Odyssey',
                        textColor: Color.fromRGBO(134, 252, 210, 1),
                        size: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:40.0,top: 12.5),
                    child: RobotoRegularFont(
                      text: 'Revolutionize college management with our CampusLink',
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
            alignment: Alignment(0, -0.5),
            child: Image.asset('asset/onboard/screen2.png')
          ),
          Align(
          alignment: Alignment(0.85, 0.95),
          child: OnBoardElevatedButton2(
            onPressed: () {
              Navigator.pushNamed(context, ScreenThree.route);
            },
            backgroundColor: Color.fromRGBO(134, 252, 210, 1),
            ),
          )
        ],
      ),
    );
  }
}