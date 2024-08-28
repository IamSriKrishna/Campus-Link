import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Profile/Widget/ProfBackground.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Profile/Widget/ProfileBottomWidget.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class ProfileScreen extends StatefulWidget {
  final String upiId;
  const ProfileScreen({super.key,required this.upiId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  final GlobalKey themeMode = GlobalKey();
  final GlobalKey myProfile = GlobalKey();
  final GlobalKey forgetPIN = GlobalKey();
  final GlobalKey language = GlobalKey();
  final GlobalKey signOut = GlobalKey();



    void initState() {
      checkShowcaseStatus();
      super.initState();
    }
    Future<void> checkShowcaseStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final showcaseShown = prefs.getBool('showcaseShown') ?? false;

    if (!showcaseShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([themeMode, myProfile,forgetPIN,language,signOut]);
      });

      await prefs.setBool('showcaseShown', true);
    }
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked:(didPop)async{
        await showCupertinoModalPopup<void>(
          context: context, 
          builder:(context) => CupertinoAlertDialog(
            title: Text(
              S.current.warning,
              style: GoogleFonts.merriweather()
            ),
            content: Text(
              S.current.wanttoexitcampuslink,
              style: GoogleFonts.merriweather()
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
              child: Text(
                S.current.no,
                style: GoogleFonts.merriweather(),
              )
            ),
            
              TextButton(
                onPressed: (){
                  exit(0);
                }, 
              child: Text(
                S.current.yes,
                style: GoogleFonts.merriweather(),
              )
            ),
            ],
          ),
        );
      },
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              ProBackground(theme: themeMode,),
              ProfileBottomWidget(
                upiId: widget.upiId,
                myProfile: myProfile, 
                forgetPIN: forgetPIN, 
                language: language, 
                signOut: signOut
              )
            ],
          ),
        ),
      ),
    );
  }
}