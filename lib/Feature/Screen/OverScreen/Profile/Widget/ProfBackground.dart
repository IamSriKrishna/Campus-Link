import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:campuslink/Constrains/Component.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:campuslink/Util/FontStyle/RobotoMediumFont.dart';
import 'package:campuslink/Util/util.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';

class ProBackground extends StatefulWidget {
  final GlobalKey theme;
  const ProBackground({super.key,required this.theme});

  @override
  State<ProBackground> createState() => _ProBackgroundState();
}

class _ProBackgroundState extends State<ProBackground> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    final student = Provider.of<StudentProvider>(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
          child: Align(
            alignment: const AlignmentDirectional(3, -0.3),
            child: Container(
              height: 300,
              width: 300,
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                color: theme.getDarkTheme ? themeColor.appThemeColor2:themeColor.appThemeColor2,
                
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
          child: Align(
            alignment: const AlignmentDirectional(-3, -0.3),
            child: Container(
              height: 300 ,
              width: 300, 
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:theme.getDarkTheme ? themeColor.appThemeColor:themeColor.appThemeColor2
              ),
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0, -1.2),
          child: Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.getDarkTheme ? themeColor.appThemeColor:themeColor.appThemeColor2
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
        Align(
          alignment: Alignment(-0.9,-0.85),
          child: RobotoMediumFont(
            text: S.current.profile, 
            size: 18,
            textColor:theme.getDarkTheme ? Colors.white:Colors.black
          )
        ),
        Align(
          alignment: Alignment(0.95,-0.88),
          child: ShowCaseView(
            globalKey: widget.theme, 
            title: 'Customize Your App\'s Theme', 
            description: 'Personalize your app\'s look and feel. Choose between light and dark themes, and switch between them effortlessly', 
            child: InkWell(
              onTap: () async{
                  setState(() {
                    DarkThemeProvider darkThemeProvider = Provider.of<DarkThemeProvider>(context, listen: false);
                    darkThemeProvider.setDarkTheme = !darkThemeProvider.getDarkTheme;
                  });
              },
              child: theme.getDarkTheme
                  ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('asset/theme/dark.png',height: 40,),
                  )
                  : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('asset/theme/light.png',height: 40,),
                  ),
            ),
          )
        ),
        Align(
          alignment: Alignment(0.0, -0.75),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: student.user.dp,
              width: MediaQuery.of(context).size.width * 0.23, // Adjust the width and height as needed
              height: MediaQuery.of(context).size.height * 0.105,
              fit: BoxFit.cover, // You can choose how the image fits within the circle
            ),
          ),),
        Align(
          alignment: Alignment(0.0, -0.5),
          child: RobotoMediumFont(
            text: student.user.name.toUpperCase(), 
            size: 18,
            textColor:theme.getDarkTheme ? Colors.white:Colors.black
          )
        ),
      ],
    );
  }
}