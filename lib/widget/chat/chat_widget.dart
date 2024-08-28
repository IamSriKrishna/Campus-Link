import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/provider/auth_provider.dart';
import 'package:campuslink/view/message/message_screen.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/chat/chat_bloc.dart';
import 'package:campuslink/bloc/chat/chat_state.dart';
import 'package:campuslink/widget/chat/chat_tile_widget.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:campuslink/widget/components/show_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:get/get_navigation/get_navigation.dart' as t;

class ChatWidget {
  static Widget sliverAppBar(
      {required void Function() onTap, required BuildContext context}) {
    final student = Provider.of<AuthProvider>(context).student!;
    return SliverAppBar(
      floating: true,
      backgroundColor: Colors.white,
      leadingWidth: 30.w,
      leading: IconButton(
          onPressed: onTap,
          icon: const Icon(
            Iconsax.arrow_left,
            color: AppPalette.mette,
          )),
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0.w),
            child: Components.googleFonts(
                text: student.name,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
          InkWell(
            onTap: () => ShowWidget.showProfile(
                context: context, dp: student.dp, name: student.name),
            child: const Icon(
              Iconsax.arrow_down_1,
              color: AppPalette.mette,
              //size: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  static Widget searchField() {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 5.h),
      child: Container(
        decoration: BoxDecoration(
            color: AppPalette.mette.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.sp)),
        child: TextField(
          cursorColor: AppPalette.mette,
          decoration: InputDecoration(
              hintText: AppContent.search,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10.sp)),
        ),
      ),
    ));
  }

  static Widget chat(BuildContext context) {
    final student = Provider.of<AuthProvider>(context).student!;
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is LoadingChatState || state is InitialChatState) {
          return const SliverFillRemaining(
            child: Center(
                child: CircularProgressIndicator(
              color: AppPalette.mette,
            )),
          );
        }
        if (state is FailedChatState) {
          return SliverToBoxAdapter(
            child: Center(child: Text('Failed to load chats: ${state.error}')),
          );
        }
        if (state is GetChatState) {
          final chats = state.chatModel.chat;
          final filteredChats = chats
              .where((chat) => chat.users.any((user) => user.id == student.id))
              .toList()
            ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

          return SliverList.builder(
            itemCount: filteredChats.length,
            itemBuilder: (context, index) {
              final chat = filteredChats[index];
              final latestMessage = chat.latestMessage?.content ?? '';

              final oppositeUser = chat.users.firstWhere(
                (user) => user.id != student.id,
              );

              return ChatTile(
                dp: oppositeUser.dp,
                name: oppositeUser.name,
                latestMessage: latestMessage,
                time: chat.updatedAt,
                onTap: () => Get.to(
                    () => MessageScreen(
                          chatId: chat.id,
                          token: oppositeUser.fcmtoken,
                          id: oppositeUser.id,
                          name: oppositeUser.name,
                          dp: oppositeUser.dp,
                        ),
                    curve: Curves.linear,
                    transition: t.Transition.rightToLeft),
              );
            },
          );
        } else {
          return const SliverFillRemaining(
              child: Center(child: Text('No chats available')));
        }
      },
    );
  }
}
