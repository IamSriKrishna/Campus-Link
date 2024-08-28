import 'package:flutter/material.dart';
import '../Util/util.dart';
class Styles {
  ThemeData themeData(bool isDark, BuildContext context) {
    return ThemeData(
      useMaterial3: false,
        appBarTheme: AppBarTheme(
            elevation: 0,
            foregroundColor: isDark ? themeColor.backgroundColor : Colors.black,
            backgroundColor: isDark
                ? const Color(0xFF1a1f3c)
                : Colors.lightBlueAccent.withOpacity(0.85)),
        switchTheme: SwitchThemeData(
            trackColor: MaterialStatePropertyAll(
                isDark ? const Color(0xFFE8FDFD) : const Color(0xFF1a1f3c)),
            thumbColor: MaterialStatePropertyAll(
                isDark ? Colors.amber : Colors.lightBlueAccent)),
        scaffoldBackgroundColor:
            isDark ? const Color(0xFF1a1f3c) : themeColor.backgroundColor,
        primaryColor: Colors.lightBlueAccent,
        colorScheme: ThemeData().colorScheme.copyWith(
            brightness: isDark ? Brightness.dark : Brightness.light,
            secondary:
                isDark ? const Color(0xFF1a1f3c) : const Color(0xFFE8FDFD)),
        cardColor: isDark ? const Color(0xFF1a1f3c) : Colors.white,
        canvasColor: isDark ? Colors.black : Colors.grey[50],
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme:
                isDark ? const ColorScheme.dark() : const ColorScheme.light()));
  }
}
