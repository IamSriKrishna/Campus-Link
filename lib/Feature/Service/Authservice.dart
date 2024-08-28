import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:campuslink/Feature/Screen/Auth/Login.dart';
import 'package:campuslink/Model/Student.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:campuslink/SplashScreen.dart';
import 'package:campuslink/Util/Additional/error_handling.dart';
import 'package:campuslink/Util/LocalNotification.dart';
import 'package:campuslink/Util/showsnackbar.dart';
import 'package:campuslink/Util/util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthService{
  void signUp(
  {
    required BuildContext context,
    required String rollNo,
    required String password,
    required String name,
    required String department,
    required File image,
    required String year,
    required String fcmtoken,
    required String studentclass
  }
  )async{
    try {
      
    final cloudinary = CloudinaryPublic('dadtmv9ma', 't154mm7k', cache: false);
      
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path, resourceType: CloudinaryResourceType.Image,folder: '$department Student Profile Image'),);
      Student user = Student(
        id: '',
        certified:false,
        bio:'',
        blocked: false,
        name: name,
        fcmtoken:fcmtoken,
        followers: [],
        following: [],
        dp:response.url,
        password: password,
        year: year,
        Studentclass: studentclass,
        rollno: rollNo,
        department: department,
        credit: 0,
        token: '',
      );
      //print(response.url);
      http.Response res = await http.post(
        Uri.parse('$uri/kcg/student/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      //print(res);
      //print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.pushNamed(context, Login.route).then((value) => Future.delayed(
            Duration(seconds: 1)
          ).then((value) => showSnackBar(
            context:context,
            text:'Account created! Login with the same credentials!',
          )));
          
        },
      );
      
    } catch (e) {
      showSnackBar( context:context,text: e.toString());
    }
  }
  // sign in user
  void signInUser({
    required BuildContext context,
    required String rollno,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/kcg/student/signin'),
        body: jsonEncode({
          'rollno': rollno,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      //(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<StudentProvider>(context, listen: false).setUser(res.body);
          final student = Provider.of<StudentProvider>(context,listen: false).user;
          await prefs.setString('studenttoken', student.token);
          await prefs.setString('userId', student.id);
          await prefs.setString('userName', student.name);
          await prefs.setString('userRoll', student.rollno);
          LocalNotifications.showSimpleNotification(
            title: "Campus Link",
            body: "Welcome Back, ${student.name}:)",
          );
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          await prefs.setString('LoggedIn', 'Logged');
          Navigator.pushNamedAndRemoveUntil(
            context,
            SplashScreen.route,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context:context,text: e.toString());
    }
  }

  // get user data
  Future<void> getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<StudentProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      //print(e);
    }
  }

  Future<void> signOutUser(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('x-auth-token');
    await prefs.setString('LoggedIn','LoggedOut');
  }

Future<List<Student>> searchStudentsByName(String name, String loggedInUserId) async {
  final response = await http.get(Uri.parse('$uri/students/search?name=$name'));
  //print(response.body);
  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    List<Student> students = jsonList.map((json) => Student.fromMap(json)).toList();

    // Filter out the logged-in user's data
    students = students.where((student) => student.id != loggedInUserId).toList();

    return students;
  } else if (response.statusCode == 404) {
    return []; 
  } else {
    throw Exception('Failed to fetch data');
  }
}
}