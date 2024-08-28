import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemeProvider with ChangeNotifier {
  bool _darkTheme = false;

  // Initialize shared preferences in the constructor
  DarkThemeProvider() {
    _loadDarkThemePreference();
  }

  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    _saveDarkThemePreference(value); // Save the preference
    notifyListeners();
  }

  // Load the dark theme preference from shared preferences
  Future<void> _loadDarkThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkTheme = prefs.getBool('darkTheme') ?? false;
    notifyListeners();
  }

  // Save the dark theme preference to shared preferences
  Future<void> _saveDarkThemePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkTheme', value);
  }
}
