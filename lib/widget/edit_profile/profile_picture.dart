import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_key.dart';
import 'package:campuslink/bloc/auth/auth_bloc.dart';
import 'package:campuslink/bloc/auth/auth_state.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:campuslink/widget/components/show_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePictureWidget extends StatefulWidget {
  const ProfilePictureWidget({super.key});

  @override
  _ProfilePictureWidgetState createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isSwiped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward().then((value) => _controller.reverse());
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity != null && details.primaryVelocity!.abs() > 0) {
      setState(() {
        _isSwiped = !_isSwiped;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is StudentLoadedState) {
                return GestureDetector(
                  onTap: _onTap,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  child: ScaleTransition(
                    scale: _animation,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(55.sp),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
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
                                imageUrl: AppContent.maleAvatar,
                                width: 90.sp,
                              )
                            : CachedNetworkImage(
                                key: AppKey.profileImage,
                                fit: BoxFit.cover,
                                height: 90.sp,
                                width: 90.sp,
                                imageUrl: state.student.dp,
                              ),
                      ),
                    ),
                  ),
                );
              }
              return const SliverToBoxAdapter();
            },
          ),
          GestureDetector(
            onTap: () {
              ShowWidget.changeProfilePictureandAvatar(
                  context: context, avatar: AppContent.maleAvatar);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0.h),
              child: Components.googleFonts(
                  text: AppContent.editAvatarOrProfile,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
