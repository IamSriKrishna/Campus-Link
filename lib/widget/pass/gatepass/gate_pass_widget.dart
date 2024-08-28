import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/auth/auth_bloc.dart';
import 'package:campuslink/bloc/auth/auth_state.dart';
import 'package:campuslink/bloc/form/form_bloc.dart';
import 'package:campuslink/bloc/form/form_event.dart';
import 'package:campuslink/bloc/form/form_state.dart';
import 'package:campuslink/bloc/gate_pass/gate_pass_bloc.dart';
import 'package:campuslink/bloc/gate_pass/gate_pass_event.dart';
import 'package:campuslink/bloc/gate_pass/gate_pass_state.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:campuslink/widget/components/form.dart';
import 'package:campuslink/widget/components/options.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class GatePassWidget {
  static Widget appBar(String form) {
    return SliverAppBar(
      floating: true,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Iconsax.arrow_left_24,
          color: AppPalette.mette,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      backgroundColor: Colors.white,
      title: Components.googleFonts(
          text: form, fontSize: 18.sp, fontWeight: FontWeight.bold),
    );
  }

  static Widget nameAndDept() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          FormWidget.question(question: AppContent.studentName, questionNo: 1),
          FormWidget.answer(
              controller: TextEditingController(text: AppContent.username),
              readOnly: true),
          FormWidget.question(question: AppContent.department, questionNo: 2),
          FormWidget.answer(
              controller:
                  TextEditingController(text: AppContent.departmentName),
              readOnly: true),
          FormWidget.question(question: AppContent.registerNO, questionNo: 3),
          FormWidget.answer(
              controller: TextEditingController(text: AppContent.register),
              readOnly: true)
        ],
      ),
    );
  }

  static Widget yearAndReason() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          FormWidget.question(question: AppContent.year, questionNo: 3),
          FormWidget.answer(
              controller:
                  TextEditingController(text: "Fourth ${AppContent.year}"),
              readOnly: true),
          FormWidget.question(question: AppContent.reason, questionNo: 4),
          const FormOptions(),
        ],
      ),
    );
  }



  static Widget selectTime(BuildContext ctx) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormWidget.question(
              question: AppContent.selectBetween, questionNo: 6),
          FormWidget.time(onChangeFrom: (datetime) {
            final from = DateFormat("hh:mm:ss").format(datetime);
            ctx.read<GatePassBloc>().add(FromTimeEvent(time: from));
          }, onChangeTo: (datetime) {
            final to = DateFormat("hh:mm:ss").format(datetime);
            ctx.read<GatePassBloc>().add(ToTimeEvent(time: to));
          })
        ],
      ),
    );
  }

  static Widget submit(String form) {
    return BlocBuilder<FormBloc, FormsState>(
      builder: (context, formState) {
        return BlocBuilder<GatePassBloc, GatePassState>(
          builder: (context, state) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authstate) {
                if (authstate is StudentLoadedState) {
                  return SliverToBoxAdapter(
                    child: FormWidget.elevatedButton(onPressed: () {
                      context.read<FormBloc>().add(CreateFormEvent(
                          department: authstate.student.department,
                          from: state.from,
                          studentClass: authstate.student.studentclass,
                          formtype: form,
                          name: authstate.student.name,
                          reason: state.reason,
                          spent: 100,
                          to: state.to,
                          year: authstate.student.year));
                    }),
                  );
                }
                return const SliverToBoxAdapter(
                  child: SizedBox.shrink(),
                );
              },
            );
          },
        );
      },
    );
  }
}
