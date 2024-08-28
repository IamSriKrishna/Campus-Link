import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/student/student_bloc.dart';
import 'package:campuslink/bloc/student/student_state.dart';
import 'package:campuslink/model/student/student.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class OtherProfileWidget {
  static Widget appBar(BuildContext context, {required Student student}) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Iconsax.arrow_left,
            color: AppPalette.mette,
          )),
      title: Components.googleFonts(text: student.name, fontSize: 16.sp),
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

  static Widget topWidget(BuildContext context, {required Student student}) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: SizedBox(
              width: double.infinity,
              height: 85.h,
              child: Row(
                children: [
                  Hero(
                    tag: student.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45.w),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 90.w,
                        width: 90.w,
                        imageUrl: student.dp,
                      ),
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
                        content(count: 0, title: AppContent.post),
                        content(
                            count: student.followers.length,
                            title: AppContent.followers),
                        content(
                            count: student.following.length,
                            title: AppContent.following),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget content({required int count, required String title}) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Components.googleFonts(
              text: "$count", fontWeight: FontWeight.bold, fontSize: 18.sp),
          Components.googleFonts(text: title, fontSize: 16.sp),
        ],
      ),
    );
  }

  static Widget nameAndBio(BuildContext context, {required Student student}) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Components.googleFonts(
                text: student.name,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
            Components.googleFonts(
                text: student.bio,
                fontSize: 14.sp,
                maxlines: 4,
                fontWeight: FontWeight.w500),
          ],
        ),
      ),
    );
  }

  static Widget gridDivider() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Divider(
            thickness: 1.sp,
            color: AppPalette.mette.withOpacity(0.2),
          ),
          Icon(
            Icons.grid_on,
            color: AppPalette.mette.withOpacity(0.5),
          ),
          Divider(
            thickness: 1.sp,
            color: AppPalette.mette.withOpacity(0.2),
          ),
        ],
      ),
    );
  }

  static Widget gridPost() {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 1, crossAxisSpacing: 1),
      itemBuilder: (context, index) {
        return Container(
          color: AppPalette.mette.withOpacity(0.2),
        );
      },
    );
  }
}
