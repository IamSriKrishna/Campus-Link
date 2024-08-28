import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/util.dart';
import 'package:provider/provider.dart';

AppBar LeaveAppBar({
  required BuildContext context,
  required String text
}){
    final theme = Provider.of<DarkThemeProvider>(context);
  return AppBar(
    backgroundColor: theme.getDarkTheme?themeColor.darkTheme:themeColor.backgroundColor,
    scrolledUnderElevation: 15,
    elevation: 0,
    leading: InkWell(
      onTap: (){
        Navigator.pop(context);
      }, 
      child: Icon(
        Icons.arrow_back_ios,
        color: theme.getDarkTheme?Colors.white:themeColor.appBarColor,
      )
    ),
    //Request Title
    title: Text(
      text,
      style: GoogleFonts.merriweather(
        color: theme.getDarkTheme?Colors.white:themeColor.appBarColor
      ),
    ),
    centerTitle: true,
  );
}


AppBar ODLeaveAppBar({
  required BuildContext context,
  required String text
}){
    final theme = Provider.of<DarkThemeProvider>(context);
  return AppBar(
    backgroundColor: theme.getDarkTheme?themeColor.darkTheme:themeColor.backgroundColor,
    scrolledUnderElevation: 15,
    elevation: 0,
    leading: InkWell(
      onTap: (){
        Navigator.pop(context);
      }, 
      child: Icon(
        Icons.arrow_back_ios,
        color: theme.getDarkTheme?Colors.white:themeColor.appBarColor,
      )
    ),
    //Request Title
    title: Text(
      text,
      style: GoogleFonts.merriweather(
        color: theme.getDarkTheme?Colors.white:themeColor.appBarColor
      ),
    ),
    centerTitle: true,
  );
}

AppBar LeaveAppBarTwo({
  required BuildContext context,
  required String text
}){
    final theme = Provider.of<DarkThemeProvider>(context);
  return AppBar(
    backgroundColor: theme.getDarkTheme?themeColor.darkTheme:themeColor.backgroundColor,
    scrolledUnderElevation: 15,
    elevation: 0,
    //Request Title
    title: Text(
      text,
      style: GoogleFonts.merriweather(
        color: theme.getDarkTheme?Colors.white:themeColor.appThemeColor
      ),
    ),
    centerTitle: true,
  );
}


AppBar ODAppBarTwo({
  required BuildContext context,
  required String text
}){
    final theme = Provider.of<DarkThemeProvider>(context);
  return AppBar(
    backgroundColor: theme.getDarkTheme?themeColor.darkTheme:themeColor.backgroundColor,
    scrolledUnderElevation: 15,
    elevation: 0,
    //Request Title
    title: Text(
      text,
      style: GoogleFonts.merriweather(
        color: theme.getDarkTheme?Colors.white:themeColor.appThemeColor
      ),
    ),
    centerTitle: true,
  );
}