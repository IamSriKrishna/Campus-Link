import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/bloc/form/form_bloc.dart';
import 'package:campuslink/bloc/form/form_state.dart';
import 'package:campuslink/bloc/gate_pass/gate_pass_bloc.dart';
import 'package:campuslink/bloc/gate_pass/gate_pass_event.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:campuslink/widget/pass/pass_widget.dart';

class PassScreen extends StatelessWidget {
  const PassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FormBloc, FormsState>(
        listener: (context, state) {
          if (state is SuccessFormsState) {
            Components.topSnackBar(context,
                text: AppContent.formSentSuccessfull);
            context.read<GatePassBloc>().add(ClearEvent());
          }
          if (state is FailedFormsState) {
            Components.topSnackBar(context,
                text: AppContent.somethingWentWrong);
          }
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            PassWidget.sliverAppBar(),
            PassWidget.date(),
            PassWidget.listForm(),
          ],
        ),
      ),
    );
  }
}
