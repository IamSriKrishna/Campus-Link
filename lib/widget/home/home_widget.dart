import 'package:campuslink/handler/get_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/post/post_bloc.dart';
import 'package:campuslink/bloc/post/post_state.dart';
import 'package:campuslink/model/post/post.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:campuslink/widget/home/image_with_heart.dart';
import 'package:campuslink/widget/home/post_widget.dart';
import 'package:campuslink/widget/home/read_more.dart';
import 'package:iconsax/iconsax.dart';

class HomeWidget {
  static SliverAppBar sliverAppBar({required void Function() onTap}) {
    return SliverAppBar(
      floating: true,
      elevation: 0,
      title: Components.googleFonts(
          text: AppContent.title, fontSize: 18.sp, fontWeight: FontWeight.bold),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: onTap,
          icon: Icon(
            Iconsax.message_text,
            color: AppPalette.mette,
            size: 24.sp,
          ),
        )
      ],
    );
  }

  static Widget post() {
    final userId = StorageUtil.getUserId();
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is FailedPostState) {
          return SliverFillRemaining(
            child: Center(
              child: Components.googleFonts(
                  maxlines: 10,
                  text: state.error,
                  textAlign: TextAlign.center,
                  isContainer: true,
                  padding: EdgeInsets.symmetric(horizontal: 10.w)),
            ),
          );
        }
        if (state is ReadPostState) {
          final sortedPosts = List<Data>.from(state.postModel.data as Iterable)
            ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
          return SliverList.builder(
            itemCount: sortedPosts.length,
            itemBuilder: (context, index) {
              final post = sortedPosts[index];
              final isLikedByCurrentUser =
                  post.likes.any((like) => like.id == userId);
              return Column(
                children: [
                  PostWidget.topWidget(
                      profilePicture: post.sender.dp,
                      username: post.sender.name,
                      year: ""),

                  // Image with heart widget - no need to rebuild the entire post
                  ImageWithHeart(post: post),

                  // Separate the likes and comments to their own rebuildable widgets
                  PostWidget.likesCommentandLength(
                      post: post,
                      isLikedByCurrentUser: isLikedByCurrentUser,
                      context: context),

                  // Only rebuild this widget when likes are updated
                  BlocBuilder<PostBloc, PostState>(
                    buildWhen: (previous, current) {
                      if (current is ReadPostState) {
                        final updatedPost = current.postModel.data.firstWhere(
                            (element) => element.id == post.id,
                            orElse: () => post);
                        return updatedPost.likes.length != post.likes.length;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      return PostWidget.likedBy(post: post);
                    },
                  ),

                  // Read more and other details
                  ReadMoreTextWidget(
                      username: post.sender.name,
                      description: post.description),

                  PostWidget.comments(post: post),
                  PostWidget.date(createdAT: post.createdAt!),
                ],
              );
            },
          );
        }
        return const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        );
      },
    );
  }
}
