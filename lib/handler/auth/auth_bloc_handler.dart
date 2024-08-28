import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:campuslink/app/app_list.dart';
import 'package:campuslink/bloc/auth/auth_bloc.dart';
import 'package:campuslink/bloc/auth/auth_event.dart';
import 'package:campuslink/bloc/auth/auth_state.dart';
import 'package:campuslink/bloc/bottom/bottom_bloc.dart';
import 'package:campuslink/bloc/bottom/bottom_event.dart';
import 'package:campuslink/bloc/fcm/fcm_bloc.dart';
import 'package:campuslink/bloc/fcm/fcm_event.dart';
import 'package:campuslink/provider/auth_provider.dart';
import 'package:campuslink/view/bottom/bottom_screen.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class AuthBlocHandler {
    static void handleAuthState(BuildContext context, AuthState state) {
    if (state is SuccessAuthState) {
      _onAuthSuccess(context);
    } else if (state is FailedAuthState) {
      _onAuthFailure(context);
    }
  }

  static void _onAuthSuccess(BuildContext context) {
    context.read<AuthBloc>().add(GetStudentByIdEvent());
    context.read<BottomBloc>().add(CurrentIndexEvent(index: 0));
    Get.offAll(() => const BottomScreen());
    Provider.of<AuthProvider>(context, listen: false).loadUser();

    final box = GetStorage();
    String? token = box.read('firebase_token');
    if (token != null) {
      context.read<FcmBloc>().add(UpdateFcmTokenEvent(fcmtoken: token));
    }
  }

  static void _onAuthFailure(BuildContext context) {
    final random = Random();
    final randomError = AppList.listOfError[random.nextInt(AppList.listOfError.length)];
    Components.topSnackBar(context, text: randomError);
  }
}