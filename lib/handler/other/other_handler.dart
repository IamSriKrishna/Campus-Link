import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/app/app_list.dart';
import 'package:campuslink/bloc/fcm/fcm_bloc.dart';
import 'package:campuslink/bloc/fcm/fcm_event.dart';
import 'dart:math';

import 'package:campuslink/widget/components/components.dart';

class OtherHandler {
  static Timer startPeriodicUpdates(Function setState) {
    return Timer.periodic(
      const Duration(milliseconds: 350), // Reload every 350 millisecond
      (Timer timer) {
        setState();
      },
    );
  }

  static void newUser(final student, BuildContext context) {
    final random = Random();
    final randomError =
        AppList.mockUserWhoNotedInstalled(student.name.toLowerCase())[
            random.nextInt(
                AppList.mockUserWhoNotedInstalled(student.name.toLowerCase())
                    .length)];
    Components.topSnackBar(context, text: randomError);
  }

  static void follow(final student, BuildContext context) {
    final random = Random();
    final randomError = AppList.follow[random.nextInt(AppList.follow.length)];

    context.read<FcmBloc>().add(SendFcmEvent(
        title: student.name, body: randomError, token: student.fcmtoken));
  }

  static void unfollow(final student, BuildContext context) {
    final random = Random();
    final randomError =
        AppList.unfollow[random.nextInt(AppList.unfollow.length)];
    context.read<FcmBloc>().add(SendFcmEvent(
        title: student.name, body: randomError, token: student.fcmtoken));
  }
}
