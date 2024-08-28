import 'dart:typed_data';
import 'dart:ui';

import 'package:campuslink/Widget/CupertinoWidgets/CustomCupertinoModalpop.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:dio/dio.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/showsnackbar.dart';
import 'package:campuslink/Util/util.dart';
import 'package:flutter/material.dart';
import 'package:campuslink/Model/post.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetailsPage extends StatefulWidget {
  final int selectedIndex;
  final List<Post> posts;

  const PostDetailsPage(
      {Key? key, required this.selectedIndex, required this.posts})
      : super(key: key);

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  Future<void> link(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    final filteredPosts =
        widget.posts.sublist(widget.selectedIndex, widget.posts.length);
    return Scaffold(
      backgroundColor: theme.getDarkTheme ? null : Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: theme.getDarkTheme ? null : Colors.white,
            floating: true,
            title: Text("Explore"),
          ),
          SliverList.builder(
            itemCount: filteredPosts.length,
            itemBuilder: (context, index) {
              final post = filteredPosts[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                  ),
                  child: Column(
                    children: [
                      // HEADER SECTION OF THE POST
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 10,
                        ).copyWith(right: 0),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                post.dp,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      post.name.toUpperCase(),
                                      style: GoogleFonts.merriweather(
                                          color: theme.getDarkTheme
                                              ? themeColor.backgroundColor
                                              : themeColor.darkTheme,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return Scaffold(
                                    backgroundColor: Colors.transparent,
                                    body: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 5,
                                        sigmaY: 5,
                                      ),
                                      child: Center(
                                        child: Hero(
                                          tag: '${post.image_url[0]}',
                                          child: PhotoViewGallery.builder(
                                            backgroundDecoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            itemCount: post.image_url.length,
                                            builder: (context, index) {
                                              return PhotoViewGalleryPageOptions(
                                                imageProvider: NetworkImage(
                                                    post.image_url[index]),
                                                initialScale:
                                                    PhotoViewComputedScale
                                                        .contained,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(0.0, 1.0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Hero(
                              tag: '${post.image_url[0]}',
                              child: Image.network(
                                post.image_url[0],
                                fit: BoxFit.fitWidth,
                              ))),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              CustomCupertinoModalPop(
                                  context: context,
                                  content: S.current.development);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 5),
                              child: Icon(Icons.favorite_border),
                            ),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.comment_outlined,
                                color: theme.getDarkTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              onPressed: () {
                                CustomCupertinoModalPop(
                                    context: context,
                                    content: S.current.development);
                              }),
                          IconButton(
                              icon: Icon(
                                Icons.send_outlined,
                                color: theme.getDarkTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              onPressed: () {
                                CustomCupertinoModalPop(
                                    context: context,
                                    content: S.current.development);
                              }),
                          Expanded(
                              child: Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                                icon: Icon(
                                  Icons.download,
                                  color: theme.getDarkTheme
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                onPressed: () async {
                                  var response = await Dio().get(
                                      post.image_url[0],
                                      options: Options(
                                          responseType: ResponseType.bytes));

                                  final result =
                                      await ImageGallerySaver.saveImage(
                                          Uint8List.fromList(response.data),
                                          quality: 60,
                                          name: "Campus~link");
                                  showSnackBar(
                                      context: context, text: 'Downloaded');
                                  print(result);
                                }),
                          ))
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                top: 8,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.merriweather(
                                      color: theme.getDarkTheme
                                          ? themeColor.backgroundColor
                                          : themeColor.darkTheme),
                                  children: [
                                    TextSpan(
                                      text: 'Title:${post.title}',
                                      style: GoogleFonts.merriweather(
                                          color: theme.getDarkTheme
                                              ? themeColor.backgroundColor
                                              : themeColor.darkTheme),
                                    ),
                                    TextSpan(
                                      text: '\nDescription:${post.description}',
                                      style: GoogleFonts.merriweather(
                                          color: theme.getDarkTheme
                                              ? themeColor.backgroundColor
                                              : themeColor.darkTheme),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            post.link != 'null'
                                ? Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: Text(
                                            'Link:',
                                            style: GoogleFonts.merriweather(
                                                color: theme.getDarkTheme
                                                    ? themeColor.backgroundColor
                                                    : themeColor.darkTheme,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: InkWell(
                                                onTap: () {
                                                  link(Uri.parse(post.link));
                                                },
                                                child: Text(
                                                  post.link,
                                                  maxLines: 3,
                                                  style:
                                                      GoogleFonts.merriweather(
                                                          color: Colors.blue,
                                                          fontSize: 14,
                                                          textBaseline:
                                                              TextBaseline
                                                                  .alphabetic,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                DateFormat.yMMMd().format(post.createdAt),
                                style: GoogleFonts.merriweather(
                                    color: theme.getDarkTheme
                                        ? themeColor.backgroundColor
                                        : themeColor.darkTheme,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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
