import 'package:cached_network_image/cached_network_image.dart';
import 'package:campuslink/bloc/post/post_bloc.dart';
import 'package:campuslink/bloc/post/post_state.dart';
import 'package:campuslink/model/post/post.dart';
import 'package:campuslink/widget/components/show_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget {
  //top widget
  static Widget topWidget(
      {required String profilePicture,
      required String username,
      required String year}) {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                //Profile Picture

                SizedBox(width: 7.w),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.sw),
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 30.h,
                      width: 30.w,
                      imageUrl: profilePicture),
                ),

                SizedBox(width: 5.w),
                //name, year and department
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          //Name
                          Flexible(
                            child: Components.googleFonts(
                                text: username,
                                fontSize: 14.sp,
                                overflow: TextOverflow.ellipsis),
                          ),
                          //display if developer
                          Padding(
                            padding: EdgeInsets.only(left: 2.0.w),
                            child: Icon(
                              Iconsax.code_circle5,
                              size: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      //year and department
                      Components.googleFonts(
                        text: year,
                        fontSize: 12.sp,
                        color: AppPalette.mette.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        //more
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: const Icon(Iconsax.more),
        ),
      ],
    );
  }

static Widget likesCommentandLength({
  required Data post,
  required bool isLikedByCurrentUser,
  required BuildContext context, // Add context parameter
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Like icon
            Icon(
              isLikedByCurrentUser ? Icons.favorite : Iconsax.heart4,
              size: 25.sp,
              color: isLikedByCurrentUser ? Colors.red : Colors.black,
            ),
            // Comments icon with GestureDetector to show bottom modal
            GestureDetector(
              onTap: () {
               ShowWidget.commentSection(context,post: post);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10.0.w),
                child: Icon(
                  Iconsax.message,
                  size: 25.sp,
                ),
              ),
            ),
          ],
        ),
        // Report icon
        Icon(
          Iconsax.info_circle,
          size: 25.sp,
          color: AppPalette.mette,
        ),
      ],
    ),
  );
}
  static Widget likedBy({required Data post}) {
    return BlocBuilder<PostBloc, PostState>(
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
        final updatedPost = (state as ReadPostState)
            .postModel
            .data
            .firstWhere((element) => element.id == post.id, orElse: () => post);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: updatedPost.likes.isEmpty
              ? Components.googleFonts(
                  text: "No likes",
                  fontSize: 14.sp,
                  isContainer: true,
                  alignment: Alignment.centerLeft)
              : Row(
                  children: [
                    //profile picture
                    ClipRRect(
                      borderRadius: BorderRadius.circular(45.sw),
                      child: CachedNetworkImage(
                        imageUrl: updatedPost.likes[0].dp,
                        fit: BoxFit.cover,
                        height: 20.h,
                        width: 20.w,
                      ),
                    ),
                    //liked by text
                    Padding(
                      padding: EdgeInsets.only(left: 5.0.w),
                      child: Components.googleFonts(text: AppContent.likedBy),
                    ),
                    //username
                    Padding(
                      padding: EdgeInsets.only(left: 5.0.w),
                      child: Components.googleFonts(
                          text: updatedPost.likes[0].name,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0.w),
                      child: Components.googleFonts(text: AppContent.and),
                    ),
                    //liked count
                    Padding(
                      padding: EdgeInsets.only(left: 5.0.w),
                      child: Components.googleFonts(
                          text:
                              "${updatedPost.likes.length} ${AppContent.others}",
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
        );
      },
    );
  }

  //comment
  static Widget comments({required Data post}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
      child: Components.googleFonts(
          text: "${AppContent.viewAll} ${post.comments.length} ${AppContent.comments}",
          isContainer: true,
          color: AppPalette.mette.withOpacity(0.5)),
    );
  }

  static Widget date({required DateTime createdAT}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 5.h),
      child: Components.googleFonts(
          text: timeago.format(createdAT),
          isContainer: true,
          color: AppPalette.mette.withOpacity(0.5)),
    );
  }
}
