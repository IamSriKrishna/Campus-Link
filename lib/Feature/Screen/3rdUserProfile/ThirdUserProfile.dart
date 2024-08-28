import 'dart:async';

import 'package:campuslink/Feature/Screen/Game/BrickBreak.dart';
import 'package:campuslink/Feature/Service/postService.dart';
import 'package:campuslink/Model/post.dart';
import 'package:flutter/material.dart';
import 'package:campuslink/Feature/Screen/3rdUserProfile/Widget/ThirdUserProfileTopScreen.dart';
import 'package:campuslink/Feature/Screen/3rdUserProfile/Widget/profileButton.dart';
import 'package:campuslink/Feature/Service/Chat/ChatService.dart';
import 'package:campuslink/Feature/Service/FollowerORFollowing.dart';
import 'package:campuslink/Feature/Service/NotificationService.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:campuslink/Util/FontStyle/RobotoBoldFont.dart';
import 'package:campuslink/Util/showsnackbar.dart';
import 'package:campuslink/Util/util.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThirdUserProfile extends StatefulWidget {
  final String rollno;
  final String name;
  final String index;
  final String department;
  final bool certified;
  final String dp;
  final String id;
  final String fcmtoken;
  final String current_student_id;
  static const route = '/ThirdUserProfile';
  const ThirdUserProfile(
      {super.key,
      required this.name,
      required this.department,
      required this.rollno,
      required this.index,
      required this.dp,
      required this.certified,
      required this.id,
      required this.fcmtoken,
      required this.current_student_id});

  @override
  State<ThirdUserProfile> createState() => _ThirdUserProfileState();
}

class _ThirdUserProfileState extends State<ThirdUserProfile> {
  List<Post>? fetchpost;
  NotificationService _notificationService = NotificationService();
  FollowersOrFollowing _followersOrFollowing = FollowersOrFollowing();
  bool _isfollowing = false;
  late Timer _timer;
  bool _isMounted = false;
  final AddPostService _postService = AddPostService();
  Future<void> loadLocalPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? storedPosts = prefs.getStringList('fetchpost');
    if (storedPosts != null) {
      fetchpost =
          storedPosts.map((jsonString) => Post.fromJson(jsonString)).toList();
      if (_isMounted) {
        setState(() {});
      }
    }
  }

  Future<void> fetchAndStorePostsLocally() async {
    try {
      fetchpost = await _postService.DisplayAllForm(context: context);
      if (_isMounted) {
        // Store fetchpost locally
        final prefs = await SharedPreferences.getInstance();
        prefs.setStringList(
            'fetchpost', fetchpost!.map((post) => post.toJson()).toList());
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      loadLocalPosts();
      fetchAndStorePostsLocally();
    });
  }

  @override
  void dispose() {
    _isMounted = false;
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final my = Provider.of<StudentProvider>(context).user;
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            leadingWidth: double.infinity,
            leading: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: RobotoBoldFont(
                    text: widget.rollno,
                    size: 20,
                  ),
                ),
                widget.certified == true
                    ? Image.asset(
                        'asset/tick.png',
                        height: MediaQuery.of(context).size.height * 0.02,
                      )
                    : Text(''),
                widget.rollno == '311021104111'
                    ? Text(
                        "(Developer)",
                        style: TextStyle(fontSize: 9),
                      )
                    : Text('')
              ],
            ),
            backgroundColor: theme.getDarkTheme
                ? themeColor.darkTheme
                : themeColor.themeColor,
          ),
          SliverToBoxAdapter(
            child: ThirdUserProfileTopScreen(
              name: widget.name,
              department: widget.department,
              index: widget.index,
              dp: widget.dp,
              thirdUserid: widget.id,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  profileButton(
                      backgroundColor: _isfollowing == true
                          ? themeColor.appThemeColor
                          : my.following.contains(widget.id)
                              ? themeColor.appThemeColor
                              : themeColor.appThemeColor2,
                      foregroundColor: themeColor.themeColor,
                      onPressed: () {
                        if (my.following.contains(widget.id) ||
                            _isfollowing == true) {
                          print('unfollow');
                        } else {
                          setState(() {
                            _isfollowing = true;
                          });
                          _followersOrFollowing.addFollowing(widget.id);
                          _followersOrFollowing
                              .addFollowerbyThirdUser(widget.id);
                          _notificationService.sendNotifications(
                              context: context,
                              toAllFaculty: [widget.fcmtoken],
                              body: '${my.name} Started Following You :)');
                        }
                      },
                      text: _isfollowing == true
                          ? 'Following'
                          : my.following.contains(widget.id)
                              ? 'following'
                              : 'follow'),
                  profileButton(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.black,
                      onPressed: () async {
                        await ChatHelper.apply(widget.id.toString());
                        _notificationService.sendNotifications(
                            context: context,
                            toAllFaculty: [widget.fcmtoken],
                            body: '${my.name}\nWants to say Something :)');
                        showSnackBar(
                            context: context,
                            text:
                                'Go to messenger to chat with ${widget.name}');
                      },
                      text: 'Add To Messenger'),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Icon(Icons.grid_view),
                  Divider(
                    endIndent: MediaQuery.of(context).size.width * 0.05,
                    indent: MediaQuery.of(context).size.width * 0.05,
                    thickness: 2,
                  ),
                ],
              ),
            ),
          ),
          fetchpost
                      ?.where((form) =>
                          form.myClass != "All" && form.senderId == widget.id)
                      .length !=
                  0
              ? SliverGrid.builder(
                  itemCount: fetchpost
                          ?.where((form) =>
                              form.myClass != "All" &&
                              form.senderId == widget.id)
                          .length ??
                      0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemBuilder: (context, index) {
                    if (fetchpost == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final student = fetchpost!
                        .where((form) =>
                            form.myClass != "All" && form.senderId == widget.id)
                        .toList();

                    if (student.isEmpty) {
                      return Center(
                        child: Text('No posts found.'),
                      );
                    }

                    final reversedIndex = student.length - 1 - index;
                    final productData = student[reversedIndex];

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                          image: NetworkImage(productData.image_url[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                )
              : SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (index == 5) {
                          Get.to(() => BrickBreaker());
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    );
                  },
                )
        ],
      ),
    );
  }
}
