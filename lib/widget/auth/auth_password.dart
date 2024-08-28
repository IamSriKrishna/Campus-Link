import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/bloc/read_auth/read_auth_bloc.dart';
import 'package:campuslink/bloc/read_auth/read_auth_event.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:iconsax/iconsax.dart';

class AuthPassword extends StatefulWidget {
  const AuthPassword({super.key});

  @override
  State<AuthPassword> createState() => _AuthPasswordState();
}

class _AuthPasswordState extends State<AuthPassword> {
  bool isFocused = false;
  bool isObscure = true;
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

  void _toggleObscure() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Components.googleFonts(
          text: AppContent.password,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0.h),
          child: Container(
            decoration: BoxDecoration(
              color:
                  isFocused ? Colors.white : AppPalette.mette.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.sp),
              border: Border.all(
                color: isFocused ? AppPalette.mette : Colors.transparent,
              ),
            ),
            child: TextField(
              focusNode: _focusNode,
              onChanged: (value) {
                context
                    .read<ReadAuthBloc>()
                    .add(PasswordReadAuthEvent(password: value));
              },
              cursorColor: AppPalette.mette,
              obscureText: isObscure,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.sp),
                hintText: AppContent.password,
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscure ? Iconsax.eye_slash : Iconsax.eye,
                    color: AppPalette.mette,
                  ),
                  onPressed: _toggleObscure,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
