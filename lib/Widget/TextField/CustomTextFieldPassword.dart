import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldPassword extends StatefulWidget {
  final TextEditingController password;
  const CustomTextFieldPassword({super.key,required this.password});

  @override
  State<CustomTextFieldPassword> createState() => _CustomTextFieldPasswordState();
}

class _CustomTextFieldPasswordState extends State<CustomTextFieldPassword> {
  bool _isShow = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.5)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:8.0),
          child: TextField(
            style: GoogleFonts.merriweather(
              color: Colors.black,
              fontSize: 14
            ),
            controller: widget.password,
            obscureText: _isShow,
            decoration: InputDecoration(
              hintStyle: GoogleFonts.merriweather(
              color: Colors.black54,
              fontSize: 14
              ),
              labelStyle: GoogleFonts.merriweather(
              color: Colors.black54,
              fontSize: 14
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _isShow = !_isShow;
                  });
                },
                child: _isShow?Icon(Icons.visibility_off,color: Colors.black54,):Icon(Icons.visibility,color: Colors.black54,),
              ),
              labelText: 'Password',
              hintText: 'Password',
              border: InputBorder.none
            ),
          ),
        )),
    );
  }
}