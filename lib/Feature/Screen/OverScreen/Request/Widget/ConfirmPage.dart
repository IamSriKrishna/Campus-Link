import 'dart:async';

import 'package:flutter/material.dart';
import 'package:campuslink/Feature/Screen/OverScreen/OverScreen.dart';
import 'package:campuslink/Util/showsnackbar.dart';
import 'package:campuslink/Util/util.dart';
import 'package:lottie/lottie.dart';

class ConfirmationPage extends StatefulWidget {
  static const route = '/ConfirmationPage';
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    Timer(const Duration(milliseconds: 3500), () {
      showSnackBar(context: context, text: 'Masterful Testament To Your Submission\'s Success');
      Navigator.pushNamedAndRemoveUntil(
      context, OverScreen.route, (route) => false);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor.appBarColor,
      body: Center(
        child: Lottie.asset(
          "asset/lottie/check.json",
          controller: _controller,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward();
          },
        ),
      ),
    );
  }
}