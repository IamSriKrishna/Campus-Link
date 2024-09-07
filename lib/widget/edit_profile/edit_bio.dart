import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/student/student_bloc.dart';
import 'package:campuslink/bloc/student/student_event.dart';
import 'package:campuslink/bloc/student/student_state.dart';
import 'package:campuslink/handler/bio/bio_handler.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditBio extends StatefulWidget {
  final String bio;
  const EditBio({super.key, required this.bio});

  @override
  State<EditBio> createState() => _EditBioState();
}

class _EditBioState extends State<EditBio> {
  late TextEditingController _bio;

  @override
  void initState() {
    super.initState();
    _bio = TextEditingController(text: widget.bio);
  }

  @override
  void dispose() {
    _bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<StudentBloc, StudentState>(
        listener: (context, state) {
          BioHandler.handleAuthState(context, state);
        },
        child: BlocBuilder<StudentBloc, StudentState>(
          builder: (context, state) {
            return Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
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
                          text: AppContent.bio,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                      actions: [
                        IconButton(
                            onPressed: () {
                              context
                                  .read<StudentBloc>()
                                  .add(UpdateBioEvent(bio: _bio.text));
                            },
                            icon: const Icon(
                              Icons.done,
                              color: AppPalette.mette,
                            ))
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                border: Border.all(
                                  color: AppPalette.mette,
                                )),
                            child: TextField(
                              controller: _bio,
                              maxLength: 300,
                              minLines: 1,
                              maxLines: 7,
                              decoration: InputDecoration(
                                  label: Components.googleFonts(
                                      text: AppContent.bio,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10.sp)),
                            )),
                      ),
                    )
                  ],
                ),
                if (state is LoadingStudentState) Components.blurBackground(),
              ],
            );
          },
        ),
      ),
    );
  }
}
