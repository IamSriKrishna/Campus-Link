import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:campuslink/controller/auth/auth_controller.dart';
import 'package:campuslink/model/user/user_model.dart';
import 'package:campuslink/model/student/student.dart';
import 'package:get_storage/get_storage.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _token;
  UserModel? _user;
  Student? _student;

  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;
  UserModel? get user => _user;
  Student? get student => _student;

  Future<void> loadUser() async {
    final box = GetStorage();
    final token = box.read('token');
    final userJsonString = box.read('user');

    if (token != null && userJsonString != null) {
      _isAuthenticated = true;
      _token = token;

      final Map<String, dynamic> userJson = jsonDecode(userJsonString);
      _user = UserModel.fromJson(userJson);

      // Fetch student data
      await refreshStudentData();
    } else {
      _isAuthenticated = false;
      _token = null;
      _user = null;
      _student = null;
    }
    notifyListeners();
  }

  Future<void> refreshStudentData() async {
    if (_user != null) {
      try {
        final student = await AuthController().getStudentById(_user!.id);
        _student = student;
        notifyListeners();
      } catch (e) {
        // Handle error, e.g., show error message
        debugPrint('Error fetching student data: $e');
      }
    }
  }

  void logout() async {
    final prefs = GetStorage();
    await prefs.remove('token');
    await prefs.remove('user');
    _isAuthenticated = false;
    _token = null;
    _user = null;
    _student = null;
    notifyListeners();
  }
}
