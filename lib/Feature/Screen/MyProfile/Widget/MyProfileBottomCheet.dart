import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:campuslink/Constrains/ThemeColor.dart';
import 'package:campuslink/Feature/Screen/Library/Library.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/FontStyle/RobotoBoldFont.dart';
import 'package:campuslink/Util/util.dart';
import 'package:campuslink/Widget/CupertinoWidgets/CustomCupertinoModalpop.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';

Future<dynamic> MyProfileBottomSheet({
  required BuildContext context
}){
  final theme = Provider.of<DarkThemeProvider>(context,listen: false);
  return showModalBottomSheet(
      backgroundColor: theme.getDarkTheme?themeColor.darkTheme:ThemeColor().themeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )
      ),
      context: context, 
      builder:(context) => Container(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.005),
              child: MyProfileBottomButtons(
                title: "Attendance",
                OnTap: () {
                  CustomCupertinoModalPop(
                    context: context, 
                    content: S.current.development
                  );
                },
              ),
            ),
            MyProfileBottomButtons(
              title: "Library",
              OnTap: () {
                Get.to(()=>Library());
              },
            ),
            MyProfileBottomButtons(
              title: "Time Table",
              OnTap: () {
                CustomCupertinoModalPop(
                  context: context, 
                  content: S.current.development
                );
              },
            ),
          ],
        ),
      ),
    );
}



class MyProfileBottomButtons extends StatelessWidget {
  final String title;
  final void Function() OnTap;
  const MyProfileBottomButtons({
    super.key,
    required this.title,
    required this.OnTap
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:MediaQuery.of(context).size.width * 0.01,
        vertical: MediaQuery.of(context).size.height * 0.005
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(7.5),
        onTap: OnTap,
        child: Card(
          elevation: theme.getDarkTheme?0:5,
          color: theme.getDarkTheme?
          themeColor.appThemeColor.withOpacity(1):
          themeColor.themeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.5)
          ),
          child: Container(
            alignment: Alignment.centerLeft,
            height: MediaQuery.of(context).size.height * 0.06,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RobotoBoldFont(
                text: title,
                size: 16.5,
              ),
            )
          ),
        ),
      ),
    );
  }
}