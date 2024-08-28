import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/gate_pass/gate_pass_bloc.dart';
import 'package:campuslink/bloc/gate_pass/gate_pass_event.dart';
import 'package:campuslink/bloc/gate_pass/gate_pass_state.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:campuslink/widget/components/form.dart';

class FormOptions extends StatefulWidget {
  const FormOptions({super.key});

  @override
  State<FormOptions> createState() => _FormOptionsState();
}

class _FormOptionsState extends State<FormOptions> {
  String _selectedValue = "";
  bool _showTextField = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormWidget.radioWidget(
          title: AppContent.lunch,
          value: AppContent.lunch,
          groupValue: _selectedValue,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedValue = value;
                _showTextField = false;
                context.read<GatePassBloc>().add(ReasonEvent(reason: value));
              });
            }
          },
        ),
        FormWidget.radioWidget(
          title: AppContent.sick,
          value: AppContent.sick,
          groupValue: _selectedValue,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedValue = value;
                _showTextField = false;
                context.read<GatePassBloc>().add(ReasonEvent(reason: value));
              });
            }
          },
        ),
        FormWidget.radioWidget(
          title: AppContent.other,
          value: AppContent.other,
          groupValue: _selectedValue,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedValue = value;
                _showTextField = true;
              });
            }
          },
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          firstChild: Container(),
          secondChild: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Container(
              decoration: BoxDecoration(
                  color: AppPalette.mette.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.sp)),
              child: BlocBuilder<GatePassBloc, GatePassState>(
                builder: (context, state) {
                  return TextField(
                    minLines: 1,
                    maxLines: 10,
                    onChanged: (value) {
                      String reason =
                          _selectedValue == AppContent.other ? value : _selectedValue;
                      context
                          .read<GatePassBloc>()
                          .add(ReasonEvent(reason: reason));
                    },
                    cursorColor: AppPalette.mette,
                    style: Components.fontFamily(color: AppPalette.mette),
                    decoration: const InputDecoration(
                        hintText: AppContent.other,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10)),
                  );
                },
              ),
            ),
          ),
          crossFadeState: _showTextField
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
        ),
      ],
    );
  }
}
