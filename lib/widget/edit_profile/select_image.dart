import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SelectImage extends StatelessWidget {
  const SelectImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                text: AppContent.selectImage,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
