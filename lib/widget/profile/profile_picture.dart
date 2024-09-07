import 'package:campuslink/app/app_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePicture extends StatefulWidget {
  final String image;
  final String avatar;
  const ProfilePicture({super.key, required this.avatar, required this.image});

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  bool _isSwiped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _startTiltSequence();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward().then((value) => _controller.reverse());
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final rotationValue = details.primaryDelta != null
        ? (details.primaryDelta!.sign * 0.2)
        : 0.0;
    setState(() {
      _rotationAnimation = Tween<double>(begin: 0.0, end: rotationValue).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
      );
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity != null && details.primaryVelocity!.abs() > 0) {
      setState(() {
        _isSwiped = !_isSwiped;
      });
      _controller.reverse(); // Reset the tilt and rotation
    }
  }

  void _startTiltSequence() async {
    await Future.delayed(const Duration(milliseconds: 0));
    _toggleImage();
    await Future.delayed(const Duration(milliseconds: 750));
    _toggleImage();
  }

  void _toggleImage() {
    if (mounted) {
      setState(() {
        _isSwiped = !_isSwiped;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(_rotationAnimation.value),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(55.sp),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                    );
                  },
                  child: _isSwiped
                      ? CachedNetworkImage(
                          key: AppKey.whiteImage,
                          height: 90.sp,
                          imageUrl: widget.avatar,
                          width: 90.sp,
                        )
                      : CachedNetworkImage(
                          key: AppKey.profileImage,
                          fit: BoxFit.cover,
                          height: 90.sp,
                          width: 90.sp,
                          imageUrl: widget.image,
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
