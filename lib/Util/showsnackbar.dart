import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:campuslink/Util/FontStyle/RobotoRegularFont.dart';
import 'package:provider/provider.dart';

void showSnackBar({required BuildContext context, required String text}) {
  final theme = Provider.of<DarkThemeProvider>(context, listen: false);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      padding: const EdgeInsets.all(10),
      elevation: 0,
      backgroundColor: Colors.white.withOpacity(0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(25),
        topLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
        bottomLeft: Radius.circular(25),
      )),
      content: Container(
        decoration: BoxDecoration(
            color: Colors.black87, borderRadius: BorderRadius.circular(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: RobotoRegularFont(
                text: text,
                textColor:theme.getDarkTheme? Colors.white:Colors.black,
              ),
            ),
          ],
        ),
      )));
}
