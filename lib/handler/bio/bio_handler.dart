import 'dart:math';
import 'package:campuslink/bloc/student/student_state.dart';
import 'package:flutter/widgets.dart';
import 'package:campuslink/app/app_list.dart';
import 'package:campuslink/bloc/bottom/bottom_bloc.dart';
import 'package:campuslink/bloc/bottom/bottom_event.dart';
import 'package:campuslink/view/bottom/bottom_screen.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BioHandler {
    static void handleAuthState(BuildContext context, StudentState state) {
    if (state is SuccessStudentState) {
      _onBioSuccess(context);
    } else if (state is FailedStudentState) {
      _onBioFailure(context);
    }
  }

  static void _onBioSuccess(BuildContext context) {
    context.read<BottomBloc>().add(CurrentIndexEvent(index: 4));
    Get.offAll(() => const BottomScreen());

  }

  static void _onBioFailure(BuildContext context) {
    final random = Random();
    final randomError = AppList.listOfError[random.nextInt(AppList.listOfError.length)];
    Components.topSnackBar(context, text: randomError);
  }
}