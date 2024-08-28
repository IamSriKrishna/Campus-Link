// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';
import 'dart:ui';
import 'package:campuslink/Feature/Screen/OverScreen/Home/Widget/Additional/PDFView.dart';
import 'package:campuslink/Feature/Service/postService.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/showsnackbar.dart';
import 'package:campuslink/Util/util.dart';
import 'package:campuslink/Widget/CupertinoWidgets/CustomCupertinoModalpop.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

class PostCard extends StatefulWidget {
  final String dp;
  final String name;
  final String title;
  final String description;
  final String pdfUrl;
  final String postId;
  final String certified;
  final List<String> likes;
  final List<String> images;
  final String senderId;
  final String link;
  final DateTime createdAt;
  const PostCard(
      {Key? key,
      required this.title,
      required this.dp,
      required this.images,
      required this.postId,
      required this.description,
      required this.certified,
      required this.likes,
      required this.pdfUrl,
      required this.senderId,
      required this.link,
      required this.name,
      required this.createdAt})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  AddPostService _addPostService = AddPostService();
  int currentImage = 0;
  Future<void> link(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  bool isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    final student = Provider.of<StudentProvider>(context).user;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.getDarkTheme ? Colors.transparent : Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          children: [
            // HEADER SECTION OF THE POST
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ).copyWith(right: 0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      widget.dp,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            widget.name.toUpperCase(),
                            style: GoogleFonts.merriweather(
                                color: theme.getDarkTheme
                                    ? themeColor.backgroundColor
                                    : themeColor.darkTheme,
                                fontSize: 12),
                          ),
                          widget.certified != "No"
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0, bottom: 5),
                                  child: Image.asset(
                                    'asset/tick.png',
                                    height: 15,
                                  ),
                                )
                              : Container(),
                          widget.name == "SRI KRISHNA M"
                              ? Text(
                                  "(Developer)",
                                  style: TextStyle(fontSize: 9),
                                )
                              : Text('')
                        ],
                      ),
                    ),
                  ),
                  widget.senderId == student.id
                      ? InkWell(
                          onTap: () {
                            showCupertinoDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title: Text("Warning!!!"),
                                content: Text(
                                    'Are You Sure, You Want To Delete This Post?'),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      _addPostService.deletePost(
                                          widget.postId, context);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Sure'),
                                    textStyle: TextStyle(color: Colors.red),
                                  ),
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                    textStyle: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            );
                          },
                          child: Icon(Icons.more_vert))
                      : Container()
                ],
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return Scaffold(
                          backgroundColor: Colors
                              .transparent, // Make scaffold background transparent
                          body: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5, // Adjust the blur effect here
                              sigmaY: 5, // Adjust the blur effect here
                            ),
                            child: Stack(
                              children: [
                                Hero(
                                  tag: '${widget.images[0]}',
                                  child: PhotoViewGallery.builder(
                                    onPageChanged: (index) {
                                      setState(() {
                                        currentImage = index;
                                        print(currentImage);
                                      });
                                    },
                                    pageController: PageController(
                                      initialPage: currentImage,
                                    ),
                                    scrollPhysics:
                                        RangeMaintainingScrollPhysics(),
                                    backgroundDecoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    itemCount: widget.images.length,
                                    builder: (context, index) {
                                      return PhotoViewGalleryPageOptions(
                                        imageProvider:
                                            NetworkImage(widget.images[index]),
                                        initialScale:
                                            PhotoViewComputedScale.contained,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
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
                    tag: '${widget.images[0]}',
                    child: CarouselSlider(
                      items: widget.images.map(
                        (i) {
                          return Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit
                                        .fitWidth, // Set fit property to cover

                                    image: NetworkImage(i))),
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        scrollPhysics: BouncingScrollPhysics(),
                        enableInfiniteScroll: false,
                        height: MediaQuery.of(context).size.height * 0.5,
                        initialPage: currentImage,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentImage = index;
                            print(currentImage);
                          });
                        },
                        viewportFraction: 1,
                      ),
                    ))),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        CustomCupertinoModalPop(
                            context: context, content: S.current.development);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 5),
                        child: Icon(Icons.favorite_border),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.comment_outlined,
                          color:
                              theme.getDarkTheme ? Colors.white : Colors.black,
                        ),
                        onPressed: () {
                          CustomCupertinoModalPop(
                              context: context, content: S.current.development);
                        }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.images.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => setState(() => currentImage = entry.key),
                        child: Container(
                          width: 7.0,
                          height: 7.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        currentImage == entry.key ? 0.9 : 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.download,
                      color: theme.getDarkTheme ? Colors.white : Colors.black,
                    ),
                    onPressed: () async {
                      var response = await Dio().get(widget.images[0],
                          options: Options(responseType: ResponseType.bytes));

                      final result = await ImageGallerySaver.saveImage(
                          Uint8List.fromList(response.data),
                          quality: 60,
                          name: "Campus~link");
                      showSnackBar(context: context, text: 'Downloaded');
                      print(result);
                    })
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
                            text: 'Title:${widget.title}',
                            style: GoogleFonts.merriweather(
                                color: theme.getDarkTheme
                                    ? themeColor.backgroundColor
                                    : themeColor.darkTheme),
                          ),
                          TextSpan(
                            text: '\nDescription:${widget.description}',
                            style: GoogleFonts.merriweather(
                                color: theme.getDarkTheme
                                    ? themeColor.backgroundColor
                                    : themeColor.darkTheme),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.link != 'null'
                      ? Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
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
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: InkWell(
                                      onTap: () {
                                        link(Uri.parse(widget.link));
                                      },
                                      child: Text(
                                        widget.link,
                                        maxLines: 3,
                                        style: GoogleFonts.merriweather(
                                            color: Colors.blue,
                                            fontSize: 14,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            decoration:
                                                TextDecoration.underline),
                                      )),
                                ),
                              )
                            ],
                          ),
                        )
                      : SizedBox(),
                  widget.pdfUrl.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            Get.to(()=>PDFViewerCachedFromUrl(url: widget.pdfUrl));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.picture_as_pdf),
                              Text(
                                '\nClick here to View PDF\n',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      DateFormat.yMMMd().format(widget.createdAt),
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
  }
}
