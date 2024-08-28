import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget {
  //top widget
  static Widget topWidget(
      {required String profilePicture, required String username,required String year}) {
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

  static Widget likesCommentandLength() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //like
              Icon(
                Iconsax.heart4,
                size: 25.sp,
              ),
              //comments
              Padding(
                padding: EdgeInsets.only(left: 10.0.w),
                child: Icon(
                  Iconsax.message,
                  size: 25.sp,
                ),
              ),
            ],
          ),
          //report
          Icon(
            Iconsax.info_circle,
            size: 25.sp,
            color: AppPalette.mette,
          ),
        ],
      ),
    );
  }

  static Widget likedBy({required String url}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          //profile picture
          ClipRRect(
            borderRadius: BorderRadius.circular(45.sw),
            child: CachedNetworkImage(
              imageUrl: url,
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
                text: AppContent.username, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.0.w),
            child: Components.googleFonts(text: AppContent.and),
          ),
          //liked count
          Padding(
            padding: EdgeInsets.only(left: 5.0.w),
            child: Components.googleFonts(
                text: "44654 ${AppContent.others}",
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  //comment
  static Widget comments() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
      child: Components.googleFonts(
          text: "${AppContent.viewAll} 25 ${AppContent.comments}",
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
