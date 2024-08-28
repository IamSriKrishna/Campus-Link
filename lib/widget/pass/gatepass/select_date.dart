import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/gate_pass/gate_pass_bloc.dart';
import 'package:campuslink/bloc/gate_pass/gate_pass_event.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:campuslink/widget/components/form.dart';
import 'package:intl/intl.dart';

class DateSelectionWidget extends StatefulWidget {
  const DateSelectionWidget({super.key});

  @override
  _DateSelectionWidgetState createState() => _DateSelectionWidgetState();
}

class _DateSelectionWidgetState extends State<DateSelectionWidget> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormWidget.question(question: AppContent.selectDate, questionNo: 5),
          if (startDate != null && endDate != null)
            Column(
              children: [
                FormWidget.answer(
                    controller: TextEditingController(
                        text: DateFormat("dd-MM-yyyy").format(startDate!)),
                    readOnly: true),
                Container(
                  height: 10.h,
                  width: 2.w,
                  color: AppPalette.mette,
                ),
                FormWidget.answer(
                    controller: TextEditingController(
                        text: DateFormat("dd-MM-yyyy").format(endDate!)),
                    readOnly: true),
              ],
            )
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppPalette.mette,
                      minimumSize: Size(double.infinity, 35.h)),
                  onPressed: () {
                    showCustomDateRangePicker(
                      context,
                      dismissible: true,
                      minimumDate:
                      
                          DateTime.now(),
                      maximumDate: DateTime.now().add(const Duration(days: 30)),
                      endDate: endDate,
                      startDate: startDate,
                      backgroundColor: Colors.white,
                      primaryColor: AppPalette.mette,
                      onApplyClick: (start, end) {
                        setState(() {
                          startDate = start;
                          endDate = end;
                        });
                        context.read<GatePassBloc>().add(FromTimeEvent(
                            time: DateFormat("dd-MM-yyyy").format(startDate!)));
                        context.read<GatePassBloc>().add(ToTimeEvent(
                            time: DateFormat("dd-MM-yyyy").format(endDate!)));
                      },
                      onCancelClick: () {
                        setState(() {
                          startDate = null;
                          endDate = null;
                        });
                      },
                    );
                  },
                  child: Components.googleFonts(
                      text: "Select Date", color: Colors.white)),
            ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
