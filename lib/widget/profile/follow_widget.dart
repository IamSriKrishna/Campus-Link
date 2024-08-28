import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/chat/chat_bloc.dart';
import 'package:campuslink/bloc/chat/chat_event.dart';
import 'package:campuslink/bloc/chat/chat_state.dart';
import 'package:campuslink/bloc/follow/follow_bloc.dart';
import 'package:campuslink/bloc/follow/follow_event.dart';
import 'package:campuslink/bloc/follow/follow_state.dart';
import 'package:campuslink/handler/other/other_handler.dart';
import 'package:campuslink/model/student/student.dart';
import 'package:campuslink/provider/auth_provider.dart';
import 'package:campuslink/view/message/message_screen.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:get/get_navigation/get_navigation.dart' as t;

class FollowWidget extends StatefulWidget {
  final Student student;
  const FollowWidget({super.key, required this.student});

  @override
  _FollowWidgetState createState() => _FollowWidgetState();
}

class _FollowWidgetState extends State<FollowWidget> {
  bool _isFollowing = false;
  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    _checkIfFollowing();
  }

  void _checkIfFollowing() {
    final user = Provider.of<AuthProvider>(context, listen: false).user!;
    setState(() {
      _isFollowing = widget.student.followers.contains(user.id);
    });
  }

  void _handleFollowUnfollow() async {
    if (_isButtonDisabled) return;

    if (widget.student.fcmtoken == "") {
      OtherHandler.newUser(widget.student, context);
      return;
    }
    setState(() {
      _isButtonDisabled = true;
    });

    final user = Provider.of<AuthProvider>(context, listen: false).user!;
    if (_isFollowing) {
      context.read<FollowBloc>().add(DoUnFollowEvent(
            followeeId: widget.student.id,
            followerId: user.id,
          ));
      OtherHandler.unfollow(widget.student, context);
    } else {
      context.read<FollowBloc>().add(DoFollowEvent(
            followeeId: widget.student.id,
            followerId: user.id,
          ));
      OtherHandler.follow(widget.student, context);
    }

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _isButtonDisabled = false;
    });
  }

  void _handleMessage() async {
    final chatBloc = context.read<ChatBloc>();
    chatBloc.add(CreateChatEvent(userId: widget.student.id));

    // Ensure the subscription is declared outside to be reused and cancelled
    StreamSubscription<ChatState>? subscription;

    // Listen to the ChatBloc's stream
    subscription = chatBloc.stream.listen((state) {
      //print('State received: $state'); // Add this to debug

      if (state is SuccessChatState) {
        //print('Navigating to MessageScreen'); // Add this to debug

        // Reset message state or perform necessary actions here
        final fcmToken =
            widget.student.fcmtoken.isEmpty ? "null" : widget.student.fcmtoken;
        // Navigate to MessageScreen
        Get.to(
          () => MessageScreen(
            chatId: state.chatId,
            name: widget.student.name,
            token: fcmToken,
            dp: widget.student.dp,
            id: widget.student.id,
          ),
          curve: Curves.linear,
          transition: t.Transition.rightToLeft,
        );

        // Cancel the subscription after handling the state
        subscription?.cancel();
      }
    });

    //print("Subscription active: $subscription");
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user!;

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
        child: BlocListener<FollowBloc, FollowState>(
          listener: (context, state) {
            if (state is SuccessFollowState) {
              setState(() {
                _isFollowing = true;
                widget.student.followers.add(user.id);
              });
            } else if (state is SuccessUnfollowState) {
              setState(() {
                _isFollowing = false;
                widget.student.followers.remove(user.id);
              });
            } else if (state is FailedFollowState) {
              debugPrint(state.error.toString());
              setState(() {
                _isFollowing = false;
                widget.student.followers.remove(user.id);
              });
            }
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _isFollowing
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPalette.mette,
                      minimumSize: Size(double.infinity, 30.h),
                    ),
                    onPressed: _isButtonDisabled ? null : _handleFollowUnfollow,
                    child: Components.googleFonts(
                      text: AppContent.following,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppPalette.mette,
                          minimumSize: Size(155.w, 30.h),
                        ),
                        onPressed:
                            _isButtonDisabled ? null : _handleFollowUnfollow,
                        child: Components.googleFonts(
                          text: AppContent.follow,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0.w),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppPalette.mette,
                            minimumSize: Size(155.w, 30.h),
                          ),
                          onPressed: _handleMessage,
                          child: Components.googleFonts(
                            text: AppContent.message,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
