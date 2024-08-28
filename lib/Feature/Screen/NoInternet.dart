import 'package:flutter/material.dart';
import 'package:campuslink/Util/util.dart';
import 'package:lottie/lottie.dart';

class NoInternet extends StatelessWidget {
  static const route = '/NoInternet';
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor.darkTheme,
      body: Center(
        child: Lottie.asset('asset/lottie/net.json'),
      ),
    );
  }
}