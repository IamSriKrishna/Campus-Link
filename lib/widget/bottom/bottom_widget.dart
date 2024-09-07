import 'package:cached_network_image/cached_network_image.dart';
import 'package:campuslink/view/event/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/auth/auth_bloc.dart';
import 'package:campuslink/bloc/auth/auth_state.dart';
import 'package:campuslink/bloc/bottom/bottom_bloc.dart';
import 'package:campuslink/bloc/bottom/bottom_event.dart';
import 'package:campuslink/bloc/bottom/bottom_state.dart';
import 'package:campuslink/view/home/home_screen.dart';
import 'package:campuslink/view/pass/pass_screen.dart';
import 'package:campuslink/view/profile/profile_screen.dart';
import 'package:campuslink/view/search/search_screen.dart';
import 'package:campuslink/widget/components/show_widget.dart';
import 'package:iconsax/iconsax.dart';

class BottomWidget {
  static Widget navigationBar() {
    return BlocBuilder<BottomBloc, BottomState>(
      builder: (context, state) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authstate) {
            if (authstate is StudentLoadedState) {
              return BottomNavigationBar(
                  currentIndex: state.index,
                  onTap: (value) {
                    context
                        .read<BottomBloc>()
                        .add(CurrentIndexEvent(index: value));
                  },
                  elevation: 0,
                  selectedItemColor: AppPalette.mette,
                  unselectedItemColor: AppPalette.mette.withOpacity(0.5),
                  items: listWithDp(
                      index: state.index,
                      dp: authstate.student.dp,
                      context: context,
                      name: authstate.student.name));
            }
            return BottomNavigationBar(
                currentIndex: state.index,
                onTap: (value) {
                  context
                      .read<BottomBloc>()
                      .add(CurrentIndexEvent(index: value));
                },
                elevation: 0,
                selectedItemColor: AppPalette.mette,
                unselectedItemColor: AppPalette.mette.withOpacity(0.5),
                items: list(index: state.index));
          },
        );
      },
    );
  }

  static List<BottomNavigationBarItem> list({required int index}) {
    return [
      BottomNavigationBarItem(
          icon: Icon(index == 0 ? Iconsax.home_11 : Iconsax.home), label: ""),
      BottomNavigationBarItem(
          icon:
              Icon(index == 1 ? Iconsax.search_normal5 : Iconsax.search_normal),
          label: ""),
      BottomNavigationBarItem(
          icon: Icon(index == 2 ? Iconsax.add_square5 : Iconsax.add_square),
          label: ""),
      BottomNavigationBarItem(
          icon: Icon(index == 3 ? Iconsax.heart5 : Iconsax.heart), label: ""),
      const BottomNavigationBarItem(icon: Icon(Iconsax.user), label: ""),
    ];
  }

  static List<BottomNavigationBarItem> listWithDp(
      {required int index,
      required String dp,
      required String name,
      required BuildContext context}) {
    return [
      BottomNavigationBarItem(
          icon: Icon(index == 0 ? Iconsax.home_11 : Iconsax.home), label: ""),
      BottomNavigationBarItem(
          icon:
              Icon(index == 1 ? Iconsax.search_normal5 : Iconsax.search_normal),
          label: ""),
      BottomNavigationBarItem(
          icon: Icon(index == 2 ? Iconsax.add_square5 : Iconsax.add_square),
          label: ""),
      BottomNavigationBarItem(
          icon: Icon(index == 3 ? Iconsax.heart5 : Iconsax.heart), label: ""),
      BottomNavigationBarItem(
          icon: index == 4
              ? InkWell(
                  onTap: () => ShowWidget.showProfile(
                      context: context, dp: dp, name: name),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.sw),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 20.h,
                        width: 22.5.w,
                        imageUrl: dp),
                  ),
                )
              : const Icon(Iconsax.user),
          label: ""),
    ];
  }

  static Widget screen() {
    return BlocBuilder<BottomBloc, BottomState>(
      builder: (context, state) {
        return screens[state.index];
      },
    );
  }

  static List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const PassScreen(),
    const EventScreen(),
    const ProfileScreen(),
  ];
}
