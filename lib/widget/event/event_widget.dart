import 'package:cached_network_image/cached_network_image.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/event/events_bloc.dart';
import 'package:campuslink/bloc/event/events_state.dart';
import 'package:campuslink/model/event/event.dart';
import 'package:campuslink/provider/auth_provider.dart';
import 'package:campuslink/view/event/expand_event_screen.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class EventWidget {
  static Widget sliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      title: Components.googleFonts(
          text: AppContent.event, fontSize: 16.sp, fontWeight: FontWeight.bold),
    );
  }

  static Widget listEvent(BuildContext context) {
    final student = Provider.of<AuthProvider>(context).student;

    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        if (state is FailedEventsState) {
          return SliverFillRemaining(
            child: Center(
              child: Components.googleFonts(
                  text: state.error.toString(), maxlines: 50),
            ),
          );
        }
        if (state is GetEventsState) {
          final sortedEvent = List<Event>.from(state.eventResponse.data)
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return SliverList.builder(
            itemCount: sortedEvent.length,
            itemBuilder: (context, index) {
              final event = sortedEvent[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.h),
                        child: Components.googleFonts(
                            text: timeago.format(event.createdAt),
                            color: AppPalette.mette.withOpacity(0.5))),
                    InkWell(
                      onTap: () {
                        Get.to(() => ExpandEventScreen(
                              event: event,
                              studentId: student!.id,
                            ));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Hero(
                            tag: event.id,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.sp),
                              child: CachedNetworkImage(
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                                imageUrl: event.image,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: AppPalette.mette,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.network(
                                  AppContent.errorImage,
                                  fit: BoxFit.cover,
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.only(left: 10.0.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Components.googleFonts(
                                    text: event.title,
                                    fontWeight: FontWeight.bold),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.h),
                                  child: Components.googleFonts(
                                      text: "By. ${event.createdBy}",
                                      color: AppPalette.mette.withOpacity(0.5),
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.calendar5,
                                      color: AppPalette.mette.withOpacity(0.3),
                                    ),
                                    Components.googleFonts(
                                        text: DateFormat("MMM dd,yyyy")
                                            .format(event.lastDate),
                                        color:
                                            AppPalette.mette.withOpacity(0.3))
                                  ],
                                )
                              ],
                            ),
                          )),
                          Column(
                            children: [
                              Icon(
                                Iconsax.eye,
                                color: AppPalette.mette.withOpacity(0.5),
                              ),
                              Components.googleFonts(
                                  text: "${event.views.length}",
                                  fontWeight: FontWeight.w500,
                                  color: AppPalette.mette.withOpacity(0.5),
                                  fontSize: 14.sp),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        );
      },
    );
  }
}
