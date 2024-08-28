import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/auth/auth_bloc.dart';
import 'package:campuslink/bloc/auth/auth_state.dart';
import 'package:campuslink/model/form/app_form.dart';
import 'package:campuslink/view/pass/gatepass/gate_pass_screen.dart';
import 'package:campuslink/view/pass/other_pass/other_pass.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get/get_navigation/get_navigation.dart' as tx;

class PassWidget {
  static Widget sliverAppBar() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is StudentLoadedState) {
          return SliverAppBar(
            elevation: 0,
            title: Components.googleFonts(
                text: AppContent.pass,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: EdgeInsets.all(12.0.sp),
                child: Components.googleFonts(
                    text: "Ç${state.student.credit}",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              )
            ],
          );
        }
        return SliverAppBar(
          floating: true,
          elevation: 0,
          title: Components.googleFonts(
              text: AppContent.pass,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
          backgroundColor: Colors.transparent,
        );
      },
    );
  }

  static Widget date() {
    final now = DateTime.now();
    final nextYear = DateTime(now.year + 1, now.month, now.day);
    final days = <DateTime>[];

    for (DateTime date = now;
        date.isBefore(nextYear);
        date = date.add(const Duration(days: 1))) {
      days.add(date);
    }
    return SliverToBoxAdapter(
        child: SizedBox(
      width: double.infinity,
      height: 55.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w, bottom: 5.h, top: 5.h),
            child: Components.googleFonts(
                text:
                    '${DateFormat('EEEE').format(DateTime.now())} ${DateFormat('dd').format(DateTime.now())}',
                fontSize: 16.sp),
          ),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              itemBuilder: (context, index) {
                final day = days[index];
                final formattedDay = DateFormat('dd').format(day);
                final label = index == 0 ? 'Today •' : formattedDay;

                return Container(
                  margin: EdgeInsets.only(
                      left: index == 0 ? 10.w : 15,
                      right: index == 0 ? 5.w : 0),
                  height: 50.h,
                  width: index == 0 ? 79.w : 35.w,
                  child: Components.googleFonts(
                      text: label,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                      color: index == 0
                          ? AppPalette.mette
                          : AppPalette.mette.withOpacity(0.5)),
                );
              },
            ),
          )
        ],
      ),
    ));
  }

  static Widget listForm() {
    return SliverList.builder(
      itemCount: formUI.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              if (index == 0) {
                Get.to(
                    () => GatePassScreen(
                          credit: formUI[index].cost,
                        ),
                    transition: tx.Transition.downToUp);
              } else if (index == 1) {
                Get.to(
                    () => OtherPassScreen(
                          form: "On Duty",
                          credit: formUI[index].cost,
                        ),
                    transition: tx.Transition.downToUp);
              } else {
                Get.to(
                    () => OtherPassScreen(
                          form: "Leave",
                          credit: formUI[index].cost,
                        ),
                    transition: tx.Transition.downToUp);
              }
            },
            child: listCard(index, appForm: formUI[index]));
      },
    );
  }

  static Widget listCard(int index, {required AppFormUI appForm}) {
    return Container(
      margin: EdgeInsets.only(
          left: 10.w, right: 10.w, bottom: 10.h, top: index == 0 ? 10.h : 0),
      width: double.infinity,
      height: 150.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.sp),
        color: appForm.color,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60.w,
            height: double.infinity,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0, 0),
                  child: Transform.rotate(
                    angle: 300,
                    child: FittedBox(
                      child: Components.googleFonts(
                          text: "Ç${appForm.cost}",
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 110.h,
                  alignment: Alignment.bottomLeft,
                  child: Components.googleFonts(
                      text: appForm.title,
                      maxlines: 2,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 30.h,
                      alignment: Alignment.center,
                      width: 30.w,
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppPalette.mette,
                      ),
                      child: index == 4
                          ? Components.googleFonts(
                              text: "+ 4", color: Colors.white)
                          : null,
                    );
                  },
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
