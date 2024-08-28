import 'package:campuslink/Feature/Screen/KCGAI/KCGAI.dart';
import 'package:campuslink/Feature/Service/UpdateFCMToken.dart';
import 'package:flutter/material.dart';
import 'package:campuslink/Constrains/Component.dart';
import 'package:campuslink/Feature/Screen/MyProfile/MyProfile.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Request/Leave/History.dart';
import 'package:campuslink/Feature/Service/Authservice.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Feature/Screen/Auth/Login.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Profile/Widget/About.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Profile/Widget/LanguageScreen.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:campuslink/Util/util.dart';
import 'package:campuslink/Widget/Additional/ProfileWidget.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfileBottomWidget extends StatefulWidget {
  final String upiId;
  final GlobalKey myProfile;
  final GlobalKey forgetPIN;
  final GlobalKey language;
  final GlobalKey signOut;
  const ProfileBottomWidget(
      {super.key,
      required this.upiId,
      required this.myProfile,
      required this.forgetPIN,
      required this.language,
      required this.signOut});

  @override
  State<ProfileBottomWidget> createState() => _ProfileBottomWidgetState();
}

class _ProfileBottomWidgetState extends State<ProfileBottomWidget> {
  final UpdateFCMToken _updateFCMToken = UpdateFCMToken();
  final AuthService _authService = AuthService();
  Future<void> signout(String token) async {
    _updateFCMToken
        .fcmUpdate(context: context, fcmtoken: 'Null')
        .then((value) => _authService.signOutUser(token));
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<DarkThemeProvider>(context);
    final student = Provider.of<StudentProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 250.0),
      child: Container(
        decoration: BoxDecoration(
            color: themeMode.getDarkTheme ? themeColor.darkTheme : Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowCaseView(
              globalKey: widget.myProfile,
              title: 'Personal Information',
              description:
                  "This is your space to control account settings, update your profile, and review your activity on our platform.",
              child: ProfileWidget(
                  onTap: () {
                    Get.to(() => MyProfile());
                    //CustomCupertinoModalPop(context: context, content: S.current.development);
                  },
                  title: S.current.myProfile,
                  iconColor: Color.fromRGBO(130, 194, 233, 1),
                  color: Color.fromRGBO(214, 230, 242, 1),
                  iconData: Icons.person_outlined),
            ),
            ShowCaseView(
              globalKey: widget.forgetPIN,
              title: "History",
              description: "View Your Form History",
              child: ProfileWidget(
                onTap: () {
                  Navigator.pushNamed(context, History.route);
                },
                title: S.current.history,
                iconColor: Color.fromRGBO(96, 186, 100, 1),
                color: Color.fromRGBO(202, 224, 220, 1),
                iconData: Icons.history,
              ),
            ),
            ShowCaseView(
              globalKey: widget.language,
              title: "Explore Different Languages",
              description:
                  "Explore app content in different languages. Make your experience more accessible.",
              child: ProfileWidget(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LanguagesScreen(),
                      ));
                },
                title: S.current.language,
                iconColor: Color.fromRGBO(234, 118, 56, 1),
                color: Color.fromRGBO(235, 224, 220, 1),
                iconData: Icons.language,
              ),
            ),
            ProfileWidget(
                onTap: () {
                  Navigator.pushNamed(context, AboutWebviewScreen.route);
                },
                title: S.current.about,
                iconColor: Color.fromRGBO(188, 233, 130, 1),
                color: Color.fromRGBO(227, 242, 214, 1),
                iconData: Icons.info),
            ProfileWidget(
                onTap: () async {
                 Get.to(()=>KCGAI(name: student.user.name,));
                },
                title: "KCG BOT",
                iconColor: Color.fromRGBO(197, 11, 11, 1),
                color: Color.fromRGBO(242, 214, 214, 1),
                iconData: Icons.wechat_outlined),
            ShowCaseView(
              globalKey: widget.signOut,
              title: "Logout of Your Account",
              description:
                  "Logging out will end your current session and keep your account safe.",
              child: ProfileWidget(
                onTap: () async {
                  signout(student.user.token).then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, Login.route, (route) => false));
                },
                title: S.current.signOut,
                iconColor: Color.fromRGBO(202, 50, 153, 1),
                color: Color.fromRGBO(235, 220, 235, 1),
                iconData: Icons.person_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
