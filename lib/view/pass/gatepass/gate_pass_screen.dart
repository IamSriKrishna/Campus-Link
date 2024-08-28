import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/bloc/credit/credit_bloc.dart';
import 'package:campuslink/bloc/credit/credit_event.dart';
import 'package:campuslink/bloc/form/form_bloc.dart';
import 'package:campuslink/bloc/form/form_state.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:campuslink/widget/pass/gatepass/gate_pass_widget.dart';
import 'package:get/get.dart';

class GatePassScreen extends StatelessWidget {
  final int credit;
  const GatePassScreen({super.key, required this.credit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FormBloc, FormsState>(
        listener: (context, state) {
          if (state is ValidationFailedFormsState) {
            Components.topSnackBar(context,
                text: "${state.field.toString()} ${AppContent.fieldMissing}");
          }
          if (state is SuccessFormsState) {
            context.read<CreditBloc>().add(UpdateCreditEvent(credit: credit));
            Get.back();
          }
          if (state is FailedFormsState) {
            Get.back();
          }
        },
        child: BlocBuilder<FormBloc, FormsState>(
          builder: (context, state) {
            return Stack(
              children: [
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    GatePassWidget.appBar(AppContent.gatePass),
                    GatePassWidget.nameAndDept(),
                    GatePassWidget.yearAndReason(),
                    GatePassWidget.selectTime(context),
                    GatePassWidget.submit(AppContent.gatePass),
                  ],
                ),
                if (state is LoadingFormsState) Components.blurBackground(),
              ],
            );
          },
        ),
      ),
    );
  }
}
