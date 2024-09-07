import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/provider/auth_provider.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:campuslink/widget/components/show_widget.dart';
import 'package:campuslink/widget/profile/profile_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class DummyProfileWidget {
  static Widget appBar(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).student!;
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          Icon(
            Iconsax.lock5,
            color: AppPalette.mette,
            size: 12.sp,
          ),
          SizedBox(width: 2.0.w),
          Components.googleFonts(
              text: user.name, fontSize: 18.sp, fontWeight: FontWeight.w600),
          InkWell(
            onTap: () => ShowWidget.showProfile(
                context: context, dp: user.dp, name: user.name),
            child: const Icon(
              Iconsax.arrow_down_1,
              color: AppPalette.mette,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Iconsax.menu_14,
            size: 25.sp,
            color: AppPalette.mette,
          ),
        )
      ],
    );
  }

  static Widget topWidget(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).student!;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: SizedBox(
          width: double.infinity,
          height: 85.h,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(45.w),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 90.w,
                  width: 90.w,
                  imageUrl: user.dp,
                ),
              ),

              //post, followers and following
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileWidget.content(count: 0, title: AppContent.post),
                    ProfileWidget.content(
                        count: user.followers.length,
                        title: AppContent.followers),
                    ProfileWidget.content(
                        count: user.following.length,
                        title: AppContent.following),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  static Widget nameAndBio(context) {
    final user = Provider.of<AuthProvider>(context).student!;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Components.googleFonts(
                text: user.name, fontSize: 16.sp, fontWeight: FontWeight.w600),
            Components.googleFonts(
              text: user.bio,
              fontSize: 14.sp,
              maxlines: 4,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
