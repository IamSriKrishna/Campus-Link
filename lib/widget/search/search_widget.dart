import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/search_post/search_post_bloc.dart';
import 'package:campuslink/bloc/search_post/search_post_state.dart';
import 'package:campuslink/view/search/search_student/search_student.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart' as t;

class SearchWidget {
  static Widget search() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      title: Container(
        decoration: BoxDecoration(
            color: AppPalette.mette.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.sp)),
        child: TextField(
          readOnly: true,
          onTap: () {
            Get.to(() => const SearchStudentScreen(),
                duration: const Duration(milliseconds: 0),
                transition: t.Transition.noTransition);
          },
          textCapitalization: TextCapitalization.words,
          style: Components.fontFamily(color: AppPalette.mette),
          cursorColor: AppPalette.mette.withOpacity(0.5),
          decoration: InputDecoration(
              hintText: AppContent.search,
              contentPadding: EdgeInsets.all(10.sp),
              border: InputBorder.none),
        ),
      ),
    );
  }

  static Widget staggeredGrid() {
    return BlocBuilder<SearchPostBloc, SearchPostState>(
      builder: (context, state) {
        if (state is FailedSearchPostState) {
          return SliverFillRemaining(
            child: Center(
              child: Components.googleFonts(
                  maxlines: 10,
                  text: state.error,
                  textAlign: TextAlign.center,
                  isContainer: true,
                  padding: EdgeInsets.symmetric(horizontal: 10.w)),
            ),
          );
        }
        if (state is ReadSearchPostState) {
          return SliverToBoxAdapter(
            child: StaggeredGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              children: List.generate(state.postModel.data.length, (index) {
                final post = state.postModel.data[index];
                if (index % 7 == 1) {
                  return StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: CachedNetworkImage(
                        fit: BoxFit.cover, imageUrl: post.imageUrl[0]),
                  );
                } else {
                  return StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: CachedNetworkImage(
                        fit: BoxFit.cover, imageUrl: post.imageUrl[0]),
                  );
                }
              }),
            ),
          );
        }
        return const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        );
      },
    );
  }
}
