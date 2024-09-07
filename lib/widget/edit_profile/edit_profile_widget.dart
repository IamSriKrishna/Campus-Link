import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/auth/auth_bloc.dart';
import 'package:campuslink/bloc/auth/auth_state.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:campuslink/widget/edit_profile/edit_bio.dart';
import 'package:campuslink/widget/edit_profile/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get_navigation/get_navigation.dart' as t;

class EditProfileWidget {
  static Widget sliverAppBar() {
    return SliverAppBar(
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Iconsax.arrow_left,
            color: AppPalette.mette,
          )),
      backgroundColor: Colors.transparent,
      title: Components.googleFonts(
          text: AppContent.editProfile,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600),
    );
  }

  static Widget profilePicture() {
    return const ProfilePictureWidget();
  }

  static Widget unEditableTextField() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is StudentLoadedState) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Column(
                children: [
                  unEditabletextField(
                      title: state.student.name, field: AppContent.name),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0.h),
                    child: unEditabletextField(
                        title: state.student.department,
                        field: AppContent.department),
                  ),
                  unEditabletextField(
                      title: state.student.studentclass,
                      field: AppContent.classText),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0.h),
                    child: unEditabletextField(
                        title: state.student.year, field: AppContent.year),
                  ),
                ],
              ),
            ),
          );
        }
        return const SliverToBoxAdapter();
      },
    );
  }

  static Widget unEditabletextField({
    required String title,
    required String field,
  }) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(color: AppPalette.mette)),
        child: TextField(
          readOnly: true,
          style: Components.fontFamily(fontWeight: FontWeight.bold),
          controller: TextEditingController(text: title),
          cursorColor: AppPalette.mette,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.sp),
              label: Components.googleFonts(
                  text: field, fontWeight: FontWeight.bold),
              border: InputBorder.none),
        ));
  }

  static Widget bio() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is StudentLoadedState) {
          return SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: editabletextField(
                title: state.student.bio, field: AppContent.bio),
          ));
        }
        return const SliverToBoxAdapter();
      },
    );
  }

  static Widget editabletextField({
    required String title,
    required String field,
  }) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(color: AppPalette.mette)),
        child: TextField(
          onTap: () {
            Get.to(() => EditBio(bio: title,), transition: t.Transition.rightToLeft);
          },
          readOnly: true,
          style: Components.fontFamily(fontWeight: FontWeight.bold),
          controller: TextEditingController(text: title),
          cursorColor: AppPalette.mette,
          decoration: InputDecoration(
              suffixIcon: const Icon(
                Iconsax.edit,
                color: AppPalette.mette,
              ),
              contentPadding: EdgeInsets.all(10.sp),
              label: Components.googleFonts(
                  text: field, fontWeight: FontWeight.bold),
              border: InputBorder.none),
        ));
  }
}
