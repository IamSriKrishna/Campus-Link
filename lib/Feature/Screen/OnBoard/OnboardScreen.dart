import 'package:flutter/material.dart';
import 'package:campuslink/Feature/Screen/OnBoard/Screen1.dart';
import 'package:campuslink/Feature/Screen/OnBoard/Screen2.dart';
import 'package:campuslink/Feature/Screen/OnBoard/Screen3.dart';

class OnBoardScreen extends StatefulWidget {
  static const route = '/OnBoardScreen';
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final PageController _controller = PageController();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            physics: NeverScrollableScrollPhysics(),
            children: [
              ScreenOne(),
              ScreenTwo(),
              ScreenThree()
            ],
          ),
          
        ],
      ),
    );
  }
}