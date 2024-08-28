import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/bloc/credit/credit_bloc.dart';
import 'package:campuslink/bloc/credit/credit_event.dart';
import 'package:campuslink/bloc/form/form_bloc.dart';
import 'package:campuslink/bloc/form/form_state.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:campuslink/widget/pass/gatepass/gate_pass_widget.dart';
import 'package:campuslink/widget/pass/gatepass/select_date.dart';
import 'package:get/get.dart';

class OtherPassScreen extends StatelessWidget {
  final String form;
  final int credit;
  const OtherPassScreen({super.key, required this.form, required this.credit});

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
                    GatePassWidget.appBar(form),
                    GatePassWidget.nameAndDept(),
                    GatePassWidget.yearAndReason(),
                    const DateSelectionWidget(),
                    GatePassWidget.submit(form),
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
