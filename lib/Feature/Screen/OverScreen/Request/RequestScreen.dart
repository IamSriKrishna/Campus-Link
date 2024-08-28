import 'dart:async';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Request/Leave/LeaveWidget/CustomSfCalendar.dart';
import 'package:campuslink/Feature/Service/Authservice.dart';
import 'package:campuslink/Model/approval.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Request/GatePass/GatePass.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Request/ODScreen/ODScreen.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Request/Widget/CustomApprovalWidget.dart';
import 'package:campuslink/Util/util.dart';
import 'package:campuslink/Widget/CustomSliverAppbar.dart/CustomApprovalSliverAppBar.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  AuthService _authService = AuthService();
  late Timer _timer;

  void LoadUp() async {
    await _authService.getUserData(context);
  }

  final List<Approval> approval = [
    Approval(
      credit: 100,
      image: 'asset/forms/od.png',
      percent: 75.5,
      approvalElaborate: S.current.ondutyDetails,
      approval: S.current.onduty,
      color: const LinearGradient(colors: [
        Color.fromRGBO(254, 138, 138, 1),
        Color.fromRGBO(237, 90, 90, 1),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
    ),
    Approval(
      credit: 150,
      image: 'asset/forms/leave.png',
      percent: 75.5,
      approvalElaborate: S.current.leaveDetails,
      approval: S.current.leave,
      color: const LinearGradient(colors: [
        Color.fromARGB(255, 210, 161, 250),
        Color.fromRGBO(175, 75, 255, 1),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
    ),
    Approval(
      credit: 200,
      image: 'asset/forms/gate.png',
      percent: 75.5,
      approvalElaborate: S.current.gatePassDetails,
      approval: S.current.gatePass,
      color: const LinearGradient(colors: [
        Color.fromRGBO(247, 180, 142, 1),
        Color.fromRGBO(255, 121, 44, 1),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
    ),
  ];
  Future<void> OnRefresh() async {
    LoadUp();
    checkBlock();
    setState(() {});
  }

  void checkBlock() {
    final student = Provider.of<StudentProvider>(context, listen: false).user;
    if (student.blocked == true) {
      showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("You have been restricted"),
            content: Text("You have been restricted from using this app."),
            actions: [
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              )
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      LoadUp();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkBlock();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final student =
        Provider.of<StudentProvider>(context, listen: false).user.blocked;
    final theme = Provider.of<DarkThemeProvider>(context);
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
        backgroundColor: theme.getDarkTheme
            ? themeColor.darkTheme
            : themeColor.backgroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              CustomApprovalSliverAppBar(
                text: S.current.approval,
                leadingWidth: 0,
              )
            ];
          },
          body: RefreshIndicator(
            onRefresh: OnRefresh,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.8),
                physics: const BouncingScrollPhysics(),
                itemCount: approval.length,
                itemBuilder: (context, index) {
                  Widget animatedWidget;
                  if (index == 0) {
                    animatedWidget = FadeInLeft(
                      child: GestureDetector(
                        onTap: () {
                          if (student == true) {
                            showCupertinoDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: Text("You have been restricted"),
                                  content: Text(
                                      "You have been restricted from using this app."),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          } else {
                            Navigator.pushNamed(
                              context,
                              ODScreen.route,
                              arguments: {
                                'int': index,
                                'credit': approval[0].credit,
                                'color': approval[0].color,
                              },
                            );
                          }
                        },
                        child: CustomApprovalWidget(
                          color: approval[index].color,
                          title: approval[index].approval,
                          detail: approval[index].approvalElaborate,
                          credit: approval[index].credit,
                          image: approval[index].image,
                        ),
                      ),
                    );
                  } else if (index == 1) {
                    animatedWidget = FadeInRight(
                      child: GestureDetector(
                        onTap: () {
                          if (student == true) {
                            showCupertinoDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: Text("You have been restricted"),
                                  content: Text(
                                      "You have been restricted from using this app."),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          } else {
                            Navigator.pushNamed(
                              context,
                              CustomSFCalendar.route,
                              arguments: {
                                'credit': approval[1].credit,
                                'color': approval[1].color,
                              },
                            );
                          }
                        },
                        child: CustomApprovalWidget(
                          color: approval[index].color,
                          title: approval[index].approval,
                          detail: approval[index].approvalElaborate,
                          credit: approval[index].credit,
                          image: approval[index].image,
                        ),
                      ),
                    );
                  } else {
                    animatedWidget = FadeInUp(
                      child: GestureDetector(
                        onTap: () {
                          if (student == true) {
                            showCupertinoDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: Text("You have been restricted"),
                                  content: Text(
                                      "You have been restricted from using this app."),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          } else {
                            Navigator.pushNamed(
                              context,
                              GatePassScreen.route,
                              arguments: {
                                'credit': approval[2].credit,
                              },
                            );
                          }
                        },
                        child: CustomApprovalWidget(
                          color: approval[index].color,
                          title: approval[index].approval,
                          detail: approval[index].approvalElaborate,
                          credit: approval[index].credit,
                          image: approval[index].image,
                        ),
                      ),
                    );
                  }
                  return animatedWidget;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
