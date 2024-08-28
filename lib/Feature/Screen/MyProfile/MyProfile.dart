import 'dart:async';

import 'package:campuslink/Feature/Screen/AddPost/AddPost.dart';
import 'package:campuslink/Feature/Screen/Game/BrickBreak.dart';
import 'package:campuslink/Feature/Screen/Payment/Payment.dart';
import 'package:campuslink/Feature/Service/postService.dart';
import 'package:campuslink/Model/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:campuslink/Feature/Screen/MyProfile/EditProfile.dart';
import 'package:campuslink/Feature/Screen/MyProfile/Widget/MyProfileBottomCheet.dart';
import 'package:campuslink/Feature/Screen/MyProfile/Widget/MyProfileTopScreen.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:campuslink/Util/FontStyle/RobotoBoldFont.dart';
import 'package:campuslink/Util/util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  static const route = '/MyProfile';
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late Timer _timer;
  List<Post>? fetchpost;
  final AddPostService _postService = AddPostService();
  bool _isMounted = false;
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

  //bool _animate = false;

  // @override
  // void initState() {
  //   _animate = true;
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _animate = false;
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final my = Provider.of<StudentProvider>(context).user;
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          leadingWidth: MediaQuery.of(context).size.width * 0.45,
          leading: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: RobotoBoldFont(
                  text: my.rollno,
                  size: 20,
                ),
              ),
              my.certified == true
                  ? Image.asset(
                      'asset/tick.png',
                      height: MediaQuery.of(context).size.height * 0.02,
                    )
                  : Text('')
            ],
          ),
          actions: [
            my.blocked == true
                ? Container()
                : InkWell(
                    onTap: () {
                      showPopupMenu(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Icon(Icons.more_vert),
                    ),
                  )
            // : AvatarGlow(
            //     duration: Duration(seconds: 2),
            //     glowColor: Colors.blue,
            //     glowRadiusFactor: 10,
            //     glowShape: BoxShape.circle,
            //     animate: _animate,
            //     curve: Curves.easeIn,
            //     child: IconButton(
            //         onPressed: () {
            //           Get.to(() => Payment(),
            //               transition: Transition.fadeIn,
            //               duration: Duration(milliseconds: 700));
            //         },
            //         icon: Icon(
            //           Icons.qr_code_scanner,
            //           color: Colors.blue,
            //         )),
            //   )
          ],
          backgroundColor:
              theme.getDarkTheme ? themeColor.darkTheme : themeColor.themeColor,
        ),
        SliverToBoxAdapter(
          child: MyProfileTopScreen(
              name: my.name, department: my.department, dp: my.dp),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5.5,
                        fixedSize: Size(
                            MediaQuery.of(context).size.width * 0.35,
                            MediaQuery.of(context).size.height * 0.03),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.5)),
                        backgroundColor: themeColor.appThemeColor,
                        foregroundColor: themeColor.themeColor),
                    onPressed: () {
                      Get.to(() => EditProfile());
                      //Navigator.pushNamed(context, EditProfile.route);
                    },
                    child: RobotoBoldFont(
                      text: 'Edit Profile',
                      size: 12,
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5.5,
                        fixedSize: Size(
                            MediaQuery.of(context).size.width * 0.35,
                            MediaQuery.of(context).size.height * 0.03),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.5)),
                        backgroundColor: themeColor.appThemeColor,
                        foregroundColor: themeColor.themeColor),
                    onPressed: () {
                      MyProfileBottomSheet(context: context);
                    },
                    child: RobotoBoldFont(
                      text: 'Academic',
                      size: 12,
                    )),
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
                  thickness: 1.45,
                  color: theme.getDarkTheme
                      ? themeColor.appThemeColor2.withOpacity(0.5)
                      : Colors.black12,
                ),
              ],
            ),
          ),
        ),
        fetchpost
                    ?.where((form) =>
                        form.myClass != "All" && form.senderId == my.id)
                    .length !=
                0
            ? SliverGrid.builder(
                itemCount:
                    fetchpost?.where((form) => form.myClass != "All").length ??
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
                      .where((form) => form.myClass != "All")
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
    ));
  }

  // Function to show the PopupMenu
  void showPopupMenu(BuildContext context) {
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(0, 1, -5, 0),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        items: [
          PopupMenuItem(
            value: 'Scan Qr Code',
            onTap: () {
              Get.to(() => Payment(),
                  transition: Transition.fadeIn,
                  duration: Duration(milliseconds: 250));
            },
            child: Text('Scan Qr Code'),
          ),
          PopupMenuItem(
            value: 'Add Post',
            onTap: () {
              Get.to(() => AddPostScreen());
            },
            child: Text('Add Post'),
          ),
        ]);
  }
}
