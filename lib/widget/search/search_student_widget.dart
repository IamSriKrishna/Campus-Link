import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/student/student_bloc.dart';
import 'package:campuslink/bloc/student/student_event.dart';
import 'package:campuslink/bloc/student/student_state.dart';
import 'package:campuslink/handler/search_students/search_students_handler.dart';
import 'package:campuslink/provider/auth_provider.dart';
import 'package:campuslink/view/other_profile/other_profile.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get_navigation/get_navigation.dart' as tx;

class SearchStudentWidget {
  static Widget searchBar(
      BuildContext context, TextEditingController controller) {
    return SliverAppBar(
      floating: true,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Iconsax.arrow_left4, color: AppPalette.mette),
      ),
      leadingWidth: 40.w,
      backgroundColor: Colors.white,
      title: _buildSearchField(context, controller),
    );
  }

  static Widget _buildSearchField(
      BuildContext context, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.mette.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: TextField(
        autofocus: true,
        controller: controller,
        onChanged: (value) => _onSearchChanged(context, value),
        textCapitalization: TextCapitalization.words,
        style: Components.fontFamily(color: AppPalette.mette),
        cursorColor: AppPalette.mette.withOpacity(0.5),
        decoration: InputDecoration(
          hintText: AppContent.search,
          contentPadding: EdgeInsets.all(10.sp),
          border: InputBorder.none,
        ),
      ),
    );
  }

  static void _onSearchChanged(BuildContext context, String value) {
    context.read<StudentBloc>().add(StudentSearchEvent(name: value));
  }

  static Widget studentList(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user!;

    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is ReadSearchStudentState) {
          return _buildStudentList(context, state, user);
        } else if (state is LoadingStudentState) {
          return _buildLoadingList();
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }

  static Widget _buildStudentList(
      BuildContext context, ReadSearchStudentState state, dynamic user) {
    return SliverList.builder(
      itemCount: state.studentModel.data.length,
      itemBuilder: (context, index) {
        final student = state.studentModel.data[index];

        if (student.id == user.id) {
          return const SizedBox.shrink();
        }

        return _buildStudentTile(context, student);
      },
    );
  }

  static Widget _buildStudentTile(BuildContext context, dynamic student) {
    final user = Provider.of<AuthProvider>(context).student!;
    return InkWell(
      onTap: () {
        if (user.certified == false) {
          SearchStudentsHandler.randomFCM(context, user, student);
        }
        Get.to(() => OtherProfile(student: student),
            transition: tx.Transition.rightToLeftWithFade);
      },
      child: ListTile(
        leading: _buildStudentAvatar(student),
        title: _buildStudentName(student),
        subtitle: _buildStudentDepartment(student),
      ),
    );
  }

  static Widget _buildStudentAvatar(dynamic student) {
    return Hero(
      tag: student.id,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(45.sw),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          height: 40.h,
          width: 45.w,
          imageUrl: student.dp,
        ),
      ),
    );
  }

  static Widget _buildStudentName(dynamic student) {
    return Row(
      children: [
        Components.googleFonts(text: student.name, fontWeight: FontWeight.bold),
        if (student.certified)
          Padding(
            padding: EdgeInsets.only(left: 5.0.w, bottom: 5),
            child: Icon(
              Iconsax.code_circle,
              color: AppPalette.mette,
              size: 12.sp,
            ),
          ),
      ],
    );
  }

  static Widget _buildStudentDepartment(dynamic student) {
    return Components.googleFonts(
      text: student.department,
      color: AppPalette.mette.withOpacity(0.5),
      fontWeight: FontWeight.normal,
    );
  }

  static Widget _buildLoadingList() {
    return SliverList.builder(
      itemCount: 5,
      itemBuilder: (context, index) => ListTile(
        leading: _buildShimmerAvatar(),
        title: _buildShimmerText(),
      ),
    );
  }

  static Widget _buildShimmerAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.sw),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 45.h,
          width: 50.w,
          color: Colors.white,
        ),
      ),
    );
  }

  static Widget _buildShimmerText() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 20.h,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }
}
