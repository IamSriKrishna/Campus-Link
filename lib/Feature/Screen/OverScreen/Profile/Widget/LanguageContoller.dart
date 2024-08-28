import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  var selectedLanguageIndex = 0.obs;

  final List<Locale> supportedLocales = [
    const Locale('en', 'US'), 
    const Locale('ta', 'IN'), 
    const Locale('ml', 'IN'), 
    const Locale('hi', 'IN'), 
    const Locale('te', 'IN'), 
    const Locale('kn', 'IN'), 
  ];

  @override
  void onInit() {
    super.onInit();
    loadSelectedLanguage();
  }

  void changeLanguage(int index) {
    selectedLanguageIndex.value = index;
    Get.updateLocale(supportedLocales[index]);
    saveSelectedLanguage(index);
  }

  // Function to get the current locale
  Locale getLocale() {
    return supportedLocales[selectedLanguageIndex.value];
  }

  // Function to save the selected language index to SharedPreferences
  void saveSelectedLanguage(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedLanguageIndex', index);
  }

  // Function to load the selected language index from SharedPreferences
  void loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt('selectedLanguageIndex') ?? 0;
    selectedLanguageIndex.value = index;
  }
}
