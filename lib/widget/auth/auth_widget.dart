import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/app/password_handler.dart';
import 'package:campuslink/bloc/auth/auth_bloc.dart';
import 'package:campuslink/bloc/auth/auth_event.dart';
import 'package:campuslink/bloc/read_auth/read_auth_bloc.dart';
import 'package:campuslink/bloc/read_auth/read_auth_state.dart';
import 'package:campuslink/widget/auth/auth_email.dart';
import 'package:campuslink/widget/auth/auth_password.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:iconsax/iconsax.dart';

class AuthWidget {
  static Widget appBar() {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Icon(
        Iconsax.teacher,
        size: 25.sp,
        color: AppPalette.mette,
      ),
    );
  }

  static Widget topContent() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Components.googleFonts(
            text: AppContent.loginContent,
            fontSize: 40.sp,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  static Widget welcomeContent() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.w),
        child: Components.googleFonts(
            text: AppContent.loginWelcomeContent, fontSize: 35.sp, maxlines: 2),
      ),
    );
  }

  static Widget authField() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 20.w),
        child: Column(
          children: [
            const AuthEmail(),
            Padding(
              padding: EdgeInsets.only(top: 20.0.h),
              child: const AuthPassword(),
            )
          ],
        ),
      ),
    );
  }

  static Widget forgetPassword(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: GestureDetector(
          onTap: () {
            var randomMessage = PasswordMessageHandler.getNextMessage();
            Components.topSnackBar(context, text: randomMessage);
          },
          child: Components.googleFonts(
              text: AppContent.forgetPassword,
              isContainer: true,
              alignment: Alignment.centerRight),
        ),
      ),
    );
  }

  static Widget submit(BuildContext context) {
    return BlocBuilder<ReadAuthBloc, ReadAuthState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 20.w),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppPalette.mette,
                    minimumSize: Size(double.infinity, 35.h)),
                onPressed: () {
                  context.read<AuthBloc>().add(LoginAuthEvent(
                      password: state.password,
                      registerNumber: state.registerNumber));
                },
                child: Components.googleFonts(
                    text: AppContent.submit, color: Colors.white)),
          ),
        );
      },
    );
  }

  static Widget credit() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Components.googleFonts(
                    text: AppContent.developedBY,
                    color: AppPalette.mette.withOpacity(0.5),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold),
                Padding(
                  padding: EdgeInsets.only(left: 5.0.w),
                  child: Row(
                    children: [
                      Components.googleFonts(
                          text: AppContent.username,
                          color: AppPalette.mette.withOpacity(0.5),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.0.w),
                        child: Components.googleFonts(
                            text: ', ',
                            color: AppPalette.mette.withOpacity(0.5),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Components.googleFonts(
                          text: AppContent.username2,
                          color: AppPalette.mette.withOpacity(0.5),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                        child: Components.googleFonts(
                            text: AppContent.authAnd,
                            color: AppPalette.mette.withOpacity(0.5),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Components.googleFonts(
                          text: AppContent.username3,
                          color: AppPalette.mette.withOpacity(0.5),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
