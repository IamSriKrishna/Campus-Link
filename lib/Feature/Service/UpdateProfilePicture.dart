import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:campuslink/Util/showsnackbar.dart';
import 'package:campuslink/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePicture {
  Future<void> UpdateProfilePicture(
      {required File image, required BuildContext context}) async {
    try {
      final cloudinary = CloudinaryPublic(
        'detkgq669',
        'r3drx2xg',
        cache: false,
      );
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image,
            folder: 'Student Profile Image'),
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? studentId = await prefs.getString('userId');
      final Map<String, dynamic> data = {'newDP': response.secureUrl};
      http.Response res = await http.Client()
          .put(Uri.parse('$uri/students/$studentId/update-dp'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(data));
      showSnackBar(context: context, text: 'Profile Picture Updated');
      if (res.statusCode == 200) {
        Navigator.pop(context);
      }
    } catch (error) {
      print(error);
    }
  }
}
