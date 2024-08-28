import 'dart:async';
import 'dart:io';
import 'package:campuslink/Feature/Screen/OverScreen/Home/Widget/HomeAppbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Home/Widget/Additional/PostCard.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Home/Widget/Additional/TopMainScreen.dart';
import 'package:campuslink/Model/post.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class MainScreen extends StatefulWidget {
  final List<Post> fetchpost;
  final void Function() icon1OnTap;

  const MainScreen(
      {super.key, required this.icon1OnTap, required this.fetchpost});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey search = GlobalKey();
  final GlobalKey message = GlobalKey();
  final GlobalKey friend = GlobalKey();
  ScrollController _scrollController = ScrollController();
  bool _show = true;
  Future<void> checkShowcaseStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final showcaseShown = prefs.getBool('showcaseShown2') ?? false;

    if (!showcaseShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([search, message, friend]);
      });

      await prefs.setBool('showcaseShown2', true);
    }
  }

  @override
  void initState() {
    super.initState();
    checkShowcaseStatus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void updateShow(bool value) {
      setState(() {
        _show = value;
      });
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        await showCupertinoModalPopup<void>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text(
              S.current.warning,
              style: GoogleFonts.merriweather(),
            ),
            content: Text(
              S.current.wanttoexitcampuslink,
              style: GoogleFonts.merriweather(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  S.current.no,
                  style: GoogleFonts.merriweather(color: Colors.blue),
                ),
              ),
              TextButton(
                onPressed: () {
                  exit(0);
                },
                child: Text(
                  S.current.yes,
                  style: GoogleFonts.merriweather(color: Colors.blue),
                ),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            HomeAppBar(
                icon1OnTap: widget.icon1OnTap,
                friend: friend,
                scrollController: _scrollController,
                updateShow: updateShow,
                message: message,
                search: search),
            SliverToBoxAdapter(
              child: TopMainScreen(context: context),
            ),
            _show == false
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        if (widget.fetchpost.isEmpty) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final student = widget.fetchpost
                            .where((form) => form.myClass != "All")
                            .toList();

                        if (student.isEmpty) {
                          return Center(
                            child: Text('No posts found.'),
                          );
                        }

                        final reversedIndex = student.length - 1 - index;
                        final productData = student[reversedIndex];

                        return PostCard(
                          title: productData.title,
                          dp: productData.dp,
                          pdfUrl: productData.pdfUrl,
                          postId: productData.id,
                          certified: productData.certified,
                          senderId: productData.senderId,
                          createdAt: productData.createdAt,
                          images: productData.image_url,
                          description: productData.description,
                          likes: productData.likes,
                          link: productData.link,
                          name: productData.name,
                        );
                      },
                      childCount: widget.fetchpost
                          .where((form) => form.myClass != "All")
                          .length,
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        if (widget.fetchpost.isEmpty) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final student = widget.fetchpost
                            .where((form) => form.myClass == "All")
                            .toList();

                        if (student.isEmpty) {
                          return Center(
                            child: Text('No posts found.'),
                          );
                        }

                        final reversedIndex = student.length - 1 - index;
                        final productData = student[reversedIndex];

                        return PostCard(
                          title: productData.title,
                          dp: productData.dp,
                          createdAt: productData.createdAt,
                          senderId: productData.senderId,
                          postId: productData.id,
                          pdfUrl: productData.pdfUrl,
                          images: productData.image_url,
                          description: productData.description,
                          certified: productData.certified,
                          likes: productData.likes,
                          link: productData.link,
                          name: productData.name,
                        );
                      },
                      childCount: widget.fetchpost
                          .where((form) => form.myClass == 'All')
                          .length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
