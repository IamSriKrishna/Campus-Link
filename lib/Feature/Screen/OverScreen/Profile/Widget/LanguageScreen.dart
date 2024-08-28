import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package
import 'package:campuslink/Feature/Screen/OverScreen/Profile/Widget/LanguageContoller.dart';
import 'package:campuslink/Util/FontStyle/RobotoBoldFont.dart';
import 'package:campuslink/Util/FontStyle/RobotoRegularFont.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:campuslink/l10n/LanguageController.dart';
import 'package:provider/provider.dart';

class LanguagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeMode.getDarkTheme ? themeColor.darkTheme : Colors.white,
        title: RobotoBoldFont(text: S.current.language),
      ),
      body: GetBuilder<LanguageController>(
        builder: (languageController) {
          return Column(
            children: [
              Expanded(
                child: SafeArea(
                  top: false,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        value: index,
                        groupValue: languageController.selectedLanguageIndex.value,
                        dense: true,
                        onChanged: (value) {
                          languageController.changeLanguage(index);
                        },
                        title: RobotoBoldFont(
                          text:languages[index],
                        ),
                        subtitle: RobotoRegularFont(
                          text:subLanguage[index],
                        ),
                      );
                    },
                    itemCount: languages.length,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
