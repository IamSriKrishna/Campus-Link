import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/message/message_bloc.dart';
import 'package:campuslink/bloc/message/message_state.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MessageWidget {
  static Widget sliverAppBar({required String name, required String dp}) {
    return BlocBuilder<MessageBloc, MessageState>(
      buildWhen: (previous, current) {
        return current is OnlineMessageState || previous is OnlineMessageState;
      },
      builder: (context, state) {
        bool isOnline = false;
        if (state is OnlineMessageState) {
          isOnline = state.isOnline;
          
        }

        return SliverAppBar(
          floating: false,
          elevation: 0,
          pinned: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Iconsax.arrow_left,
              color: AppPalette.mette,
            ),
          ),
          backgroundColor: Colors.white,
          leadingWidth: 20.w,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(17.sw),
                  child: CachedNetworkImage(
                      fit: BoxFit.cover, height: 35, width: 35, imageUrl: dp)),
              Padding(
                padding: EdgeInsets.only(left: 5.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Components.googleFonts(
                      text: name,
                    ),
                    Components.googleFonts(
                        text: isOnline ? "online" : "offline"),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static Widget message(
      {required ScrollController scrollController, required String id}) {
    return BlocBuilder<MessageBloc, MessageState>(
      buildWhen: (previous, current) {
        return current is GetMessageState; // Rebuild only on relevant states
      },
      builder: (context, state) {
        if (state is InitialMessageState) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: CircularProgressIndicator(
                color: AppPalette.mette,
              ),
            ),
          );
        } else if (state is FailedMessageState) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Components.googleFonts(text: state.error.toString()),
            ),
          );
        } else if (state is GetMessageState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var message = state.messageModel.chat[index];
                bool isMe = message.sender.id != id;
                return Align(
                  key: ValueKey(message.createdAt),
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!isMe)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(17.sw),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 35,
                            width: 35,
                            imageUrl: message.sender.dp,
                          ),
                        ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 14.w),
                        margin: EdgeInsets.symmetric(
                            vertical: 4.h, horizontal: 5.w),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Components.googleFonts(
                          text: message.content,
                          maxlines: 100,
                          fontSize: 14.sp,
                          color: isMe ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: state.messageModel.chat.length,
            ),
          );
        }
        return const SliverToBoxAdapter();
      },
    );
  }

  static Widget sendMessage(
      {required BuildContext context,
      required void Function() onTap,
      required TextEditingController controller}) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        children: [
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppPalette.mette),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppPalette.mette),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: onTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
