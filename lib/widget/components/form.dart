import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class FormWidget {
  static Widget question(
      {int questionNo = 0,
      required String question,
      double top = 15,
      bool isAlphabet = false,
      String alphabet = ""}) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w, left: 20.w, top: top),
      child: Row(
        children: [
          Components.googleFonts(
              text: isAlphabet ? "$alphabet)" : "$questionNo.",
              fontSize: 14.sp,
              fontWeight: FontWeight.w600),
          SizedBox(
            width: isAlphabet ? 5.w : 10.w,
          ),
          Flexible(
            child: Components.googleFonts(
                text: question, fontSize: 14.sp, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  static Widget answer(
      {bool readOnly = false,
      required TextEditingController controller,
      bool autofocus = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Container(
        decoration: BoxDecoration(
            color: AppPalette.mette.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.sp)),
        child: TextField(
          autofocus: autofocus,
          style: Components.fontFamily(color: AppPalette.mette),
          readOnly: readOnly,
          controller: controller,
          decoration: const InputDecoration(
              border: InputBorder.none, contentPadding: EdgeInsets.all(10)),
        ),
      ),
    );
  }

  static Widget radioWidget(
      {required String title,
      required String value,
      required String groupValue,
      required void Function(String?)? onChanged}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Container(
        decoration: BoxDecoration(
            color: AppPalette.mette.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.sp)),
        child: RadioListTile<String>(
          activeColor: AppPalette.mette,
          title: Components.googleFonts(text: title),
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
      ),
    );
  }

  static Widget time(
      {required void Function(DateTime)? onChangeFrom,
      required void Function(DateTime)? onChangeTo}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TimePickerSpinnerPopUp(
            mode: CupertinoDatePickerMode.time,
            initTime: DateTime.now(),
            onChange: onChangeFrom,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Container(
              height: 2.h,
              width: 15.w,
              color: AppPalette.mette,
            ),
          ),
          TimePickerSpinnerPopUp(
            mode: CupertinoDatePickerMode.time,
            initTime: DateTime.now().add(const Duration(hours: 2)),
            onChange: onChangeTo,
          ),
        ],
      ),
    );
  }

  static Widget elevatedButton({required void Function()? onPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppPalette.mette,
              fixedSize: Size(double.infinity, 35.h)),
          onPressed: onPressed,
          child: Components.googleFonts(text: "Submit", color: Colors.white)),
    );
  }
}
