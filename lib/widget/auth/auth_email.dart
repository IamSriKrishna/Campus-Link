import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/read_auth/read_auth_bloc.dart';
import 'package:campuslink/bloc/read_auth/read_auth_event.dart';
import 'package:campuslink/widget/components/components.dart';

class AuthEmail extends StatefulWidget {
  const AuthEmail({super.key});

  @override
  State<AuthEmail> createState() => _AuthEmailState();
}

class _AuthEmailState extends State<AuthEmail> {
  bool isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Components.googleFonts(
          text: AppContent.registerNO,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0.h),
          child: Container(
            decoration: BoxDecoration(
              color: isFocused ? Colors.white : AppPalette.mette.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.sp),
              border: Border.all(
                color: isFocused ? AppPalette.mette : Colors.transparent,
              ),
            ),
            child: TextField(
              focusNode: _focusNode,
              onChanged: (value) {
                final int? registerNumber = int.tryParse(value);
                context.read<ReadAuthBloc>().add(RegisterNumberReadAuthEvent(registerNumber: registerNumber!));
              },
              cursorColor: AppPalette.mette,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.sp),
                hintText: AppContent.hintRegister,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        
      ],
    );
  }
}
