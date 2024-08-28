import 'dart:async';
import 'dart:convert';
import 'package:campuslink/Feature/Screen/OverScreen/Home/HomeScreen.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Home/Widget/Additional/TopMainScreen.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Home/Widget/HomeAppbar.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Home/Widget/HomeShimmer.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Profile/ProfileScreen.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Request/RequestScreen.dart';
import 'package:campuslink/Feature/Service/postService.dart';
import 'package:campuslink/Model/post.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/Additional/Page.dart';
import 'package:campuslink/Util/CustomBottomBavigation/CustomCurvedNavigation.dart';
import 'package:campuslink/Util/util.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:http/http.dart' as http;

class OverScreen extends StatefulWidget {
  static const route = '/OverScreen';
  const OverScreen({super.key});

  @override
  State<OverScreen> createState() => _OverScreenState();
}

class _OverScreenState extends State<OverScreen> {
  String bio = '';
  late StreamSubscription subscription;
  bool isLoading = true;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  late Timer _timer;
  List<Post>? fetchpost;
  final AddPostService _postService = AddPostService();
  Future<void> fetchBio() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http
          .get(Uri.parse('$uri/students/bio/6557a3ec1422855d921b50bc'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          bio = jsonData['bio'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load bio');
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchPosts() async {
    try {
      fetchpost = await _postService.DisplayAllForm(context: context);
      fetchpost!.map((post) => post.toJson()).toList();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            // Check if the widget is still mounted before showing the dialog
            if (mounted) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          }
        },
      );
  @override
  void initState() {
    super.initState();
    fetchPosts();
      fetchBio();
    getConnectivity();
  }

  int _currentIndex = 0;
  @override
  void dispose() {
    subscription.cancel();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> page = [
      fetchpost != null
          ? HomeScreen(
              fetchpost: fetchpost!,
            )
          : Scaffold(
              body: CustomScrollView(
                slivers: [
                  HomeAppBarDummy(),
                  SliverToBoxAdapter(
                    child: TopMainScreen(context: context),
                  ),
                  SliverList.builder(
                    itemBuilder: (context, index) {
                      return HomeShimmer();
                    },
                  )
                ],
              ),
            ), // or any other loading indicator,
      //KcgptChat(),
      RequestScreen(),
      // TimeTableScreen(),
      ShowCaseWidget(builder: Builder(builder: (context) => ProfileScreen(upiId:bio))),
    ];
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: theme.getDarkTheme
          ? themeColor.darkTheme
          : themeColor.backgroundColor,
      body: page[_currentIndex],
      bottomNavigationBar: CustomCurvedNavigation(
        backgroundColor: screenBackGroundColor[_currentIndex],
        onTabChange: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        index: _currentIndex,
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
