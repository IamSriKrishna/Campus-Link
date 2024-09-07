import 'dart:ui';

import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/post/post_bloc.dart';
import 'package:campuslink/bloc/post/post_event.dart';
import 'package:campuslink/model/post/post.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ImageWithHeart extends StatefulWidget {
  final Data post;
  const ImageWithHeart({super.key, required this.post});

  @override
  _ImageWithHeartState createState() => _ImageWithHeartState();
}

class _ImageWithHeartState extends State<ImageWithHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _showHeart = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onImageTap() {
    context.read<PostBloc>().add(LikePostEvent(postId: widget.post.id));
    setState(() {
      _showHeart = true;
    });
    _animationController.forward(from: 0.0);

    // Check if the widget is still mounted before calling setState
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _showHeart = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _onImageTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: widget.post.imageUrl[0],
            progressIndicatorBuilder: (context, url, progress) => Container(
              height: 180.h,
              width: double.infinity,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  // Glassmorphism effect
                  Center(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: CircularProgressIndicator(
                          value: progress.progress,
                          color: AppPalette.mette,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_showHeart)
            ScaleTransition(
              scale: Tween<double>(begin: 0.5, end: 1.5).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.elasticOut,
                ),
              ),
              child: Icon(
                Icons.favorite,
                color: Colors.red.withOpacity(0.8),
                size: 100.0,
              ),
            ),
        ],
      ),
    );
  }
}
