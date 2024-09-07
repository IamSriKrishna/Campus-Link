import 'package:cached_network_image/cached_network_image.dart';
import 'package:campuslink/model/post/post.dart';
import 'package:campuslink/widget/edit_profile/select_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/provider/auth_provider.dart';
import 'package:campuslink/view/auth/auth_screen.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:get/get_navigation/get_navigation.dart' as t;

class ShowWidget {
  static Future<dynamic> showProfile(
      {required BuildContext context,
      required String name,
      required String dp}) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.sp))),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 135.h,
          child: Stack(
            children: [
              //holder
              Align(
                alignment: const Alignment(0, -0.9),
                child: Container(
                  height: 5.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                    color: AppPalette.mette,
                  ),
                ),
              ),
              //signOut and profile
              Align(
                alignment: const Alignment(0, 0.1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppPalette.mette.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(15.sp)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Username
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(25.sw),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: 40.h,
                                width: 45.w,
                                imageUrl: dp,
                              ),
                            ),
                            title: Components.googleFonts(
                                text: name,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                            trailing: const Icon(Iconsax.tick_circle5),
                          ),
                        ),
                        //Logout
                        InkWell(
                          onTap: () {
                            Provider.of<AuthProvider>(context, listen: false)
                                .logout();
                            Get.offAll(() => const AuthScreen());
                          },
                          child: ListTile(
                            leading: Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppPalette.mette.withOpacity(0.1)),
                              child: const Icon(
                                Iconsax.logout,
                                color: Colors.white,
                              ),
                            ),
                            title: Components.googleFonts(
                                text: AppContent.logoutAccount,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static Future<dynamic> changeProfilePictureandAvatar(
      {required BuildContext context, required String avatar}) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.sp))),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 135.h,
          child: Stack(
            children: [
              //holder
              Align(
                alignment: const Alignment(0, -0.9),
                child: Container(
                  height: 5.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                    color: AppPalette.mette,
                  ),
                ),
              ),
              //signOut and profile
              Align(
                alignment: const Alignment(0, 0.1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppPalette.mette.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(15.sp)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //profile picture
                        InkWell(
                          onTap: () {
                            //Get.back();
                            Get.to(() => const SelectImage(),
                                transition: t.Transition.rightToLeft);
                          },
                          child: ListTile(
                            leading: Container(
                                height: 45.h,
                                width: 45.w,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: const Icon(Iconsax.image)),
                            title: Components.googleFonts(
                                text: AppContent.newProfilePicture,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        //avatar
                        InkWell(
                          onTap: () {},
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(25.sw),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: 40.h,
                                width: 45.w,
                                imageUrl: avatar,
                              ),
                            ),
                            title: Components.googleFonts(
                                text: AppContent.changeAvatar,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static Future<dynamic> commentSection(BuildContext context,
      {required Data post}) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0.h),
              child: Column(
                children: [
                  Container(
                    height: 3.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      color: AppPalette.mette,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0.h),
                    child: Components.googleFonts(
                        text: "Comments",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            //
            Expanded(
              child: ListView.builder(
                itemCount: post.comments.length,
                itemBuilder: (context, index) {
                  return const ListTile(
                    leading: CircleAvatar(),
                  );
                },
              ),
            ),
            // Input field for writing a message
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      minLines: 1,
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add a comments for ${post.sender.name}',
                      ),
                    ),
                  ),
                  SizedBox(
                      width: 40.w,
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Iconsax.send1)))
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
