import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/fcm/fcm_bloc.dart';
import 'package:campuslink/bloc/fcm/fcm_event.dart';
import 'package:campuslink/app/app_list.dart';
import 'dart:math';

class SearchStudentsHandler {
  static String? lastMsg;

  static void randomFCM(BuildContext context, final user, final student) {
    final random = Random();
    String randomMsg;

    do {
      randomMsg = AppList.viewed[random.nextInt(AppList.viewed.length)];
    } while (randomMsg == lastMsg);

    lastMsg = randomMsg;

    context.read<FcmBloc>().add(SendFcmEvent(
        title: user.name, body: randomMsg, token: student.fcmtoken));
  }
}
