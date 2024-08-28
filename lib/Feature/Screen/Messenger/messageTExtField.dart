import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:provider/provider.dart';

class MessaginTextField extends StatelessWidget {
  const MessaginTextField({
    super.key,
    required this.messageController,
    required this.sufixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.onTapOutside,
    this.onSubmitted,
  });

  final TextEditingController messageController;
  final Widget sufixIcon;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return TextField(
      cursorColor: Colors.grey,
      controller: messageController,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      minLines: 1,
      style:GoogleFonts.nunito(
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(6.h),
        filled: true,
        suffixIcon: sufixIcon,
        hintText: "Type your message here",
        hintStyle: GoogleFonts.merriweather(
          fontSize: 13,
          color: theme.getDarkTheme?Colors.white:Colors.grey
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.h),
            ),
            borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.h),
            ),
            borderSide: BorderSide(color: Colors.grey)),
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
      onSubmitted: onSubmitted,
    );
  }
}
