import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:campuslink/Feature/Service/FollowerORFollowing.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/FontStyle/RobotoBoldFont.dart';
import 'package:campuslink/Util/FontStyle/RobotoRegularFont.dart';
import 'package:campuslink/Util/util.dart';
import 'package:provider/provider.dart';

class MyProfileTopScreen extends StatefulWidget {
  final String department;
  final String name;
  final String dp;

  const MyProfileTopScreen({
    Key? key,
    required this.name,
    required this.department,
    required this.dp,
  }) : super(key: key);

  @override
  State<MyProfileTopScreen> createState() => _MyProfileTopScreenState();
}

class _MyProfileTopScreenState extends State<MyProfileTopScreen> {
  FollowersOrFollowing _followersOrFollowing = FollowersOrFollowing();
  int _followersCount = 0;
  int _followingCount = 0;

  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      _getFollowersCount();
      _getFollowingCount();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> _getFollowersCount() async {
    try {
      int followers = await _followersOrFollowing.getMyFollowersCount();
      if (mounted) {
        setState(() {
          _followersCount = followers;
        });
      }
    } catch (e) {
      print("Error getting followers count: $e");
      // Handle error accordingly
    }
  }

  Future<void> _getFollowingCount() async {
    try {
      int following = await _followersOrFollowing.getMyFollowingCount();
      if (mounted) {
        setState(() {
          _followingCount = following;
        });
      }
    } catch (e) {
      print("Error getting following count: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.height * 0.16,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            //color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //profile Picture
                InkWell(
                  onLongPress: () {
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: widget.dp,
                            fit: BoxFit.contain,
                            progressIndicatorBuilder: (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                color: theme.getDarkTheme ? themeColor.themeColor : themeColor.darkTheme,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: widget.dp,
                      width: MediaQuery.of(context).size.width * 0.215,
                      height: MediaQuery.of(context).size.height * 0.095,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, progress) => Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: theme.getDarkTheme ? themeColor.themeColor : themeColor.darkTheme,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.67,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$_followersCount',
                            style: TextStyle(color: theme.getDarkTheme ? Colors.white : Colors.black),
                          ),
                          RobotoBoldFont(
                            text: 'Followers',
                            textColor: theme.getDarkTheme ? Colors.white : Colors.black,
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$_followingCount',
                            style: TextStyle(color: theme.getDarkTheme ? Colors.white : Colors.black),
                          ),
                          RobotoBoldFont(
                            text: 'Following',
                            textColor: theme.getDarkTheme ? Colors.white : Colors.black,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Student Name
                RobotoBoldFont(
                  text: widget.name,
                  textColor: theme.getDarkTheme ? Colors.white : Colors.black,
                ),
                //Student Department
                RobotoRegularFont(
                  text: '(${widget.department})',
                  fontWeight: FontWeight.w100,
                  size: 11.5,
                  textColor: theme.getDarkTheme ? Colors.white : Colors.black,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
