import 'dart:async';
import 'package:campuslink/Model/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Home/Widget/MainScreen.dart';
import 'package:campuslink/Feature/Screen/Messenger/MessageScreen.dart';
import 'package:campuslink/SoSScreen.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shake/shake.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/HomeScreen';

  final List<Post>? fetchpost;
  const HomeScreen({super.key, required this.fetchpost});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    bool canTriggerAction = true;

    ShakeDetector.autoStart(
      onPhoneShake: () {
        if (canTriggerAction) {
          Get.to(() => SOSScreen());
          canTriggerAction = false;
          Future.delayed(Duration(seconds: 3), () {
            canTriggerAction = true;
          });
        }
      },
      minimumShakeCount: 2,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: RangeMaintainingScrollPhysics(),
        controller: _controller,
        children: [
          ShowCaseWidget(
            builder: Builder(
              builder: (context) {
                return MainScreen(
                  fetchpost: widget.fetchpost!,
                  icon1OnTap: () {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.ease,
                    );
                  },
                );
              },
            ),
          ),
          MessageScreen(
            icon1OnTap: () async {
              await _controller.previousPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.ease);
            },
          )
        ],
      ),
    );
  }
}
