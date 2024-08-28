import 'package:dio/dio.dart';
import 'package:campuslink/db/profile_database.dart';
import 'package:campuslink/model/student/student.dart';
import 'package:campuslink/model/user/user_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/url.dart';
import 'package:campuslink/model/auth/auth.dart';
import 'dart:convert';

class AuthController {
  final Dio _dio = Dio();
  final ProfileDatabaseHelper _profileDatabaseHelper = ProfileDatabaseHelper();

  Future<bool> login({
    required int registerNumber,
    required String password,
  }) async {
    final Auth auth = Auth(registerNumber: registerNumber, password: password);
    try {
      Response res = await _dio.post(Url.login,
          data: auth.toJson(), options: Options(headers: AppContent.headers));
      if (res.statusCode == 200) {
        final user = UserModel.fromJson(res.data);
        final box = GetStorage();
        await box.write('token', user.token);
        await box.write('user', jsonEncode(res.data));
        await box.write('userId', user.id);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Student> getStudentById(String studentId) async {
    try {
      final response = await _dio.get('${Url.getStudentDataByID}/$studentId',
          options: Options(headers: AppContent.headers));
      if (response.statusCode == 200) {
        Student student = _parseJson(response.data);
        await _profileDatabaseHelper.saveProfileModel(student);
        return student;
      } else {
        throw Exception('Failed to load student');
      }
    } catch (e) {
      Student? student = await _profileDatabaseHelper.getProfileModel();
      if (student != null) {
        return student;
      } else {
        throw Exception('Failed to load data and no local data available');
      }
    }
  }

  Student _parseJson(Map<String, dynamic> json) => Student.fromJson(json);
}
