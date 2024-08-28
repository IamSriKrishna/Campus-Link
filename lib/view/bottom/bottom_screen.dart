import 'package:flutter/material.dart';
import 'package:campuslink/widget/bottom/bottom_widget.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomWidget.screen(),
      bottomNavigationBar: BottomWidget.navigationBar(),
    );
  }
}
