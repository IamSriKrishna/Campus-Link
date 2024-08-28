import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:campuslink/Util/showsnackbar.dart';
import 'package:campuslink/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PasswordService{
  //Change password Using Old Password
  Future<void> updatePassword( String newPassword,BuildContext context) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      final String apiUrl = '$uri/kcg/student/change-password';
      
      final Map<String, dynamic> requestBody = {
        'newPassword': newPassword,
      };

      final response = await http.put(
        Uri.parse(apiUrl),
        body: json.encode(requestBody),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      if (response.statusCode == 200) {
      showSnackBar(context: context, text: 'Profile Updated Successfully');
      Navigator.pop(context);
      } else if (response.statusCode == 400) {
        // Current password is incorrect
        print('Current password is incorrect');
      } else {
        // Handle other errors, e.g., server errors
        print('Error: ${response.statusCode}');
      }
    }catch(e){
      print('Error: ${e}');
    }
  }

  //Change password Using Old Password
  Future<void> changePassword(String newPassword) async {
    final String apiUrl = '$uri/kcg/student/change-password';

    final Map<String, dynamic> requestBody = {
      'newPassword': newPassword,
    };

    final response = await http.put(
      Uri.parse(apiUrl),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Password changed successfully
      //print('Password changed successfully');
    } else {
      // Handle errors, e.g., server errors
      //print('Error: ${response.statusCode}');
    }
  }
}