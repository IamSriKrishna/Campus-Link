import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/util.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.text, required this.child, this.actions});

  final Widget? text;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(),
      backgroundColor:themeColor.appThemeColor,
      elevation: 0,
      scrolledUnderElevation: 10,
      automaticallyImplyLeading: false,
      leadingWidth: 70.w,
      leading: child,
      actions: actions,
      centerTitle: true,
      title: text);
  
  }
}


class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key, this.text, required this.child, this.actions});

  final Widget? text;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    
    final theme = Provider.of<DarkThemeProvider>(context);
    return SliverAppBar(
      iconTheme: const IconThemeData(),
      backgroundColor:theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
      elevation: 0,
      scrolledUnderElevation: 10,
      automaticallyImplyLeading: false,
      leadingWidth: 70.w,
      leading: child,
      actions: actions,
      centerTitle: true,
      title: text);
  
  }
}
