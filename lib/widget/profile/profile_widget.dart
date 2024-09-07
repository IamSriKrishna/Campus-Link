import 'package:cached_network_image/cached_network_image.dart';
import 'package:campuslink/bloc/post/post_bloc.dart';
import 'package:campuslink/bloc/post/post_state.dart';
import 'package:campuslink/provider/auth_provider.dart';
import 'package:campuslink/view/edit_profile/edit_profile.dart';
import 'package:campuslink/widget/profile/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/auth/auth_bloc.dart';
import 'package:campuslink/bloc/auth/auth_state.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:campuslink/widget/components/show_widget.dart';
import 'package:campuslink/widget/profile/dummy_profile_widget.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get_navigation/get_navigation.dart' as t;
import 'package:provider/provider.dart';

class ProfileWidget {
  static Widget appBar(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is StudentLoadedState) {
          return SliverAppBar(
            backgroundColor: Colors.transparent,
            title: Row(
              children: [
                Icon(
                  Iconsax.lock5,
                  color: AppPalette.mette,
                  size: 12.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                  child: Components.googleFonts(
                      text: state.student.name,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () => ShowWidget.showProfile(
                      context: context,
                      dp: state.student.dp,
                      name: state.student.name),
                  child: const Icon(
                    Iconsax.arrow_down_1,
                    color: AppPalette.mette,
                    //size: 12.sp,
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
        return DummyProfileWidget.appBar(context);
      },
    );
  }

  static Widget topWidget(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is StudentLoadedState) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: SizedBox(
                width: double.infinity,
                height: 85.h,
                child: Row(
                  children: [
                    ProfilePicture(
                      image: state.student.dp,
                      avatar: AppContent.maleAvatar,
                    ),
                    //post, followers and following
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          content(
                              count: state.student.posts.length,
                              title: AppContent.post),
                          content(
                              count: state.student.followers.length,
                              title: AppContent.followers),
                          content(
                              count: state.student.following.length,
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
        return DummyProfileWidget.topWidget(context);
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

  static Widget nameAndBio(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is StudentLoadedState) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Components.googleFonts(
                      text: state.student.name,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                  Components.googleFonts(
                      text: state.student.bio,
                      fontSize: 14.sp,
                      maxlines: 4,
                      fontWeight: FontWeight.w500),
                ],
              ),
            ),
          );
        }
        return DummyProfileWidget.nameAndBio(context);
      },
    );
  }

  static Widget editProfile() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppPalette.mette),
            onPressed: () {
              Get.to(() => const EditProfile(),
                  transition: t.Transition.rightToLeft);
            },
            child: Components.googleFonts(
                text: AppContent.editProfile, color: Colors.white)),
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

  static Widget gridPost(BuildContext context) {
    final student = Provider.of<AuthProvider>(context).student!;
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is ReadPostState) {
          // Filter posts based on senderId
          final filteredData = state.postModel.data
              .where((post) => post.sender.id == student.id)
              .toList();
          return SliverGrid.builder(
            itemCount: filteredData.isEmpty?100:filteredData.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 1, crossAxisSpacing: 1),
            itemBuilder: (context, index) {
              if (filteredData.isEmpty) {
                return Container(
                  color: AppPalette.mette.withOpacity(0.2),
                );
              }
              return CachedNetworkImage(
                  imageUrl: filteredData[index].imageUrl[0]);
            },
          );
        }
        return SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 1, crossAxisSpacing: 1),
          itemBuilder: (context, index) {
            return Container(
              color: AppPalette.mette.withOpacity(0.2),
            );
          },
        );
      },
    );
  }
}
