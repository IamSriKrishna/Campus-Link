// ignore_for_file: file_names

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/util.dart';
import 'package:provider/provider.dart';

class CustomCurvedNavigation extends StatelessWidget {
  final int index;
  final void Function(int) onTabChange;
  final Color backgroundColor;
  const CustomCurvedNavigation({
    super.key,
    required this.index,
    required this.onTabChange,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return CurvedNavigationBar(
      color:const Color.fromARGB(88, 228, 228, 228) ,
      height: 50,
      backgroundColor:theme.getDarkTheme?themeColor.darkTheme: backgroundColor,
      items: [
        Image.asset('asset/bottom/earth.png',height: MediaQuery.of(context).size.height * 0.04,),
        //Image.asset('asset/bottom/chat.png',height: MediaQuery.of(context).size.height * 0.04,),
        Image.asset('asset/bottom/approval.png',height: MediaQuery.of(context).size.height * 0.04,),
        //Image.asset('asset/bottom/calendar.png',height: MediaQuery.of(context).size.height * 0.04,),
        Image.asset('asset/bottom/rocket.png',height: MediaQuery.of(context).size.height * 0.04,),
      ],
      index: index,
      onTap: onTabChange,
    );
  }
}