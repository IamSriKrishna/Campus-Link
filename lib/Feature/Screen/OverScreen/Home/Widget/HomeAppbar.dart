// ignore_for_file: must_be_immutable

import 'package:campuslink/Constrains/Component.dart';
import 'package:campuslink/Feature/Screen/MainSearch/MainSearch.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/FontStyle/RobotoBoldFont.dart';
import 'package:campuslink/Util/util.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatefulWidget {
  final void Function(bool) updateShow;
  final GlobalKey message;
  final ScrollController scrollController;
  final GlobalKey friend;
  final GlobalKey search;
  final void Function() icon1OnTap;
  HomeAppBar(
      {super.key,
      required this.updateShow,
      required this.icon1OnTap,
      required this.friend,
      required this.scrollController,
      required this.message,
      required this.search});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return SliverAppBar(
      floating: true,
      leadingWidth: MediaQuery.of(context).size.width * 0.55,
      backgroundColor:
          theme.getDarkTheme ? themeColor.darkTheme : themeColor.themeColor,
      leading: Row(
        children: [
          InkWell(
            onTap: () {
              showPopupMenu(context);
            },
            child: ShowCaseView(
              globalKey: widget.friend,
              title: 'All/Friends',
              description:
                  "Ensuring you never miss the most important posts from both your wider network and your closest friends",
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Icon(Icons.more_vert),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              widget.scrollController.animateTo(
                0.0,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
            child: RobotoBoldFont(
              size: 18,
              text: S.current.myClass,
              textColor: theme.getDarkTheme
                  ? themeColor.backgroundColor
                  : themeColor.appBarColor,
            ),
          ),
        ],
      ),
      elevation: 10,
      actions: [
        InkWell(
          onTap: () {
            Get.to(() => MainSearch());
          },
          child: ShowCaseView(
            globalKey: widget.search,
            title: 'Search Screen',
            description: "Find College Students Easily",
            child: Hero(
              tag: 1,
              child: Icon(
                Icons.search,
                color: theme.getDarkTheme
                    ? themeColor.themeColor
                    : themeColor.appBarColor,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: widget.icon1OnTap,
          child: ShowCaseView(
              globalKey: widget.message,
              title: 'Messenger',
              description:
                  "Stay connected anytime, anywhere with our Messenger. Chat, share, and connect effortlessly with classmates.",
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, bottom: 19, top: 17, right: 15),
                child: Image.asset('asset/message.png'),
              )),
        ),
      ],
    );
  }

  // Function to show the PopupMenu
  void showPopupMenu(BuildContext context) {
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(-5, 1, 0, 0),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        items: [
          PopupMenuItem(
            value: 'Friends/Mutual',
            onTap: () {
              setState(() {
                widget.updateShow(false);
              });
              //Navigator.pop(context);
            },
            child: Text('Friends/Mutual'),
          ),
          PopupMenuItem(
            value: 'All',
            onTap: () {
              setState(() {
               widget.updateShow(true);
              });
              //Navigator.pop(context);
            },
            child: Text('All'),
          ),
        ]);
  }
}

class HomeAppBarDummy extends StatefulWidget {
  HomeAppBarDummy(
      {super.key,});

  @override
  State<HomeAppBarDummy> createState() => _HomeAppBarDummyState();
}

class _HomeAppBarDummyState extends State<HomeAppBarDummy> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return SliverAppBar(
      floating: true,
      leadingWidth: MediaQuery.of(context).size.width * 0.55,
      backgroundColor:
          theme.getDarkTheme ? themeColor.darkTheme : themeColor.themeColor,
      leading: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Icon(Icons.more_vert),
          ),
          RobotoBoldFont(
            size: 18,
            text: S.current.myClass,
            textColor: theme.getDarkTheme
                ? themeColor.backgroundColor
                : themeColor.appBarColor,
          ),
        ],
      ),
      elevation: 10,
      actions: [
        Hero(
          tag: 1,
          child: Icon(
            Icons.search,
            color: theme.getDarkTheme
                ? themeColor.themeColor
                : themeColor.appBarColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0, bottom: 19, top: 17, right: 15),
          child: Image.asset('asset/message.png'),
        ),
      ],
    );
  }}