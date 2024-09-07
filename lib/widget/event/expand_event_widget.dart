import 'package:cached_network_image/cached_network_image.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/model/event/event.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpandEventWidget {
  static Widget sliverAppBar({required Event event}) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      floating: true,
      leading: IconButton(
        color: AppPalette.mette,
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: () {
          Get.back();
        },
      ),
      expandedHeight: 285.0.h,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
          child: Hero(
            tag: event.id,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
              imageUrl: event.image,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator(color: AppPalette.mette,)),
              errorWidget: (context, url, error) => Image.network(
                AppContent.errorImage, 
                fit: BoxFit.cover,
                height: 80,
                width: 80,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static titleAndView({required Event event}) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Components.googleFonts(
                      text: "Title",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                  Column(
                    children: [
                      const Tooltip(
                          message: "Impression", child: Icon(Iconsax.eye)),
                      Components.googleFonts(
                          text: "${event.views.length}",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ],
                  )
                ],
              ),
            ),
            Components.googleFonts(
                text: event.title, maxlines: 500, fontSize: 14.sp)
          ],
        ),
      ),
    );
  }

  static description({required Event event}) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w, bottom: 80.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0.h),
              child: Components.googleFonts(
                  text: "Description",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
            Components.googleFonts(
                textAlign: TextAlign.start,
                color: AppPalette.mette.withOpacity(0.5),
                text: event.description,
                maxlines: 500,
                fontSize: 16.sp)
          ],
        ),
      ),
    );
  }

  static Widget floatingButton({required Event event}) {
    return Positioned(
      bottom: 30.0,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.mette,
                  minimumSize: Size(double.infinity, 35.h)),
              onPressed: () async {
                await launchUrl(Uri.parse(event.link));
              },
              child: Components.googleFonts(
                  text: "Continue",
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
