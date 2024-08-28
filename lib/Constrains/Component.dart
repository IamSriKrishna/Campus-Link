import 'package:flutter/material.dart';
import 'package:campuslink/Util/util.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowCaseView extends StatelessWidget {
  const ShowCaseView(
      {Key? key,
      required this.globalKey,
      required this.title,
      required this.description,
      required this.child,})
      : super(key: key);

  final GlobalKey globalKey;
  final String title;
  final String description;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Showcase(
        key: globalKey,
        title: title,
        titleTextStyle: TextStyle(
          fontSize: 22,
          color: themeColor.appBarColor,
          fontFamily: robotoFontFamily.robotoBold
        ),
        descTextStyle: TextStyle(
          fontSize: 15,
          color: themeColor.darkTheme,
          fontFamily: robotoFontFamily.robotoRegular
        ),
        description: description,
        child: child
      );
  }
}