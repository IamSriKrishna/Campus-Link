import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';
class ImageWithHeart extends StatefulWidget {
  final String url;

  const ImageWithHeart({super.key, required this.url});

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
    setState(() {
      _showHeart = true;
    });
    _animationController.forward(from: 0.0);
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _showHeart = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _onImageTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ZoomOverlay(
            modalBarrierColor: Colors.black12,
            minScale: 0.5,
            maxScale: 3.0,
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: const Duration(milliseconds: 300),
            twoTouchOnly: false,
            onScaleStart: () {},
            onScaleStop: () {},
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: widget.url,
            ),
          ),
          if (_showHeart)
            ScaleTransition(
              scale: Tween<double>(begin: 0.5, end: 1.5).animate(CurvedAnimation(
                parent: _animationController,
                curve: Curves.elasticOut,
              )),
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
