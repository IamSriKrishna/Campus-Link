import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_key.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/post/post_bloc.dart';
import 'package:campuslink/bloc/post/post_state.dart';
import 'package:campuslink/bloc/student/student_bloc.dart';
import 'package:campuslink/bloc/student/student_state.dart';
import 'package:campuslink/model/post/post.dart';
import 'package:campuslink/provider/auth_provider.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:campuslink/widget/home/image_with_heart.dart';
import 'package:campuslink/widget/home/post_widget.dart';
import 'package:campuslink/widget/home/read_more.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

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

  static Widget story(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user!;
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is FetchStudentSuccessState) {
          if (state.student.following.isNotEmpty) {
            return SliverToBoxAdapter(
              child: SizedBox(
                width: double.infinity,
                height: 65.h,
                child: ListView.builder(
                  key: const PageStorageKey<String>(AppKey.story),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.student.following.length,
                  itemBuilder: (context, index) {
                    final following = state.student.following[index];
                    return Container(
                      margin: EdgeInsets.only(left: index == 0 ? 10.w : 10.w),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(35.sw),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: 50.h,
                              width: 57.w,
                              imageUrl: following.dp,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Flexible(
                              child: SizedBox(
                                  width: 67.w,
                                  child: Components.googleFonts(
                                      alignment: Alignment.center,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      text: following.name.toLowerCase(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center)))
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              height: 65.h,
              child: ListView.builder(
                key: const PageStorageKey<String>(AppKey.story),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: index == 0 ? 10.w : 10.w),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(35.sw),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 50.h,
                            width: 57.w,
                            imageUrl: user.dp,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Flexible(
                            child: SizedBox(
                                width: 67.w,
                                child: Components.googleFonts(
                                    alignment: Alignment.center,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    text: user.name.toLowerCase(),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center)))
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }
        return const SliverToBoxAdapter();
      },
    );
  }

  static Widget post() {
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
          final sortedPosts = List<Data>.from(state.postModel.data)
            ..sort((a, b) => b.createdAT!.compareTo(a.createdAT!));
          return SliverList.builder(
            itemCount: sortedPosts.length,
            itemBuilder: (context, index) {
              final post = sortedPosts[index];
              return Column(
                children: [
                  PostWidget.topWidget(
                      profilePicture: post.dp,
                      username: post.name,
                      year: post.myClass),
                  ImageWithHeart(url: post.imageUrl[0]),
                  PostWidget.likesCommentandLength(),
                  PostWidget.likedBy(url: post.dp),
                  ReadMoreTextWidget(
                      username: post.name, description: post.description),
                  PostWidget.comments(),
                  PostWidget.date(createdAT: post.createdAT!),
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
